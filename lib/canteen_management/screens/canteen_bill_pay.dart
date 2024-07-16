import 'dart:async';

import 'package:canteen_management/canteen_admin/model/counter_wise_food_model.dart';
import 'package:canteen_management/canteen_management/api/item_list_api.dart';
import 'package:canteen_management/canteen_management/screens/kiosk_bill_generate.dart';
import 'package:canteen_management/controller/global_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/mskool_controller.dart';
import '../../main.dart';
import '../constants/canteen_constants.dart';
import '../controller/canteen_controller.dart';
import '../widgets/qr_code_widget.dart';

class CanteenBillPay extends StatefulWidget {
  final List<CounterWiseFoodModelValues> data;
  final CanteenManagementController controller;

  // final LoginSuccessModel loginSuccessModel;
  final MskoolController mskoolController;
  final int miId;

  const CanteenBillPay(
      {super.key,
      required this.data,
      required this.controller,
      // required this.loginSuccessModel,
      required this.mskoolController,
      required this.miId});

  @override
  State<CanteenBillPay> createState() => _CanteenBillPayState();
}

class _CanteenBillPayState extends State<CanteenBillPay> {
  int minutes = 1;
  int seconds = 59;
  bool timerOver = false;
  late Timer _timer;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (seconds > 0) {
        seconds--;
        setState(() {});
      } else {
        if (minutes > 0) {
          minutes--;
          seconds = 59;
          setState(() {});
        } else {
          timerOver = true;
          await cancelTransaction(
              base: baseUrlFromInsCode('canteen', widget.mskoolController),
              body: {
                "MI_Id": widget.miId,
                "AMST_Id": widget.controller.cardReaderList.last.aMSTId
              }).then((value) {
            if (value == 200) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(
                    "Transaction Cancelled",
                    style:
                        Get.textTheme.titleSmall!.copyWith(color: Colors.white),
                  )));
              Get.back();
              timer.cancel();
              setState(() {});
            }
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String selectedValue = '';
  List<String> data = ['Cash', 'OnLine'];
  bool isWallet = false;
  bool isButton = false;

  _onLoad() {
    for (int i = 0; i < widget.controller.addToCartList.length; i++) {
      numberOfItems.add(1);
      totalAddAmount.add(widget.controller.addToCartList[i].cmmfIUnitRate!);
      addAmount(numberOfItems[i], totalAddAmount[i], i);
    }
  }

  @override
  void initState() {
    _onLoad();
    startTimer();

    super.initState();
  }

  List<int> numberOfItems = [];
  List<double> totalAddAmount = [];
  double amountData = 0;

  addAmount(int count, double amount, int index) {
    double d = count.toDouble();
    totalAddAmount[index] = 0;
    amountData = 0;
    setState(() {
      totalAddAmount[index] = amount * d;
    });
    for (int i = 0; i < totalAddAmount.length; i++) {
      amountData += totalAddAmount[i];
    }
  }

  _addItem(int index) {
    setState(() {
      numberOfItems[index]++;
    });
  }

  _removeItem(int index) {
    setState(() {
      numberOfItems[index]--;
    });
  }

  String selectedId = '0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            // await cancelTransaction(
            //     base: baseUrlFromInsCode('canteen', widget.mskoolController),
            //     body: {
            //       "MI_Id": widget.miId,
            //       "AMST_Id": widget.controller.cardReaderList.last.aMSTId
            //     }).then((value) {
            //   if (value == 200) {
            //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //         backgroundColor: Colors.red,
            //         content: Text(
            //           "Transaction Cancelled",
            //           style: Get.textTheme.titleSmall!
            //               .copyWith(color: Colors.white),
            //         )));
                Get.back();
            //   }
            // });
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        centerTitle: false,
        title: Text(
          'My Cart',
          style: Get.textTheme.titleMedium!.copyWith(color: Colors.white),
        ),
        elevation: 0,
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: ListView(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Text(
                    "Time Remaining: $minutes:${seconds.toString().padLeft(2, '0')}",
                    style: Get.textTheme.titleSmall),
              ),
              const SizedBox(height: 10),
              ...List.generate(widget.controller.addToCartList.length, (index) {
                var v = widget.controller.addToCartList.elementAt(index);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                v.cmmfIPathURL ?? '',
                                fit: BoxFit.fill,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container();
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  v.cmmfIFoodItemName!.toUpperCase(),
                                  style: Get.textTheme.titleMedium,
                                ),
                                Text(
                                  ' ₹ ${v.cmmfIUnitRate}',
                                  style: Get.textTheme.titleSmall,
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                      onTap: () async {
                                        setState(() {
                                          if (numberOfItems[index] > 1) {
                                            _removeItem(index);
                                          }
                                        });
                                        await addAmount(numberOfItems[index],
                                            (v.cmmfIUnitRate!), index);
                                      },
                                      child: Icon(
                                        Icons.remove_circle_outline,
                                        color: Theme.of(context).primaryColor,
                                        size: 30,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                      numberOfItems[index].toString(),
                                      style: Get.textTheme.titleSmall,
                                    ),
                                  ),
                                  InkWell(
                                      onTap: () async {
                                        setState(() {
                                          if (numberOfItems[index] <= 4) {
                                            _addItem(index);
                                          }
                                        });
                                        await addAmount(numberOfItems[index],
                                            v.cmmfIUnitRate!, index);
                                      },
                                      child: Icon(
                                        Icons.add_circle_outline,
                                        color: Theme.of(context).primaryColor,
                                        size: 30,
                                      )),
                                ],
                              ),
                              Text(totalAddAmount[index].toString()),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                ),
                                onPressed: () async {
                                  _removeItemData(index);
                                  if (widget.controller.addToCartList.isEmpty) {
                                    await cancelTransaction(
                                        base: baseUrlFromInsCode(
                                            'canteen', widget.mskoolController),
                                        body: {
                                          "MI_Id": widget.miId,
                                          "AMST_Id": widget.controller
                                              .cardReaderList.last.aMSTId
                                        }).then((value) {
                                      if (value == 200) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                backgroundColor: Colors.red,
                                                content: Text(
                                                  "Transaction Cancelled",
                                                  style: Get
                                                      .textTheme.titleSmall!
                                                      .copyWith(
                                                          color: Colors.white),
                                                )));
                                        Get.back();
                                      }
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'Total Item:',
                                          style: Get.textTheme.titleSmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.w400)),
                                      TextSpan(
                                          text:
                                              ' ${widget.controller.addToCartList.length}',
                                          style: Get.textTheme.titleSmall!.copyWith(
                                              // color: Theme.of(context).primaryColor
                                              )),
                                    ],
                                  ),
                                ),
                                (widget.controller.addToCartList.isEmpty)
                                    ? const SizedBox()
                                    : (widget.controller.cardReaderList.isEmpty)?const SizedBox(): (widget.controller.cardReaderList.last
                                                .flag!
                                                .toLowerCase() ==
                                            's')
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                        text: 'PDA Amount:- ',
                                                        style: Get.textTheme
                                                            .titleSmall!
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400)),
                                                    TextSpan(
                                                        text: (widget
                                                                .controller
                                                                .cardReaderList
                                                                .isNotEmpty)
                                                            ? ' ₹ ${widget.controller.cardReaderList.last.pDAAmount ?? 0.0}'
                                                            : ' ₹ 0',
                                                        style: Get.textTheme
                                                            .titleSmall!
                                                            .copyWith(
                                                                // color: Theme.of(context).primaryColor
                                                                )),
                                                  ],
                                                ),
                                              ),
                                              Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                        text: 'Wallet Amount:-',
                                                        style: Get.textTheme
                                                            .titleSmall!
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400)),
                                                    TextSpan(
                                                        text: (widget
                                                                .controller
                                                                .cardReaderList
                                                                .isNotEmpty)
                                                            ? ' ₹ ${widget.controller.cardReaderList.last.walletamount ?? 0.0}'
                                                            : ' ₹ 0',
                                                        style: Get.textTheme
                                                            .titleSmall!
                                                            .copyWith(
                                                                // color: Theme.of(context).primaryColor
                                                                )),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        : Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                    text: 'Wallet Amount:-',
                                                    style: Get
                                                        .textTheme.titleSmall!
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400)),
                                                TextSpan(
                                                    text: (widget
                                                            .controller
                                                            .cardReaderList
                                                            .isNotEmpty)
                                                        ? ' ₹ ${widget.controller.cardReaderList.last.walletamount ?? 0.0}'
                                                        : ' ₹ 0',
                                                    style: Get
                                                        .textTheme.titleSmall!
                                                        .copyWith(
                                                            // color: Theme.of(context).primaryColor
                                                            )),
                                              ],
                                            ),
                                          ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Total Amount:-   ",
                                      style: Get.textTheme.titleSmall,
                                    ),
                                    Text(
                                      ' ₹ $amountData',
                                      //${calculateGST(amountData, 5).toStringAsFixed(2)}
                                      style: Get.textTheme.titleSmall,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Select Payment Mode",
                                  style: Get.textTheme.titleSmall!.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.red),
                                ),
                                ...List.generate(newPaymentMode.length,
                                    (index) {
                                  return Theme(
                                    data: ThemeData(
                                        unselectedWidgetColor:
                                            Theme.of(context).primaryColor),
                                    child: SizedBox(
                                      width: 150,
                                      height: 40,
                                      child: RadioListTile(
                                          selectedTileColor:
                                              Theme.of(context).primaryColor,
                                          activeColor:
                                              Theme.of(context).primaryColor,
                                          title: Text(
                                            newPaymentMode[index]['name'],
                                            style: Get.textTheme.titleSmall,
                                          ),
                                          contentPadding: EdgeInsets.zero,
                                          visualDensity: const VisualDensity(
                                              vertical: 0, horizontal: 0),
                                          value: newPaymentMode[index]['id'],
                                          groupValue: paymentMode,
                                          onChanged: (value) {
                                            setState(() {
                                              paymentMode =
                                                  newPaymentMode[index]['id'];
                                              widget.controller.paymentMode =
                                                  paymentMode;
                                              if (widget.controller
                                                      .cardReaderList.last.flag!
                                                      .toLowerCase() ==
                                                  's') {
                                                if (newPaymentMode[index]
                                                        ['name'] ==
                                                    "PDA") {
                                                  widget.controller
                                                      .paymentName = 'pda';
                                                } else if (newPaymentMode[index]
                                                        ['name'] ==
                                                    "Wallet") {
                                                  widget.controller
                                                          .paymentName =
                                                      'student_wallet';
                                                } else {
                                                  widget.controller
                                                          .paymentName =
                                                      newPaymentMode[index]
                                                          ['name'];
                                                }
                                              } else {
                                                if (newPaymentMode[index]
                                                        ['name'] ==
                                                    "PDA") {
                                                  widget.controller
                                                      .paymentName = 'pda';
                                                } else if (newPaymentMode[index]
                                                        ['name'] ==
                                                    "Wallet") {
                                                  widget.controller
                                                          .paymentName =
                                                      'staff_wallet';
                                                } else {
                                                  widget.controller
                                                          .paymentName =
                                                      newPaymentMode[index]
                                                          ['name'];
                                                }
                                              }
                                              logger.i(paymentMode);
                                              setState(() {
                                                isQr = false;
                                              });
                                            });
                                          }),
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          alignment: Alignment.topCenter,
                          child: GestureDetector(
                            onTap: () async {
                              if (paymentMode.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        content: Text(
                                  "Please Select Payment Mode",
                                  style: Get.textTheme.titleMedium,
                                )));
                              } else {
                                widget.controller.itemDetails.clear();
                                for (int index = 0;
                                    index <
                                        widget.controller.addToCartList.length;
                                    index++) {
                                  widget.controller.itemDetails.add({
                                    "itemCount": numberOfItems[index],
                                    "CMTRANSI_name": widget.controller
                                        .addToCartList[index].cmmfIFoodItemName,
                                    "unitRate": widget.controller
                                        .addToCartList[index].cmmfIUnitRate,
                                    "cmmfI_Id": widget
                                        .controller.addToCartList[index].cmmfIId
                                  });
                                }
                                logInBox!.put("isFirstTime", false);
                                if (paymentMode == '1') {
                                  if (widget.controller.cardReaderList.last
                                          .flag!.toLowerCase() ==
                                      's') {
                                    if (widget
                                        .controller.cardReaderList.isNotEmpty) {
                                      if (widget.controller.cardReaderList.last
                                                  .pDAAmount !=
                                              null &&
                                          double.parse(amountData.toString()) <=
                                              widget.controller.cardReaderList
                                                  .last.pDAAmount!) {
                                        await deductAmount(
                                            base: baseUrlFromInsCode('canteen',
                                                widget.mskoolController),
                                            controller: widget.controller,
                                            data: {
                                              "CMMCO_Id": counterId,
                                              "MI_Id": widget.miId,
                                              "AMST_Id": widget.controller
                                                  .cardReaderList.last.aMSTId,
                                              "ASMAY_Id": widget.controller
                                                  .cardReaderList.last.aSMAYId,
                                              "mode_payment":
                                                  widget.controller.paymentName,
                                              "CMTRANS_Amount":
                                                  amountData.toString(),
                                              "CMTransactionItems":
                                                  widget.controller.itemDetails,
                                              "CMTransactionPaymentMode": [
                                                {
                                                  "CMTRANSPM_PaymentModeId":
                                                      widget.controller
                                                          .paymentMode,
                                                  "CMTRANSPM_PaymentMode":
                                                      widget.controller
                                                          .paymentName
                                                }
                                              ]
                                            }).then((value) async {
                                          if (value != 0) {
                                            widget.controller.addToCartList.clear();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    backgroundColor:
                                                        Colors.green,
                                                    content: Text(
                                                      "Amount Deducted Successfully",
                                                      style: Get.textTheme
                                                          .titleMedium!
                                                          .copyWith(
                                                              color:
                                                                  Colors.white),
                                                    )));

                                            await CanteeenCategoryAPI.instance
                                                .transationHistory(
                                                    canteenManagementController:
                                                        widget.controller,
                                                    base: baseUrlFromInsCode(
                                                        'canteen',
                                                        widget
                                                            .mskoolController),
                                                    cmtransId: widget.controller
                                                        .transactionId,
                                                    flag: widget
                                                        .controller
                                                        .cardReaderList
                                                        .last
                                                        .flag!)
                                                .then((value) {
                                              if (value != null) {
                                                GenerateBillKiosk.instance
                                                    .generateNow(
                                                  controller: widget.controller,
                                                  mskoolController:
                                                      widget.mskoolController,
                                                  date: DateTime.now()
                                                      .toIso8601String(),
                                                );
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        backgroundColor:
                                                            Colors.red,
                                                        content: Text(
                                                          "Something went wrong",
                                                          style: Get.textTheme
                                                              .titleMedium!
                                                              .copyWith(
                                                                  color: Colors
                                                                      .white),
                                                        )));
                                              }
                                            });
                                            widget.controller.addToCartList
                                                .clear();
                                            widget.controller.cardReaderList
                                                .clear();
                                            await CanteeenCategoryAPI.instance
                                                .getCanteenItems(
                                              canteenManagementController:
                                                  widget.controller,
                                              base: baseUrlFromInsCode(
                                                  'canteen',
                                                  widget.mskoolController),
                                              miId: widget.miId,
                                              categoryId: 0, counterId: 0,
                                            );
                                          } else {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "Unable to Deduct Amount",
                                                      style: Get.textTheme
                                                          .titleMedium,
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    Align(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text(
                                                            'Close',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: Get.textTheme
                                                                .titleMedium!
                                                                .copyWith(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColor),
                                                          )),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          }
                                      });
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            elevation: 2,
                                            content: Text(
                                              "In-Sufficient Amount",
                                              style: Get.textTheme.titleSmall!
                                                  .copyWith(
                                                      color: Colors.white),
                                            ),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          elevation: 2,
                                          content: Text(
                                            "PDA Amount is Zero",
                                            style: Get.textTheme.titleSmall!
                                                .copyWith(color: Colors.white),
                                          ),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                        'Staff has no PDA Account Please Select Wallet',
                                        style: Get.textTheme.titleSmall!
                                            .copyWith(color: Colors.white),
                                      ),
                                      backgroundColor: Colors.red,
                                    ));
                                  }
                                } else if (paymentMode == '2') {
                                  if (widget.controller.cardReaderList.last
                                          .flag!.toLowerCase() ==
                                      's') {
                                    if (widget
                                        .controller.cardReaderList.isNotEmpty) {
                                      if (widget.controller.cardReaderList.last
                                                  .walletamount !=
                                              null &&
                                          double.parse(amountData.toString()) <=
                                              widget.controller.cardReaderList
                                                  .last.walletamount!) {
                                        await deductAmount(
                                            base: baseUrlFromInsCode('canteen',
                                                widget.mskoolController),
                                            controller: widget.controller,
                                            data: {
                                              "CMMCO_Id": counterId,
                                              "MI_Id": widget.miId,
                                              "AMST_Id": widget.controller
                                                  .cardReaderList.last.aMSTId,
                                              "ASMAY_Id": widget.controller
                                                  .cardReaderList.last.aSMAYId,
                                              "mode_payment":
                                                  widget.controller.paymentName,
                                              "CMTRANS_Amount":
                                                  amountData.toString(),
                                              "CMTransactionItems":
                                                  widget.controller.itemDetails,
                                              "CMTransactionPaymentMode": [
                                                {
                                                  "CMTRANSPM_PaymentModeId":
                                                      widget.controller
                                                          .paymentMode,
                                                  "CMTRANSPM_PaymentMode":
                                                      widget.controller
                                                          .paymentName
                                                }
                                              ]
                                            }).then((value) async {
                                          if (value != 0) {

                                            widget.controller.addToCartList.clear();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    backgroundColor:
                                                        Colors.green,
                                                    content: Text(
                                                      "Amount Deducted Successfully",
                                                      style: Get.textTheme
                                                          .titleMedium!
                                                          .copyWith(
                                                              color:
                                                                  Colors.white),
                                                    )));

                                            await CanteeenCategoryAPI.instance
                                                .transationHistory(
                                                    canteenManagementController:
                                                        widget.controller,
                                                    base: baseUrlFromInsCode(
                                                        'canteen',
                                                        widget
                                                            .mskoolController),
                                                    cmtransId: widget.controller
                                                        .transactionId,
                                                    flag: widget
                                                        .controller
                                                        .cardReaderList
                                                        .last
                                                        .flag!)
                                                .then((value) {
                                              if (value != null) {
                                                Get.back();
                                                GenerateBillKiosk.instance
                                                    .generateNow(
                                                  controller: widget.controller,
                                                  mskoolController:
                                                      widget.mskoolController,
                                                  date: DateTime.now()
                                                      .toIso8601String(),
                                                );
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        backgroundColor:
                                                            Colors.red,
                                                        content: Text(
                                                          "Something went wrong",
                                                          style: Get.textTheme
                                                              .titleMedium!
                                                              .copyWith(
                                                                  color: Colors
                                                                      .white),
                                                        )));
                                              }
                                            });
                                            widget.controller.addToCartList
                                                .clear();
                                            widget.controller.cardReaderList
                                                .clear();
                                            await CanteeenCategoryAPI.instance
                                                .getCanteenItems(
                                              canteenManagementController:
                                                  widget.controller,
                                              base: baseUrlFromInsCode(
                                                  'canteen',
                                                  widget.mskoolController),
                                              miId: widget.miId,
                                              categoryId: 0, counterId: 0,
                                            );
                                          } else {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "Unable to Deduct Amount",
                                                      style: Get.textTheme
                                                          .titleMedium,
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    Align(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text(
                                                            'Close',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: Get.textTheme
                                                                .titleMedium!
                                                                .copyWith(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColor),
                                                          )),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          }
                                          setState(() {});
                                        });
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            elevation: 2,
                                            content: Text(
                                              "In-Sufficient Amount",
                                              style: Get.textTheme.titleSmall!
                                                  .copyWith(
                                                      color: Colors.white),
                                            ),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          elevation: 2,
                                          content: Text(
                                            "Wallet Amount is Zero",
                                            style: Get.textTheme.titleSmall!
                                                .copyWith(color: Colors.white),
                                          ),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  } else {
                                    if (widget
                                        .controller.cardReaderList.isNotEmpty) {
                                      if (widget.controller.cardReaderList.last
                                                  .walletamount !=
                                              null &&
                                          double.parse(amountData.toString()) <=
                                              widget.controller.cardReaderList
                                                  .last.walletamount!) {
                                        await deductAmount(
                                            base: baseUrlFromInsCode('canteen',
                                                widget.mskoolController),
                                            controller: widget.controller,
                                            data: {
                                              "CMMCO_Id": counterId,
                                              "MI_Id": widget.miId,
                                              "HRME_Id": widget.controller
                                                  .cardReaderList.last.aMSTId,
                                              "ASMAY_Id": widget.controller
                                                  .cardReaderList.last.aSMAYId,
                                              "mode_payment":
                                                  widget.controller.paymentName,
                                              "CMTRANS_Amount":
                                                  amountData.toString(),
                                              "CMTransactionItems":
                                                  widget.controller.itemDetails,
                                              "CMTransactionPaymentMode": [
                                                {
                                                  "CMTRANSPM_PaymentModeId":
                                                      widget.controller
                                                          .paymentMode,
                                                  "CMTRANSPM_PaymentMode":
                                                      widget.controller
                                                          .paymentName
                                                }
                                              ]
                                            }).then((value) async {
                                          if (value != 0) {

                                            widget.controller.addToCartList.clear();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    backgroundColor:
                                                        Colors.green,
                                                    content: Text(
                                                      "Amount Deducted Successfully",
                                                      style: Get.textTheme
                                                          .titleMedium!
                                                          .copyWith(
                                                              color:
                                                                  Colors.white),
                                                    )));

                                            await CanteeenCategoryAPI.instance
                                                .transationHistory(
                                                    canteenManagementController:
                                                        widget.controller,
                                                    base: baseUrlFromInsCode(
                                                        'canteen',
                                                        widget
                                                            .mskoolController),
                                                    cmtransId: widget.controller
                                                        .transactionId,
                                                    flag: widget
                                                        .controller
                                                        .cardReaderList
                                                        .last
                                                        .flag!)
                                                .then((value) async {
                                              if (value != null) {
                                                Get.back();
                                                GenerateBillKiosk.instance
                                                    .generateNow(
                                                  controller: widget.controller,
                                                  mskoolController:
                                                      widget.mskoolController,
                                                  date: DateTime.now()
                                                      .toIso8601String(),
                                                );
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        backgroundColor:
                                                            Colors.red,
                                                        content: Text(
                                                          "Something went wrong",
                                                          style: Get.textTheme
                                                              .titleMedium!
                                                              .copyWith(
                                                                  color: Colors
                                                                      .white),
                                                        )));
                                              }
                                            });
                                            widget.controller.addToCartList
                                                .clear();
                                            widget.controller.cardReaderList
                                                .clear();

                                            await CanteeenCategoryAPI.instance
                                                .getCanteenItems(
                                              canteenManagementController:
                                                  widget.controller,
                                              base: baseUrlFromInsCode(
                                                  'canteen',
                                                  widget.mskoolController),
                                              miId: widget.miId,
                                              categoryId: 0, counterId: 0,
                                            );

                                          } else {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "Unable to Deduct Amount",
                                                      style: Get.textTheme
                                                          .titleMedium,
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    Align(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text(
                                                            'Close',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: Get.textTheme
                                                                .titleMedium!
                                                                .copyWith(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColor),
                                                          )),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          }
                                          setState(() {});
                                        });
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            elevation: 2,
                                            content: Text(
                                              "In-Sufficient Amount",
                                              style: Get.textTheme.titleSmall!
                                                  .copyWith(
                                                      color: Colors.white),
                                            ),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          elevation: 2,
                                          content: Text(
                                            "Wallet Amount is Zero",
                                            style: Get.textTheme.titleSmall!
                                                .copyWith(color: Colors.white),
                                          ),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  }
                                } else {
                                  setState(() {
                                    isQr = false;
                                  });
                                }
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(context).primaryColor,
                                  boxShadow: const [
                                    BoxShadow(
                                        offset: Offset(1, 2.1),
                                        blurRadius: 0,
                                        spreadRadius: 0,
                                        color: Colors.grey)
                                  ]),
                              child: Center(
                                child: Text("Proceed ₹ $amountData",
                                    style: Get.textTheme.titleMedium!
                                        .copyWith(color: Colors.white)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (isQr == true)
                      ? SizedBox(
                          child: QrCodeWidgets(
                            amount: amountData.toString(),
                            upiId: '8018514398@ybl',
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
              const SizedBox(height: 16),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 2),
                      onPressed: () async {
                        await cancelTransaction(
                            base: baseUrlFromInsCode(
                                'canteen', widget.mskoolController),
                            body: {
                              "MI_Id": widget.miId,
                              "AMST_Id":
                                  widget.controller.cardReaderList.last.aMSTId
                            }).then((value) {
                          if (value == 200) {
                            logInBox!.put("isFirstTime", false);
                            widget.controller.addToCartList.clear();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                  "Transaction Cancelled",
                                  style: Get.textTheme.titleSmall!
                                      .copyWith(color: Colors.white),
                                )));
                            Get.back();
                          }
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Cancel Transaction",
                          style: Get.textTheme.titleMedium!
                              .copyWith(color: Colors.white),
                        ),
                      ))),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  void _removeItemData(int index) {
    setState(() {
      totalAddAmount.removeAt(index);
      amountData = 0;
      for (int i = 0; i < totalAddAmount.length; i++) {
        amountData += totalAddAmount[i];
      }
      widget.controller.addToCartList.removeAt(index);
    });
  }

  double calculateGST(double baseAmount, double gstRate) {
    double gstAmount = (baseAmount * gstRate) / 100;
    double totalAmount = baseAmount + gstAmount;

    return totalAmount;
  }

  bool isQr = false;
  String paymentMode = '';
}
