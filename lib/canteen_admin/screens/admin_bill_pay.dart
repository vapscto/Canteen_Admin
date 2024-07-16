import 'dart:async';

import 'package:canteen_management/canteen_admin/widgets/pay_by_cash_bill.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/mskool_controller.dart';
import '../../../main.dart';
import '../../canteen_management/api/card_reader_api.dart';
import '../../canteen_management/api/item_list_api.dart';
import '../../canteen_management/constants/canteen_constants.dart';
import '../../canteen_management/controller/canteen_controller.dart';
import '../../canteen_management/widgets/generate_bill.dart';
import '../../canteen_management/widgets/qr_code_widget.dart';
import '../../controller/global_utility.dart';
import '../model/counter_wise_food_model.dart';

class CanteenAdminBillPay extends StatefulWidget {
  final List<CounterWiseFoodModelValues> data;
  final CanteenManagementController controller;

  final MskoolController mskoolController;
  final int miId;

  const CanteenAdminBillPay(
      {super.key,
      required this.data,
      required this.controller,
      // required this.loginSuccessModel,
      required this.mskoolController,
      required this.miId});

  @override
  State<CanteenAdminBillPay> createState() => _CanteenAdminBillPayState();
}

class _CanteenAdminBillPayState extends State<CanteenAdminBillPay> {
  int minutes = 1;
  int seconds = 59;
  bool timerOver = false;
  late Timer _timer;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          if (minutes > 0) {
            minutes--;
            seconds = 59;
          } else {
            timer.cancel();
            Get.back();
            timerOver = true;
            widget.controller.addToCartList.clear();
            widget.controller.cardReaderList.clear();
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    widget.controller.itemDetails.clear();
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

  double amountData = 0;
  List<double> totalAddAmount = [];

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
            widget.controller.cardReaderList.clear();
            Get.back();
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
            // padding: const EdgeInsets.fromLTRB(100, 16, 100, 0),
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
                                  onPressed: () async {
                                    _removeItemData(index);
                                    if (widget
                                        .controller.addToCartList.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                          "Cart is Empty",
                                          style: Get.textTheme.titleSmall!
                                              .copyWith(color: Colors.white),
                                        ),
                                        backgroundColor: Colors.red,
                                        duration: const Duration(seconds: 1),
                                      ));
                                      Get.back();
                                    }
                                  },
                                  icon: const Icon(Icons.delete))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
              (widget.controller.addToCartList.isEmpty)
                  ? const SizedBox()
                  : Card(
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                                text: 'Total Item:',
                                                style: Get.textTheme.titleSmall!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w400)),
                                            TextSpan(
                                                text:
                                                    ' ${widget.controller.addToCartList.length}',
                                                style: Get.textTheme.titleSmall!
                                                    .copyWith(
                                                        // color: Theme.of(context).primaryColor
                                                        )),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Select Payment Mode",
                                        style: Get.textTheme.titleSmall!
                                            .copyWith(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.red),
                                      ),
                                      ...List.generate(newPaymentMode2.length,
                                          (index) {
                                        return Theme(
                                          data: ThemeData(
                                              unselectedWidgetColor:
                                                  Theme.of(context)
                                                      .primaryColor),
                                          child: SizedBox(
                                            width: 150,
                                            height: 40,
                                            child: RadioListTile(
                                                selectedTileColor:
                                                    Theme.of(context)
                                                        .primaryColor,
                                                activeColor: Theme.of(context)
                                                    .primaryColor,
                                                title: Text(
                                                  newPaymentMode2[index]
                                                      ['name'],
                                                  style:
                                                      Get.textTheme.titleSmall,
                                                ),
                                                contentPadding: EdgeInsets.zero,
                                                visualDensity:
                                                    const VisualDensity(
                                                        vertical: 0,
                                                        horizontal: 0),
                                                value: newPaymentMode2[index]
                                                    ['id'],
                                                groupValue: paymentMode,
                                                onChanged: (value) async {
                                                  setState(() {
                                                    paymentMode =
                                                        newPaymentMode2[index]
                                                            ['id'];
                                                    widget.controller
                                                            .paymentMode =
                                                        paymentMode;
                                                    logger.i(paymentMode);
                                                    isQr = false;
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
                                              widget.controller.addToCartList
                                                  .length;
                                          index++) {
                                        widget.controller.itemDetails.add({
                                          "itemCount": numberOfItems[index],
                                          "CMTRANSI_name": widget
                                              .controller
                                              .addToCartList[index]
                                              .cmmfIFoodItemName,
                                          "unitRate": widget
                                              .controller
                                              .addToCartList[index]
                                              .cmmfIUnitRate,
                                          "cmmfI_Id": widget.controller
                                              .addToCartList[index].cmmfIId
                                        });
                                      }
                                      if (paymentMode == '1') {
                                        await cardReaderAPI(
                                                base: baseUrlFromInsCode(
                                                    'canteen',
                                                    widget.mskoolController),
                                                body: {
                                                  "MI_Id": widget.miId,
                                                  "AMCTST_IP": ipAddress,
                                                  "Flag": '',
                                                },
                                                controller: widget.controller)
                                            .then((value) async {
                                          if (value!.values!.isEmpty) {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "Scan your smart Card",
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
                                            return;
                                          } else {
                                            if (widget.controller.cardReaderList
                                                .isNotEmpty) {
                                              if (widget
                                                          .controller
                                                          .cardReaderList
                                                          .last
                                                          .pDAAmount !=
                                                      null &&
                                                  double.parse(amountData
                                                          .toString()) <=
                                                      widget
                                                          .controller
                                                          .cardReaderList
                                                          .last
                                                          .pDAAmount!) {
                                                await deductAmount(
                                                    base: baseUrlFromInsCode(
                                                        'canteen',
                                                        widget
                                                            .mskoolController),
                                                    controller:
                                                        widget.controller,
                                                    data: {
                                                      "MI_Id": widget.miId,
                                                      "AMST_Id": widget
                                                          .controller
                                                          .cardReaderList
                                                          .last
                                                          .aMSTId,
                                                      "ASMAY_Id": widget
                                                          .controller
                                                          .cardReaderList
                                                          .last
                                                          .aSMAYId,
                                                      "CMTRANS_Amount":
                                                          amountData.toString(),
                                                      "CMTransactionItems":
                                                          widget.controller
                                                              .itemDetails,
                                                      "CMTransactionPaymentMode":
                                                          [
                                                        {
                                                          "CMTRANSPM_PaymentModeId":
                                                              widget.controller
                                                                  .paymentMode,
                                                          "CMTRANSPM_PaymentMode":
                                                              "PDA"
                                                        }
                                                      ]
                                                    }).then((value) async {
                                                  if (value! > 0) {
                                                    transactionId = value;
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                            backgroundColor:
                                                                Colors.green,
                                                            content: Text(
                                                              "Amount Deducted Successfully ID:-$value",
                                                              style: Get
                                                                  .textTheme
                                                                  .titleMedium!
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .white),
                                                            )));
                                                    await CanteeenCategoryAPI
                                                        .instance
                                                        .transationHistory(
                                                            canteenManagementController:
                                                                widget
                                                                    .controller,
                                                            base: baseUrlFromInsCode(
                                                                'canteen',
                                                                widget
                                                                    .mskoolController),
                                                            cmtransId: value,
                                                            flag: '')
                                                        .then((value) {
                                                      if (value != null) {
                                                        GenerateBill.instance
                                                            .generateNow(
                                                                controller: widget
                                                                    .controller,
                                                                mskoolController:
                                                                    widget
                                                                        .mskoolController);
                                                      } else {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                SnackBar(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .red,
                                                                    content:
                                                                        Text(
                                                                      "Unable to generate Bill Please Go To History ",
                                                                      style: Get
                                                                          .textTheme
                                                                          .titleMedium!
                                                                          .copyWith(
                                                                              color: Colors.white),
                                                                    )));
                                                      }
                                                    });
                                                    widget.controller
                                                        .addToCartList
                                                        .clear();
                                                    widget.controller
                                                        .cardReaderList
                                                        .clear();
                                                    await CanteeenCategoryAPI
                                                        .instance
                                                        .getCanteenItems(
                                                      canteenManagementController:
                                                          widget.controller,
                                                      base: baseUrlFromInsCode(
                                                          'canteen',
                                                          widget
                                                              .mskoolController),
                                                      miId: widget.miId,
                                                      categoryId: 0, counterId: 0,
                                                    );
                                                  } else {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: Align(
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                              "Unable to Deduct Amount",
                                                              style: Get
                                                                  .textTheme
                                                                  .titleMedium,
                                                            ),
                                                          ),
                                                          actions: <Widget>[
                                                            Align(
                                                              alignment: Alignment
                                                                  .bottomCenter,
                                                              child: TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child: Text(
                                                                    'Close',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: Get
                                                                        .textTheme
                                                                        .titleMedium!
                                                                        .copyWith(
                                                                            color:
                                                                                Theme.of(context).primaryColor),
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
                                                    elevation: 2,
                                                    content: Text(
                                                      "In-Sufficient Amount",
                                                      style: Get
                                                          .textTheme.titleSmall!
                                                          .copyWith(
                                                              color:
                                                                  Colors.white),
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
                                                          BorderRadius.circular(
                                                              8)),
                                                  elevation: 2,
                                                  content: Text(
                                                    "PDA Amount is Zero",
                                                    style: Get
                                                        .textTheme.titleSmall!
                                                        .copyWith(
                                                            color:
                                                                Colors.white),
                                                  ),
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
                                            }

                                            setState(() {
                                              isQr = false;
                                            });
                                          }
                                        });
                                      } else if (paymentMode == '2') {
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "Amount Accepted",
                                                  style:
                                                      Get.textTheme.titleMedium,
                                                ),
                                              ),
                                              actions: <Widget>[
                                                Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: TextButton(
                                                      onPressed: () async {
                                                        Get.back();
                                                        Get.back();
                                                        await PayByCashBill
                                                            .instance
                                                            .generateBill(
                                                                controller: widget
                                                                    .controller);
                                                        widget.controller
                                                            .addToCartList
                                                            .clear();
                                                      },
                                                      child: Text(
                                                        'Close',
                                                        textAlign:
                                                            TextAlign.center,
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
                                        setState(() {
                                          isQr = false;
                                        });
                                      } else if (paymentMode == '3') {
                                        setState(() {
                                          isQr = true;
                                        });
                                      } else {
                                        setState(() {
                                          isQr = false;
                                        });
                                      }
                                    }
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
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
              // const SizedBox(height: 16),
              // Align(
              //     alignment: Alignment.bottomCenter,
              //     child: ElevatedButton(
              //         style: ElevatedButton.styleFrom(
              //             backgroundColor: Colors.red,
              //             shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(10),
              //             ),
              //             elevation: 2),
              //         onPressed: () {
              //           setState(() {
              //             // widget.controller.addToCartList.clear();
              //             widget.controller.cardReaderList.clear();
              //             Get.back();
              //           });
              //         },
              //         child: Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: Text(
              //             "Cancel Transaction",
              //             style: Get.textTheme.titleMedium!
              //                 .copyWith(color: Colors.white),
              //           ),
              //         ))),
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

int transactionId = 0;
