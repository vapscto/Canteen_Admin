import 'dart:async';

import 'package:canteen_management/canteen_admin/model/counter_wise_food_model.dart';
import 'package:canteen_management/canteen_management/api/card_reader_api.dart';
import 'package:canteen_management/model/login_success_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/global_utility.dart';
import '../../controller/mskool_controller.dart';
import '../../widgets/animated_progress.dart';
import '../../widgets/m_skool_btn.dart';
import '../api/item_list_api.dart';
import '../controller/canteen_controller.dart';
import '../model/food_category_model.dart';
import '../widgets/item_list_widgets.dart';
import 'canteen_bill_pay.dart';

class CanteenHomeScreen extends StatefulWidget {
  final MskoolController mskoolController;
  final LoginSuccessModel loginSuccessModel;

  const CanteenHomeScreen(
      {super.key, required this.mskoolController, required this.loginSuccessModel});

  @override
  State<CanteenHomeScreen> createState() => _CanteenHomeScreenState();
}

class _CanteenHomeScreenState extends State<CanteenHomeScreen> {
  @override
  void initState() {
    _category(0);
    getData();
    super.initState();
  }

  List itemType = ['VEG', 'NON-VEG'];
  CanteenManagementController canteenManagementController =
      Get.put(CanteenManagementController());
  FoodCategoryModelValues? foodCategoryModelValues;
  RxBool isLoading = RxBool(false);

  foodList() async {
    isLoading.value = true;
    await CanteeenCategoryAPI.instance.foodlist(
        canteenManagementController: canteenManagementController,
        base: baseUrlFromInsCode('canteen', widget.mskoolController),
        counterId: counterId,
        categoryId: categoryId);
    if (canteenManagementController.item == 'VEG') {
      foodListFilter.value = canteenManagementController.vegFoodList;
    } else if (canteenManagementController.item == 'NON-VEG') {
      foodListFilter.value = canteenManagementController.nonVegFoodList;
    } else {
      foodListFilter.value = canteenManagementController.foodList;
    }

    isLoading.value = false;
  }
  int categoryId =0;
  _category(int id) async {
    canteenManagementController.categoryLoading(true);
    await CanteeenCategoryAPI.instance.getCanteenItems(
      canteenManagementController: canteenManagementController,
      base: baseUrlFromInsCode('canteen', widget.mskoolController),
      miId:widget.loginSuccessModel.mIID!,
      counterId: counterId,
    );
    await CanteeenCategoryAPI.instance.foodlist(
        canteenManagementController: canteenManagementController,
        base: baseUrlFromInsCode('canteen', widget.mskoolController),
        counterId: counterId,
        categoryId: categoryId);
    foodList();
    canteenManagementController.categoryLoading(false);
  }

  getData() async {
    Timer.periodic(const Duration(hours: 1), (Timer timer) async {
      await CanteeenCategoryAPI.instance.getCanteenItems(
        canteenManagementController: canteenManagementController,
        base: baseUrlFromInsCode('canteen', widget.mskoolController),
        miId: widget.loginSuccessModel.mIID!,
        categoryId: categoryId,
        counterId: counterId,
      );
       CanteeenCategoryAPI.instance.foodlist(
          canteenManagementController: canteenManagementController,
          base: baseUrlFromInsCode('canteen', widget.mskoolController),
          counterId: counterId,
          categoryId: categoryId);
      if (canteenManagementController.item == 'VEG') {
        foodListFilter.value = canteenManagementController.vegFoodList;
      } else if (canteenManagementController.item == 'NON-VEG') {
        foodListFilter.value = canteenManagementController.nonVegFoodList;
      } else {
        foodListFilter.value = canteenManagementController.foodList;
      }

    });
  }

