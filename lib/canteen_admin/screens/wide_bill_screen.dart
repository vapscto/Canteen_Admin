import 'package:canteen_management/canteen_admin/admin_controller/admin_controller.dart';
import 'package:canteen_management/canteen_admin/model/item_model.dart';
import 'package:canteen_management/canteen_management/model/transation_his_model.dart';
import 'package:canteen_management/controller/global_utility.dart';
import 'package:canteen_management/main.dart';
import 'package:canteen_management/widgets/custom_appbar.dart';
import 'package:canteen_management/widgets/fade_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../canteen_management/api/item_list_api.dart';
import '../../canteen_management/controller/canteen_controller.dart';
import '../../controller/mskool_controller.dart';
import '../../widgets/animated_progress.dart';
import '../../widgets/m_skool_btn.dart';
import '../admin_api/admin_api.dart';

class WideBillScreen extends StatefulWidget {
  final MskoolController mskoolController;
  final int miId;

  const WideBillScreen(
      {super.key, required this.mskoolController, required this.miId});

  @override
  State<WideBillScreen> createState() => _WideBillScreenState();
}

class _WideBillScreenState extends State<WideBillScreen> {
  @override
  void initState() {
    super.initState();
    _onLoadData();
    filterList = controller.transationHistory;
    cardColors = List.generate(controller.transationHistory.length,
        (index) => lighterColor.elementAt(index % 6));
    textColors = List.generate(controller.transationHistory.length,
        (index) => noticeColor.elementAt(index % 6));
  }

  int bgColor = -1;
  AdminController controller = Get.put(AdminController());
  CanteenManagementController controller1 =
      Get.put(CanteenManagementController());
  List<Color> cardColors = [];
  List<Color> textColors = [];

  _onLoadData() async {
    isRefund = false;
    controller.itemListData.clear();
    selectedItemList.clear();
    controller.history(true);
    await AdminAPI.i.studentTransationData(
        controller: controller,
        base: baseUrlFromInsCode('canteen', widget.mskoolController),
        miId: widget.miId,
        acmstId: 0,
        counterId: counterId);
    controller.history(false);
    setState(() {
      cardColors = List.generate(controller.transationHistory.length,
          (index) => lighterColor.elementAt(index % 6));
      textColors = List.generate(controller.transationHistory.length,
          (index) => noticeColor.elementAt(index % 6));
    });
  }

  List<TransationHistoryModelValues>? filterList;

  _sortList(String value) {
    logger.i(value);
    if (value.isEmpty) {
      filterList = controller.transationHistory;
    } else {
      filterList = controller.transationHistory
          .where((i) =>
              i.cMOrderID.toString().contains(value) ||
              i.cMTRANSUpdateddate!.contains(value))
          .toList();
      setState(() {});
    }
  }

  final searchController = TextEditingController();

