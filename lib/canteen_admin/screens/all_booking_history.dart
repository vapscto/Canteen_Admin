import 'package:canteen_management/canteen_admin/admin_api/admin_api.dart';
import 'package:canteen_management/canteen_management/controller/canteen_controller.dart';
import 'package:canteen_management/controller/mskool_controller.dart';
import 'package:canteen_management/main.dart';
import 'package:canteen_management/widgets/custom_appbar.dart';
import 'package:canteen_management/widgets/fade_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../canteen_management/api/item_list_api.dart';
import '../../canteen_management/model/transation_his_model.dart';
import '../../controller/global_utility.dart';
import '../../widgets/animated_progress.dart';
import '../admin_controller/admin_controller.dart';
import '../widgets/admin_generate_bill.dart';

class AllBookingHistory extends StatefulWidget {
  final AdminController controller;
  final MskoolController mskoolController;
  final int miId;

  const AllBookingHistory(
      {super.key,
      required this.controller,
      required this.mskoolController,
      required this.miId});

  @override
  State<AllBookingHistory> createState() => _AllBookingHistoryState();
}

class _AllBookingHistoryState extends State<AllBookingHistory> {
  final searchController = TextEditingController();
  final fromDateController = TextEditingController();
  final toDateController = TextEditingController();
  DateTime? fromDate;
  DateTime? toDate;
  List<TransationHistoryModelValues>? filterList;
  CanteenManagementController controller =
      Get.put(CanteenManagementController());

  _onLoad() async {
    widget.controller.history(true);
    await AdminAPI.i.studentTransationData(
        controller: widget.controller,
        base: baseUrlFromInsCode('canteen', widget.mskoolController),
        miId: widget.miId,
        acmstId: 0,
        counterId: counterId);
    widget.controller.history(false);
  }

  _sortList(String value) {
    logger.i(value);
    if (value.isEmpty) {
      filterList = widget.controller.transationHistory;
    } else {
      filterList = widget.controller.transationHistory
          .where((i) => i.cMOrderID.toString().contains(value))
          .toList();
      setState(() {});
    }
  }

  @override
  void initState() {
    _onLoad();
    filterList = widget.controller.transationHistory;
    super.initState();
  }

  int bgColor = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Booking History").getAppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: TextField(
                    controller: searchController,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: (value) {
                      _sortList(value);
                    },
                    style: Get.textTheme.titleSmall,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(5),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor)),
                      hintText: 'Search By Order Id...',
                      hintStyle: Get.textTheme.titleSmall!
                          .copyWith(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Obx(() {
            return Expanded(
                child: (widget.controller.isHistoryLoading.value)
                    ? const Center(
                        child: AnimatedProgressWidget(
                            title: "Loading Transaction History",
                            desc: "",
                            animationPath: "assets/json/default.json"),
                      )
                    : (filterList!.isEmpty)
                        ? const Center(
                            child: AnimatedProgressWidget(
                              title: "Data is not available",
                              desc: "Transaction History is not available",
                              animationPath: "assets/json/nodata.json",
                              animatorHeight: 250,
                            ),
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.all(16),
                            itemCount: filterList!.length,
                            itemBuilder: (context, index) {
                              bgColor += 1;
                              if (bgColor % 6 == 0) {
                                bgColor = 0;
                              }
                              var data = filterList!.elementAt(index);
                              return FadeInAnimation(
                                delay: 1.0,
                                direction: FadeInDirection.ttb,
                                fadeOffset: index == 0 ? 80 : 80.0 * index,
                                child: InkWell(
                                  onTap: () async {
                                    await CanteeenCategoryAPI.instance
                                        .transationHistory(
                                            canteenManagementController:
                                                controller,
                                            base: baseUrlFromInsCode('canteen',
                                                widget.mskoolController),
                                            cmtransId: data.cMTRANSId!,
                                            flag: (data.cMTRANSPMPaymentMode ==
                                                    'staff_wallet')
                                                ? 'E'
                                                : 'S')
                                        .then((value) {
                                      if (value != null) {
                                        AdminGenerateBill.instance.generateNow(
                                            controller: controller,
                                            date: data.cMTRANSUpdateddate!,
                                            mskoolController:
                                                widget.mskoolController,
                                            paymentType:
                                                data.cMTRANSPMPaymentMode!);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                backgroundColor: Colors.green,
                                                content: Text(
                                                  "Something went wrong",
                                                  style: Get
                                                      .textTheme.titleMedium!
                                                      .copyWith(
                                                          color: Colors.white),
                                                )));
                                      }
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 8),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        color: lighterColor.elementAt(bgColor),
                                        boxShadow: const [
                                          BoxShadow(
                                              offset: Offset(1, 2.1),
                                              blurRadius: 0,
                                              spreadRadius: 0,
                                              color: Colors.black12)
                                        ]),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: SelectableText(
                                                "Order ID:- ${data.cMOrderID}",
                                                style: Get.textTheme.titleSmall!
                                                    .copyWith(
                                                        color: noticeColor
                                                            .elementAt(
                                                                bgColor)),
                                              ),
                                            ),
                                            Text(
                                              '₹ ${data.cMTRANSTotalAmount}',
                                              style: Get.textTheme.titleSmall!
                                                  .copyWith(
                                                      color: noticeColor
                                                          .elementAt(bgColor)),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 3),
                                        SelectableText("Transaction ID:- ${data.cMTransactionnum}",style: Get.textTheme.titleSmall,),

                                        const SizedBox(height: 3),
                                        Text(
                                          "Date:- ${dateFormat(DateTime.parse(filterList!.elementAt(index).cMTRANSUpdateddate!))} / Time:- ${DateFormat.jm().format(DateTime.parse(filterList!.elementAt(index).cMTRANSUpdateddate!))}",
                                          style: Get.textTheme.titleSmall,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 8);
                            },
                          ));
          })
        ],
      ),
    );
  }
}
