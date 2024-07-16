import 'package:canteen_management/canteen_admin/model/counter_wise_food_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/global_utility.dart';
import '../../../controller/mskool_controller.dart';
import '../../../widgets/animated_progress.dart';
import '../../../widgets/m_skool_btn.dart';
import '../../canteen_management/api/item_list_api.dart';
import '../../canteen_management/controller/canteen_controller.dart';
import '../../canteen_management/model/food_category_model.dart';
import '../../canteen_management/widgets/item_list_widgets.dart';
import 'admin_bill_pay.dart';

class AdminOrderFood extends StatefulWidget {
  final MskoolController mskoolController;
  final int miId;

  const AdminOrderFood(
      {super.key, required this.mskoolController, required this.miId});

  @override
  State<AdminOrderFood> createState() => _AdminOrderFoodState();
}

class _AdminOrderFoodState extends State<AdminOrderFood> {
  int categoryId = 0;

  @override
  void initState() {
    _category(0);
    super.initState();
  }

  List itemType = ['VEG', 'NON-VEG'];
  CanteenManagementController canteenManagementController =
      Get.put(CanteenManagementController());
  FoodCategoryModelValues? foodCategoryModelValues;

  _category(int id) async {
    canteenManagementController.categoryLoading(true);
    await CanteeenCategoryAPI.instance.getCanteenItems(
      canteenManagementController: canteenManagementController,
      base: baseUrlFromInsCode('canteen', widget.mskoolController),
      miId: widget.miId,
      categoryId: 0, counterId: 0,
    );
    if (canteenManagementController.item == 'VEG') {
      foodListFilter.value = canteenManagementController.vegFoodList;
    } else if (canteenManagementController.item == 'NON-VEG') {
      foodListFilter.value = canteenManagementController.nonVegFoodList;
    } else {
      foodListFilter.value = canteenManagementController.foodList;
    }

    canteenManagementController.categoryLoading(false);
  }

  String name = '';
  final searchController = TextEditingController();
  RxList<CounterWiseFoodModelValues> foodListFilter = <CounterWiseFoodModelValues>[].obs;
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
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(itemType.length, (index) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width * 0.09,
                      child: RadioListTile(
                        visualDensity:
                            const VisualDensity(vertical: 0, horizontal: -4),
                        contentPadding: EdgeInsets.zero,
                        hoverColor: Colors.black12,
                        fillColor: WidgetStateColor.resolveWith(
                            (states) => Colors.white),
                        title: Text(
                          itemType[index],
                          style: Get.textTheme.titleSmall!
                              .copyWith(color: Colors.white),
                        ),
                        groupValue: canteenManagementController.item,
                        value: itemType[index],
                        onChanged: (value) {
                          setState(() {
                            canteenManagementController.item = value;
                            _category(categoryId);
                          });
                        },
                      ),
                    );
                  }),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 40,
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                  child: SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.03,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green,
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(1, 2),
                            blurRadius: 0,
                            spreadRadius: 0,
                            color: Colors.black12,
                          ),
                        ],
                      ),
                      child: Center(
                        child: PopupMenuButton(
                          tooltip: 'Category',
                          elevation: 2,
                          splashRadius: 100,
                          iconSize: 25,
                          padding: EdgeInsets.zero,
                          position: PopupMenuPosition.under,
                          clipBehavior: Clip.hardEdge,
                          icon: const Icon(
                            Icons.filter_alt_outlined,
                            color: Colors.white,
                            size: 35,
                          ),
                          itemBuilder: (context) {
                            return [
                              ...canteenManagementController.foodCategoryList
                                  .map((category) {
                                return PopupMenuItem(
                                  value: category.cmmcAId!,
                                  child: Text(
                                    category.cmmcACategoryName!,
                                    style: Get.textTheme.titleMedium!.copyWith(
                                      color: (category.cmmcAId! == categoryId)
                                          ? Colors.green
                                          : Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  onTap: () {
                                    _category(category.cmmcAId!);
                                    setState(() {
                                      categoryId = category.cmmcAId!;
                                    });
                                  },
                                );
                              }).toList(),
                              // Add the "Clear selected value" button
                              PopupMenuItem(
                                value: 'clear',
                                child: (categoryId != 0)
                                    ? Text(
                                        'Clear selected Category',
                                        style:
                                            Get.textTheme.titleMedium!.copyWith(
                                          color: Colors.red,
                                        ),
                                      )
                                    : const SizedBox(),
                                onTap: () {
                                  _category(0);
                                  setState(() {
                                    categoryId = 0;
                                  });
                                },
                              ),
                            ];
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
            child: InkWell(
                onTap: () {
                  setState(() {
                    canteenManagementController.item = '';
                    canteenManagementController.addToCartList.clear();
                    _category(0);
                    categoryId=0;
                  });
                },
                child: const Icon(
                  Icons.refresh,
                  color: Colors.white,
                )),
          ),
        ],
      ),
      body: Obx(() {
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              canteenManagementController.isCategoryLoading.value
                  ? const Center(
                      child: AnimatedProgressWidget(
                          title: "Loading",
                          desc:
                              "Please wait while we load item list and create a view for you.",
                          animationPath: "assets/json/default.json"),
                    )
                  : foodListFilter.isNotEmpty
                      ? Expanded(child: LayoutBuilder(
                          builder: (context, BoxConstraints constraints) {
                          return GridView.builder(
                              padding:
                                  const EdgeInsets.fromLTRB(16, 16, 16, 16),
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: foodListFilter.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: _calculateCrossAxisCount(
                                          constraints.maxWidth),
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10,
                                      childAspectRatio: 0.9),
                              itemBuilder: (context, index) {
                                return ItemListWidget(
                                  canteenManagementController:
                                      canteenManagementController,
                                  values: foodListFilter[index],
                                  mskoolController: widget.mskoolController,
                                );
                              });
                        }))
                      : const Center(
                          child: AnimatedProgressWidget(
                            title: "Data is not available",
                            desc: "Food list is not available ",
                            animationPath: "assets/json/nodata.json",
                            animatorHeight: 350,
                          ),
                        ),
              const SizedBox(height: 20),
            ],
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
                  setState(() {
                    Get.to(() => CanteenAdminBillPay(
                          data: canteenManagementController.addToCartList,
                          controller: canteenManagementController,
                          mskoolController: widget.mskoolController,
                          miId: widget.miId,
                        ));
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

  @override
  void dispose() {
    canteenManagementController.item = '';
    canteenManagementController.addToCartList.clear();
    super.dispose();
  }
}