  List<ItemModel> selectedItemList = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    controller.itemListData.clear();
    selectedItemList.clear();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Wide Bill').getAppBar(),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              (controller.isHistoryLoading.value)
                  ? const Center(
                      child: AnimatedProgressWidget(
                          title: "Loading Transaction History",
                          desc: "",
                          animationPath: "assets/json/default.json"),
                    )
                  : (controller.transationHistory.isEmpty)
                      ? const Center(
                          child: AnimatedProgressWidget(
                            title: "Data is not available",
                            desc: "Transaction History is not available",
                            animationPath: "assets/json/nodata.json",
                            animatorHeight: 250,
                          ),
                        )
                      : SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height: 40,
                                child: TextFormField(
                                  controller: searchController,
                                  onChanged: (value) {
                                    _sortList(value);
                                  },
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  style: Get.textTheme.titleSmall,
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(6),
                                      hintText: "Search...",
                                      helperStyle: Get.textTheme.titleSmall!
                                          .copyWith(color: Colors.grey),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: const BorderSide(
                                              color: Colors.grey))),
                                ),
                              ),
                              (filterList!.isEmpty)
                                  ? const SizedBox()
                                  : Expanded(
                                      child: Scrollbar(
                                        controller: _scrollController,
                                        scrollbarOrientation:
                                            ScrollbarOrientation.right,
                                        thumbVisibility: true,
                                        thickness: 8,
                                        radius: const Radius.circular(8),
                                        child: ListView.separated(
                                          controller: _scrollController,
                                          clipBehavior: Clip.antiAlias,
                                          shrinkWrap: true,
                                          itemCount: filterList!.length,
                                          itemBuilder: (context, index) {
                                            return FadeInAnimation(
                                              delay: 1.0,
                                              direction: FadeInDirection.ttb,
                                              fadeOffset: index == 0
                                                  ? 80
                                                  : 80.0 * index,
                                              child: InkWell(
                                                onTap: () async {
                                                  controller.itemListData
                                                      .clear();
                                                  amountData = 0;
                                                  amountData2 = 0;
                                                  selectedItemList.clear();
                                                  isRefund = false;
                                                  await CanteeenCategoryAPI
                                                      .instance
                                                      .transationHistory(
                                                          canteenManagementController:
                                                              controller1,
                                                          base: baseUrlFromInsCode(
                                                              'canteen',
                                                              widget
                                                                  .mskoolController),
                                                          cmtransId:
                                                              filterList![index]
                                                                  .cMTRANSId!,
                                                          flag: (filterList![
                                                                          index]
                                                                      .cMTRANSPMPaymentMode ==
                                                                  'staff_wallet')
                                                              ? 'E'
                                                              : 'S')
                                                      .then((value) {
                                                    if (value != null) {
                                                      for (int i = 0;
                                                          i <
                                                              controller1
                                                                  .billModel
                                                                  .length;
                                                          i++) {
                                                        controller.itemListData.add(ItemModel(
                                                            aCMSTId: controller1
                                                                .billModel[i]
                                                                .aCMSTId,
                                                            aMSTFirstName: controller1
                                                                .billModel[i]
                                                                .aMSTFirstName,
                                                            cMTRANSTotalAmount:
                                                                controller1
                                                                    .billModel[
                                                                        i]
                                                                    .cMTRANSTotalAmount,
                                                            cMTransactionnum: controller1
                                                                .billModel[i]
                                                                .cMTransactionnum,
                                                            cMOrderID: controller1
                                                                .billModel[i]
                                                                .cMOrderID,
                                                            cMTRANSIName: controller1
                                                                .billModel[i]
                                                                .cMTRANSIName,
                                                            cMTRANSQty: controller1
                                                                .billModel[i]
                                                                .cMTRANSQty,
                                                            cMTRANSIUnitRate:
                                                                controller1
                                                                    .billModel[
                                                                        i]
                                                                    .cMTRANSIUnitRate,
                                                            isSelect: false,
                                                            paymentType:
                                                                filterList![index]
                                                                    .cMTRANSPMPaymentMode,
                                                            transactionId:
                                                                filterList![
                                                                        index]
                                                                    .cMTRANSId,
                                                            itemId: controller1
                                                                .billModel[i]
                                                                .itemId,
                                                            voidAmountFlag:
                                                                controller1
                                                                    .billModel[i]
                                                                    .voidItemFlag));
                                                      }
                                                      for (int j = 0;
                                                          j <
                                                              controller
                                                                  .itemListData
                                                                  .length;
                                                          j++) {
                                                        amountData = controller
                                                            .itemListData[j]
                                                            .cMTRANSTotalAmount!;
                                                      }
                                                      logger.w(controller
                                                          .itemListData.length);
                                                    } else {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              SnackBar(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .red,
                                                                  content:
                                                                      SelectableText(
                                                                    "Something went wrong",
                                                                    style: Get
                                                                        .textTheme
                                                                        .titleMedium!
                                                                        .copyWith(
                                                                            color:
                                                                                Colors.white),
                                                                  )));
                                                    }
                                                  });
                                                },
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  elevation: 2,
                                                  color: cardColors[index],
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            SelectableText(
                                                              "order ID:- ${filterList!.elementAt(index).cMOrderID}",
                                                              style: Get
                                                                  .textTheme
                                                                  .titleSmall,
                                                            ),
                                                            Text(
                                                              (filterList![index]
                                                                          .cMTRANSPMPaymentMode ==
                                                                      'staff_wallet')
                                                                  ? "Staff"
                                                                  : "Student",
                                                              style: Get
                                                                  .textTheme
                                                                  .titleSmall!
                                                                  .copyWith(
                                                                      color: textColors[
                                                                          index],
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                            )
                                                          ],
                                                        ),
                                                        Text(
                                                            "Total Amount:- ₹ ${filterList!.elementAt(index).cMTRANSTotalAmount}",
                                                            style: Get.textTheme
                                                                .titleSmall!
                                                                .copyWith(
                                                                    color: textColors[
                                                                        index])),
                                                        Text(
                                                            "Date:- ${dateFormat(DateTime.parse(filterList!.elementAt(index).cMTRANSUpdateddate!))} / Time:- ${DateFormat.jm().format(DateTime.parse(filterList!.elementAt(index).cMTRANSUpdateddate!))}",
                                                            style: Get.textTheme
                                                                .titleSmall),
                                                        Text(
                                                            "Mode Of Payment:- ${(filterList![index].cMTRANSPMPaymentMode == 'staff_wallet') ? "Staff Wallet" : (filterList![index].cMTRANSPMPaymentMode == 'student_wallet') ? "Student Wallet" : "PDA"}",
                                                            style: Get.textTheme
                                                                .titleSmall),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          separatorBuilder: (context, index) {
                                            return const SizedBox(height: 8);
                                          },
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
              (controller.itemListData.isEmpty)
                  ? const SizedBox()
                  : SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Column(children: [
                        SelectableText(
                          "Name:- ${controller.itemListData.first.aMSTFirstName} / Order ID:- ${controller.itemListData.first.cMOrderID}",
                          style: Get.textTheme.titleMedium!
                              .copyWith(color: Theme.of(context).primaryColor),
                        ),
                        const SizedBox(height: 10),
                        ...List.generate(controller.itemListData.length,
                            (index) {
                          final item = controller.itemListData[index];
                          return FadeInAnimation(
                            delay: 1.0,
                            direction: FadeInDirection.ltr,
                            fadeOffset: index == 0 ? 80 : 80.0 * index,
                            child: CheckboxListTile(
                              visualDensity: const VisualDensity(
                                  vertical: 0, horizontal: 0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                              selectedTileColor: Theme.of(context).primaryColor,
                              value: item.isSelect,
                              activeColor: Theme.of(context).primaryColor,
                              onChanged: controller
                                          .itemListData[index].voidAmountFlag !=
                                      true
                                  ? (value) async {
                                      item.isSelect = value;
                                      if (item.isSelect == true) {
                                        selectedItemList.add(item);
                                        amountData2 += item.cMTRANSIUnitRate! *
                                            item.cMTRANSQty!;
                                      } else {
                                        selectedItemList.remove(item);
                                        amountData2 -= item.cMTRANSIUnitRate! *
                                            item.cMTRANSQty!;
                                        controller.itemListData.refresh();
                                      }
                                      setState(() {});
                                    }
                                  : null,
                              title: SelectableText(
                                "${controller.itemListData[index].cMTRANSIName!}(Qty. ${controller.itemListData[index].cMTRANSQty})",
                                style: Get.textTheme.titleSmall,
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  children: [
                                    SelectableText(
                                      "₹ ${controller.itemListData[index].cMTRANSIUnitRate} ",
                                      style: Get.textTheme.titleSmall,
                                    ),
                                    (controller.itemListData[index]
                                                .voidAmountFlag ==
                                            true)
                                        ? Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              color: Colors.green,
                                            ),
                                            padding: const EdgeInsets.all(3),
                                            child: SelectableText(
                                              "Refunded",
                                              style: Get.textTheme.titleSmall!
                                                  .copyWith(
                                                      color: Colors.white,
                                                      fontSize: 11),
                                            ),
                                          )
                                        : const SizedBox()
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MSkollBtn(
                                title:
                                    "Refund Amount ₹ $amountData2", //₹ $amountData
                                onPress: () {
                                  if (selectedItemList.isEmpty) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                            content: SelectableText(
                                      "Select Item ",
                                      style: Get.textTheme.titleSmall,
                                    )));
                                    return;
                                  } else {
                                    setState(() {
                                      newData.clear();
                                      isRefund = !isRefund;
                                    });
                                  }
                                }),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    backgroundColor: Colors.red,
                                    elevation: 2),
                                onPressed: () {
                                  _onLoadData();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text(
                                    "Cancel",
                                    style: Get.textTheme.titleMedium!
                                        .copyWith(color: Colors.white),
                                  ),
                                ))
                          ],
                        ),
                        (isRefund == true)
                            ? Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: MSkollBtn(
                                    title:
                                        "Refund To ${(controller.itemListData.first.paymentType == 'staff_wallet' || controller.itemListData.first.paymentType == 'student_wallet') ? "Wallet" : "PDA"}",
                                    onPress: () async {
                                      newData.clear();
                                      for (var i in selectedItemList) {
                                        newData.add({
                                          "itemCount": i.cMTRANSQty,
                                          "CMTRANSI_name": i.cMTRANSIName,
                                          "unitRate": i.cMTRANSIUnitRate!,
                                          "cmmfI_Id": i.itemId
                                        });
                                      }
                                      await AdminAPI.i.refundAmount(
                                          controller: controller,
                                          base: baseUrlFromInsCode('canteen',
                                              widget.mskoolController),
                                          body: {
                                            "CMMCO_Id": counterId,
                                            "AMST_Id":
                                                selectedItemList.first.aCMSTId,
                                            "mode_payment": selectedItemList
                                                .first.paymentType,
                                            "CMTRANS_Id": selectedItemList
                                                .first.transactionId,
                                            "voidamountCMTransactionItems":
                                                newData
                                          });
                                      _onLoadData();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: SelectableText(
                                        "₹ $amountData2 Amount Refunded",
                                        style: Get.textTheme.titleSmall!
                                            .copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                      )));
                                    }),
                              )
                            : const SizedBox(),
                      ]),
                    ),
            ],
          ),
        );
      }),
    );
  }

  List<Map<String, dynamic>> newData = [];
  bool isRefund = false;
  String selectedValue = '';
  List<String> data = ['PDA']; //'Cash',
  double amountData = 0;
  double amountData2 = 0;

  addAmount(double amount) {
    amountData += amount;
    setState(() {});
  }

  removeAmount(double amount) {
    amountData -= amount;
    setState(() {});
  }

  List<double> totalAddAmount = [];

  addAmount1(double amount, int index) {
    totalAddAmount[index] = 0;
    amountData = 0;
    setState(() {
      totalAddAmount[index] = amount;
    });
    for (int i = 0; i < totalAddAmount.length; i++) {
      amountData += totalAddAmount[i];
    }
  }

  remove1(double amount, int index) {
    totalAddAmount[index] = 0;
    amountData = 0;
    setState(() {
      totalAddAmount[index] = amount;
    });
    for (int i = 0; i < totalAddAmount.length; i++) {
      amountData -= totalAddAmount[i];
    }
  }
}