  String name = '';
  final searchController = TextEditingController();
  RxList<CounterWiseFoodModelValues> foodListFilter =
      <CounterWiseFoodModelValues>[].obs;
  int bgColor = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            "Canteen Management",
            style: Get.textTheme.titleMedium!.copyWith(color: Colors.white),
          ),
          centerTitle: false,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) {
                        setState(() {
                          _sortList(value);
                        });
                      },
                      style: Get.textTheme.titleSmall,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(5),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white)),
                        hintText: 'Search...',
                        hintStyle: Get.textTheme.titleSmall!
                            .copyWith(color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: InkWell(
                  onTap: () async {
                    if (canteenManagementController.cardReaderList.isNotEmpty) {
                      await cancelTransaction(
                          base: baseUrlFromInsCode(
                              'canteen', widget.mskoolController),
                          body: {
                            "MI_Id": 0,
                            "AMST_Id": canteenManagementController
                                .cardReaderList.last.aMSTId,
                            "Flag": canteenManagementController.selectedType
                                .toLowerCase(),
                          }).then((value) {
                        if (value == 200) {
                          setState(() {
                            canteenManagementController.item = 'All';
                            canteenManagementController.addToCartList.clear();
                            categoryId = 0;
                            counterId = 0;
                            _category(0);
                            searchController.clear();
                          });
                        }
                      });
                    } else {
                      setState(() {
                        canteenManagementController.item = 'All';
                        canteenManagementController.addToCartList.clear();
                        categoryId = 0;
                        counterId = 0;
                        _category(0);
                        searchController.clear();
                      });
                    }
                  },
                  child: const Icon(
                    Icons.refresh,
                    color: Colors.white,
                  )),
            ),
            // Padding(
            //   padding:
            //       const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
            //   child: InkWell(
            //       onTap: () {
            //         // Get.dialog(
            //         //   SelectUserWidget(
            //         //     controller: canteenManagementController,
            //         //     onPress: () async {
            //         //       Get.back();
            //         //       await cardReaderAPI(
            //         //               base: baseUrlFromInsCode(
            //         //                   'canteen', widget.mskoolController),
            //         //               body: {
            //         //                 "MI_Id": widget.miId,
            //         //                 "AMCTST_IP": ipAddress,
            //         //                 "Flag":canteenManagementController.selectedType.toLowerCase(),
            //         //               },
            //         //               controller: canteenManagementController)
            //         //           .then((value) {
            //         //         if (value!.values!.isEmpty) {
            //         //           showDialog(
            //         //             context: context,
            //         //             builder: (BuildContext context) {
            //         //               return AlertDialog(
            //         //                 title: Align(
            //         //                   alignment: Alignment.center,
            //         //                   child: Text(
            //         //                     "Scan your smart Card",
            //         //                     style: Get.textTheme.titleMedium,
            //         //                   ),
            //         //                 ),
            //         //                 actions: <Widget>[
            //         //                   Align(
            //         //                     alignment: Alignment.bottomCenter,
            //         //                     child: TextButton(
            //         //                         onPressed: () {
            //         //                           Navigator.of(context).pop();
            //         //                         },
            //         //                         child: Text(
            //         //                           'Close',
            //         //                           textAlign: TextAlign.center,
            //         //                           style: Get.textTheme.titleMedium!
            //         //                               .copyWith(
            //         //                                   color: Theme.of(context)
            //         //                                       .primaryColor),
            //         //                         )),
            //         //                   ),
            //         //                 ],
            //         //               );
            //         //             },
            //         //           );
            //         //
            //         //           return;
            //         //         } else {
            //                   Get.to(() => TransationHistory(
            //                         controller: canteenManagementController,
            //                         mskoolController: widget.mskoolController,
            //                         miId: widget.miId,
            //                       ));
            //         //         }
            //         //       });
            //         //     },
            //         //   ),
            //         // );
            //       },
            //       child: const Center(
            //         child: Icon(
            //           Icons.history,
            //           color: Colors.white,
            //           size: 30,
            //         ),
            //       )),
            // )
          ]),
      body: Obx(() {
        return SizedBox(
          height: (MediaQuery.of(context).size.height),
          width: (MediaQuery.of(context).size.width),
          child: SingleChildScrollView(
            child: Column(
              children: [
                canteenManagementController.isCategoryLoading.value
                    ? const Center(
                  child: AnimatedProgressWidget(
                      title: "Loading ",
                      desc:
                      "Please wait while we load item list and create a view for you.",
                      animationPath: "assets/json/default.json"),
                )
                    : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (canteenManagementController.foodCategoryList.isEmpty)
                        ? const SizedBox()
                        : SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(2, 2.1),
                                  spreadRadius: 0,
                                  blurRadius: 0,
                                  color: Colors.black12)
                            ]),
                        child: Column(
                          children: [
                            const SizedBox(height: 16),
                            Text("Select Category",
                                style: Get.textTheme.titleSmall!
                                    .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context)
                                        .primaryColor)),
                            const SizedBox(height: 5),
                            ...List.generate(
                                canteenManagementController
                                    .foodCategoryList.length, (index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 10.0),
                                child: ListTile(
                                  title: Text(
                                    canteenManagementController
                                        .foodCategoryList[index]
                                        .cmmcACategoryName ??
                                        "",
                                    style: Get.textTheme.titleSmall!.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: (categoryId ==
                                            canteenManagementController
                                                .foodCategoryList[
                                            index]
                                                .cmmcAId)
                                            ? Colors.green
                                            : Colors.black),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      categoryId =
                                          canteenManagementController
                                              .foodCategoryList[
                                          index]
                                              .cmmcAId ??
                                              0;
                                      foodList();
                                    });
                                  },
                                ),
                              );
                            }),
                            const SizedBox(height: 20),
                            (categoryId == 0)
                                ? const SizedBox()
                                : Padding(
                              padding:
                              const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    categoryId = 0;
                                    foodList();
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color:
                                      const Color.fromARGB(
                                          255,
                                          255,
                                          202,
                                          202),
                                      borderRadius:
                                      BorderRadius.circular(
                                          10),
                                      boxShadow: const [
                                        BoxShadow(
                                            offset:
                                            Offset(2, 2.1),
                                            spreadRadius: 0,
                                            blurRadius: 0,
                                            color:
                                            Colors.black12)
                                      ]),
                                  padding:
                                  const EdgeInsets.all(10),
                                  child: Center(
                                    child: Text(
                                      "Clear Filter",
                                      style: Get
                                          .textTheme.titleSmall!
                                          .copyWith(
                                          color: Colors.red,
                                          fontWeight:
                                          FontWeight
                                              .w600),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    (isLoading.value == true)
                        ? const AnimatedProgressWidget(
                        title: "Loading ",
                        desc:
                        "Please wait while we load item list and create a view for you.",
                        animationPath: "assets/json/default.json")
                        : foodListFilter.isNotEmpty
                        ? Expanded(child: LayoutBuilder(builder:
                        (context, BoxConstraints constraints) {
                      return SingleChildScrollView(
                        child: GridView.builder(
                            padding: const EdgeInsets.fromLTRB(
                                16, 16, 16, 16),
                            shrinkWrap: true,
                            physics:
                            const AlwaysScrollableScrollPhysics(),
                            itemCount: foodListFilter.length,
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                _calculateCrossAxisCount(
                                    constraints.maxWidth),
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: 0.9),
                            itemBuilder: (context, index) {
                              return ItemListWidget(
                                canteenManagementController:
                                canteenManagementController,
                                values: foodListFilter[index],
                                mskoolController:
                                widget.mskoolController,
                              );
                            }),
                      );
                    }))
                        : const Center(
                      child: AnimatedProgressWidget(
                        title: "Data is not available",
                        desc: "Food list is not available ",
                        animationPath: "assets/json/nodata.json",
                        animatorHeight: 350,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      }),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Obx(() {
        return (canteenManagementController.addToCartList.isNotEmpty)
            ? MSkollBtn(
                title:
                    "View Cart ${canteenManagementController.addToCartList.length}",
                onPress: () async {
                  await cardReaderAPI(
                          base: baseUrlFromInsCode(
                              'canteen', widget.mskoolController),
                          body: {
                            // "MI_Id": widget.miId,
                            "AMCTST_IP": ipAddress,
                          },
                          controller: canteenManagementController)
                      .then((value) {
                    if (value!.values!.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Scan your smart Card",
                                style: Get.textTheme.titleMedium,
                              ),
                            ),
                            actions: <Widget>[
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'Close',
                                      textAlign: TextAlign.center,
                                      style: Get.textTheme.titleMedium!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                    )),
                              ),
                            ],
                          );
                        },
                      );
                      return;
                    } else {
                      setState(() {
                        staffStudentFlag = canteenManagementController
                            .cardReaderList.last.flag!
                            .toLowerCase();
                        Get.to(() => CanteenBillPay(
                              data: canteenManagementController.addToCartList,
                              controller: canteenManagementController,
                              mskoolController: widget.mskoolController,
                              miId: 0,
                            ));
                      });
                    }
                  });
                })
            : const SizedBox();
      }),
    );
  }

  _sortList(String data) {
    if (data.isEmpty) {
      if (canteenManagementController.item == 'VEG') {
        foodListFilter.value = canteenManagementController.vegFoodList;
      } else if (canteenManagementController.item == 'NON-VEG') {
        foodListFilter.value = canteenManagementController.nonVegFoodList;
      } else {
        foodListFilter.value = canteenManagementController.foodList;
      }
    } else {
      if (canteenManagementController.item == 'VEG') {
        foodListFilter.value =
            canteenManagementController.vegFoodList.where((value) {
          return value.cmmfIFoodItemName!
              .toLowerCase()
              .contains(data.toLowerCase());
        }).toList();
      } else if (canteenManagementController.item == 'NON-VEG') {
        foodListFilter.value =
            canteenManagementController.nonVegFoodList.where((value) {
          return value.cmmfIFoodItemName!
              .toLowerCase()
              .contains(data.toLowerCase());
        }).toList();
      } else {
        foodListFilter.value =
            canteenManagementController.foodList.where((value) {
          return value.cmmfIFoodItemName!
              .toLowerCase()
              .contains(data.toLowerCase());
        }).toList();
      }
    }
    setState(() {});
  }

  int _calculateCrossAxisCount(double width) {
    return (width / 250).floor();
  }

}
