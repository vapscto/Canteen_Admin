import 'package:canteen_management/canteen_management/screens/kiosk_bill_generate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/global_utility.dart';
import '../../controller/mskool_controller.dart';
import '../../widgets/animated_progress.dart';
import '../api/item_list_api.dart';
import '../controller/canteen_controller.dart';

class TransationHistory extends StatefulWidget {
  final CanteenManagementController controller;
  final MskoolController mskoolController;
  final int miId;

  const TransationHistory(
      {super.key,
      required this.controller,
      required this.mskoolController,
      required this.miId});

  @override
  State<TransationHistory> createState() => _TransationHistoryState();
}

class _TransationHistoryState extends State<TransationHistory> {
  int bgColor = -1;

  _loadData() async {
    widget.controller.historyLoading(true);
    await CanteeenCategoryAPI.instance.studentTransationData(
        base: baseUrlFromInsCode('canteen', widget.mskoolController),
        canteenManagementController: widget.controller,
        miId: widget.miId,
        acmstId: widget.controller.cardReaderList.last.aMSTId!, flag:widget.controller.cardReaderList.last.flag??'');
    widget.controller.historyLoading(false);
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Transaction History",
          style: Get.textTheme.titleSmall!.copyWith(color: Colors.white),
        ),
        centerTitle: false,
        leading: IconButton(
            onPressed: () async {
              // await cancelTransaction(
              //     base: baseUrlFromInsCode('canteen', widget.mskoolController),
              //     body: {
              //       "MI_Id": widget.miId,
              //       "AMST_Id": widget.controller.cardReaderList.last.aMSTId
              //     }).then((value) {
              //   if (value == 200) {
                  Get.back();
              //   }
              // });
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),
      // appBar: const CustomAppBar(title: "Transaction History").getAppBar(),
      body: Obx(() {
        return (widget.controller.isHistory.value)
            ? const Center(
                child: AnimatedProgressWidget(
                    title: "Loading Transaction History",
                    desc: "",
                    animationPath: "assets/json/default.json"),
              )
            : (widget.controller.transationHistory.isEmpty)
                ? const Center(
                    child: AnimatedProgressWidget(
                      title: "Data is not available",
                      desc: "Transaction History is not available",
                      animationPath: "assets/json/nodata.json",
                      animatorHeight: 250,
                    ),
                  )
                : Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ListView.separated(
                            padding: const EdgeInsets.all(16),
                            itemBuilder: (_, index) {
                              bgColor += 1;
                              if (bgColor % 6 == 0) {
                                bgColor = 0;
                              }
                              var data = widget.controller.transationHistory
                                  .elementAt(index);
                              return InkWell(
                                onTap: () async {
                                  await CanteeenCategoryAPI.instance
                                      .transationHistory(
                                          canteenManagementController:
                                              widget.controller,
                                          base: baseUrlFromInsCode('canteen',
                                              widget.mskoolController),
                                          cmtransId: data.cMTRANSId!,flag: widget.controller.cardReaderList.last.flag!)
                                      .then((value) {
                                    if (value != null) {
                                      GenerateBillKiosk.instance.generateNow(
                                          controller: widget.controller,
                                          date: data.cMTRANSUpdateddate!,mskoolController: widget.mskoolController);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              backgroundColor: Colors.red,
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
                                      borderRadius: BorderRadius.circular(8.0),
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
                                            child: Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Order ID:- ',
                                                    style: Get
                                                        .textTheme.titleSmall!
                                                        .copyWith(
                                                            color: noticeColor
                                                                .elementAt(
                                                                    bgColor)),
                                                  ),
                                                  TextSpan(
                                                    text: data.cMOrderID
                                                        .toString(),
                                                    style: Get
                                                        .textTheme.titleSmall!
                                                        .copyWith(
                                                            color: noticeColor
                                                                .elementAt(
                                                                    bgColor)),
                                                  ),
                                                ],
                                              ),
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
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Transaction ID:- ',
                                              style: Get.textTheme.titleSmall,
                                            ),
                                            TextSpan(
                                              text: data.cMTransactionnum
                                                  .toString(),
                                              style: Get.textTheme.titleSmall,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 3),
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Date:- ',
                                              style: Get.textTheme.titleSmall,
                                            ),
                                            TextSpan(
                                              text: dateFormat(DateTime.parse(
                                                  data.cMTRANSUpdateddate!)),
                                              style: Get.textTheme.titleSmall,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (_, index) {
                              return const SizedBox(height: 8);
                            },
                            itemCount:
                                widget.controller.transationHistory.length),
                      ),
                      // Column(
                      //   children: [
                      //     Align(
                      //       alignment: Alignment.topLeft,
                      //       child: IconButton(
                      //           onPressed: () {},
                      //           icon: const Icon(
                      //             Icons.print,
                      //             color: Colors.black,
                      //           )),
                      //     )
                      //   ],
                      // )
                    ],
                  );
      }),
    );
  }

  String dateFormat(DateTime dt) {
    return '${dt.day}-${dt.month}-${dt.year}';
  }
}
