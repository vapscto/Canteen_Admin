import 'package:canteen_management/canteen_admin/add_details/model/canteen_ins_list.dart';
import 'package:canteen_management/canteen_admin/admin_api/admin_api.dart';
import 'package:canteen_management/canteen_admin/admin_controller/admin_controller.dart';
import 'package:canteen_management/canteen_admin/model/report_list_model.dart';
import 'package:canteen_management/canteen_admin/widgets/excel_widget.dart';
import 'package:canteen_management/canteen_admin/widgets/export_pdf_widget.dart';
import 'package:canteen_management/canteen_management/api/item_list_api.dart';
import 'package:canteen_management/canteen_management/controller/canteen_controller.dart';
import 'package:canteen_management/controller/global_utility.dart';
import 'package:canteen_management/controller/mskool_controller.dart';
import 'package:canteen_management/widgets/animated_progress.dart';
import 'package:canteen_management/widgets/custom_appbar.dart';
import 'package:canteen_management/widgets/m_skool_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

import '../model/counter_wise_food_model.dart';

class ReportScreen extends StatefulWidget {
  final MskoolController mskoolController;
  final AdminController controller;
  final int miId;

  const ReportScreen(
      {super.key,
      required this.mskoolController,
      required this.miId,
      required this.controller});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  List<String> data = [
    "Date Wise",
    "Category Wise",
    "Item Wise",
    "Refund",
    "Recharge",
    "Collection",
    "Institution"
  ];
  String selectedData = '';
  final fromController = TextEditingController();
  final toController = TextEditingController();
  DateTime? fromDate;
  DateTime? toDate;
  List<String> categoryData = ["VEG", "NON-VEG"];
  String selectedCategory = '';
  List<String> refundList = ['Wallet', 'PDA'];
  String selectedRefundType = '';
  CanteenManagementController controller =
      Get.put(CanteenManagementController());
  final SuggestionsBoxController _suggestionsBoxController =
      SuggestionsBoxController();
  final SuggestionsBoxController _suggestionsBoxController1 =
      SuggestionsBoxController();
  final instituteController = TextEditingController();
  int miId = 0;
  String newCategoryData = '';

  _loadData() async {
    await CanteeenCategoryAPI.instance.getCanteenItems(
      canteenManagementController: controller,
      base: baseUrlFromInsCode('canteen', widget.mskoolController),
      miId: widget.miId,
      categoryId: 0,
      counterId: counterId,
    );
    CanteeenCategoryAPI.instance.foodlist(
        canteenManagementController: controller,
        base: baseUrlFromInsCode('canteen', widget.mskoolController),
        counterId: counterId,
        categoryId: 0);
  }

  DateTime dt1 = DateTime.now();

  @override
  void initState() {
    _loadData();
    setState(() {
      fromDate = dt1;
      toDate = dt1;
      fromController.text = dateFormat(fromDate!);
      toController.text = dateFormat(toDate!);
    });
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.reportList.clear();
    widget.controller.lastReportList.clear();
    selectedData = '';
    super.dispose();
  }

  final itemController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Report').getAppBar(),
      body: Obx(() {
        return Center(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(data.length, (index) {
                  return Card(
                    color: selectedData == data[index]
                        ? Colors.greenAccent
                        : Colors.white,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.12,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          unselectedWidgetColor: Colors.grey,
                          // hoverColor: Colors.greenAccent.shade100,
                          listTileTheme: const ListTileThemeData(
                              horizontalTitleGap: 5, minVerticalPadding: 0),
                        ),
                        child: RadioListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title: Text(
                              data[index],
                              style: Get.textTheme.titleSmall,
                            ),
                            selectedTileColor: Theme.of(context).primaryColor,
                            activeColor: Theme.of(context).primaryColor,
                            visualDensity: const VisualDensity(
                                vertical: 0, horizontal: -4),
                            value: data[index],
                            groupValue: selectedData,
                            onChanged: (value) {
                              setState(() {
                                selectedData = '';
                                widget.controller.reportList.clear();
                                widget.controller.lastReportList.clear();
                                selectedData = value.toString();
                                selectedRefundType = '';
                                newCategoryData = '';
                                selectedCategory = '';
                                itemController.clear();
                              });
                            }),
                      ),
                    ),
                  );
                }),
              ),
              (selectedData == "Date Wise")
                  ? Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: TextFormField(
                              style: Get.textTheme.titleSmall!,
                              readOnly: true,
                              controller: fromController,
                              decoration: InputDecoration(
                                  hintText: 'From Date',
                                  hintStyle: Get.textTheme.titleSmall!
                                      .copyWith(color: Colors.grey),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.grey))),
                              onTap: () async {
                                fromDate = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime(2000),
                                    initialDate: DateTime.now(),
                                    lastDate: DateTime.now());
                                if (fromDate != null) {
                                  fromController.text = dateFormat(fromDate!);
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: TextFormField(
                              style: Get.textTheme.titleSmall!,
                              readOnly: true,
                              controller: toController,
                              decoration: InputDecoration(
                                  hintText: 'To Date',
                                  hintStyle: Get.textTheme.titleSmall!
                                      .copyWith(color: Colors.grey),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.grey))),
                              onTap: () async {
                                if (fromDate != null) {
                                  toDate = await showDatePicker(
                                      context: context,
                                      firstDate: fromDate!,
                                      initialDate: DateTime.now(),
                                      lastDate: DateTime.now());
                                  if (toDate != null) {
                                    toController.text = dateFormat(toDate!);
                                  }
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                      "Select FromDate",
                                      style: Get.textTheme.titleSmall,
                                    ),
                                    backgroundColor: Colors.red,
                                  ));
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  : (selectedData == "Category Wise")
                      ? Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:
                                    List.generate(categoryData.length, (index) {
                                  return Card(
                                    color: selectedCategory == categoryData[index]
                                        ? Colors.greenAccent
                                        : Colors.white,
                                    child: SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width * 0.15,
                                      child: Theme(
                                        data: Theme.of(context).copyWith(
                                          unselectedWidgetColor: Colors.grey,
                                          // hoverColor: Colors.greenAccent.shade100,
                                          listTileTheme: const ListTileThemeData(
                                              horizontalTitleGap: 5,
                                              minVerticalPadding: 0),
                                        ),
                                        child: RadioListTile(
                                            contentPadding: const EdgeInsets.all(0),
                                            title: Text(
                                              categoryData[index],
                                              style: Get.textTheme.titleSmall,
                                            ),
                                            selectedTileColor:
                                                Theme.of(context).primaryColor,
                                            activeColor:
                                                Theme.of(context).primaryColor,
                                            visualDensity: const VisualDensity(
                                                vertical: 0, horizontal: -4),
                                            value: categoryData[index],
                                            groupValue: selectedCategory,
                                            onChanged: (value) {
                                              setState(() {
                                                widget.controller.reportList
                                                    .clear();
                                                selectedCategory = value.toString();
                                              });
                                            }),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                              SizedBox(
                                width:
                                MediaQuery.of(context).size.width *
                                    0.15,
                                child: TextFormField(
                                  style: Get.textTheme.titleSmall!,
                                  readOnly: true,
                                  controller: fromController,
                                  decoration: InputDecoration(
                                      hintText: 'From Date',
                                      hintStyle: Get
                                          .textTheme.titleSmall!
                                          .copyWith(color: Colors.grey),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.grey))),
                                  onTap: () async {
                                    fromDate = await showDatePicker(
                                        context: context,
                                        firstDate: DateTime(2000),
                                        initialDate: DateTime.now(),
                                        lastDate: DateTime.now());
                                    if (fromDate != null) {
                                      fromController.text =
                                          dateFormat(fromDate!);
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width:
                                MediaQuery.of(context).size.width *
                                    0.15,
                                child: TextFormField(
                                  style: Get.textTheme.titleSmall!,
                                  readOnly: true,
                                  controller: toController,
                                  decoration: InputDecoration(
                                      hintText: 'To Date',
                                      hintStyle: Get
                                          .textTheme.titleSmall!
                                          .copyWith(color: Colors.grey),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.grey))),
                                  onTap: () async {
                                    if (fromDate != null) {
                                      toDate = await showDatePicker(
                                          context: context,
                                          firstDate: fromDate!,
                                          initialDate: DateTime.now(),
                                          lastDate: DateTime.now());
                                      if (toDate != null) {
                                        toController.text =
                                            dateFormat(toDate!);
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                          "Select FromDate",
                                          style:
                                          Get.textTheme.titleSmall,
                                        ),
                                        backgroundColor: Colors.red,
                                      ));
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      : (selectedData == "Item Wise")
                          ? Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height: 45,
                                  child: TypeAheadFormField<
                                      CounterWiseFoodModelValues>(
                                    suggestionsBoxController:
                                        _suggestionsBoxController,
                                    getImmediateSuggestions: true,
                                    textFieldConfiguration:
                                        TextFieldConfiguration(
                                      style: Get.textTheme.titleSmall,
                                      controller: itemController,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                              color: Colors.blue,
                                            ),
                                          ),
                                          hintStyle: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(
                                                  color: Colors.grey,
                                                  fontSize: 14),
                                          hintText:
                                              controller.foodList.isNotEmpty
                                                  ? 'Search Item'
                                                  : 'No data available',
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          suffixIcon: (itemController
                                                  .text.isEmpty)
                                              ? const Icon(
                                                  Icons.keyboard_arrow_down,
                                                  color: Colors.black,
                                                  size: 30,
                                                )
                                              : IconButton(
                                                  onPressed: () {
                                                    itemController.clear();
                                                    setState(() {});
                                                  },
                                                  icon: const Icon(
                                                      Icons.clear_outlined))),
                                    ),
                                    suggestionsCallback: (v) {
                                      return controller.foodList.where((d) => d
                                          .cmmfIFoodItemName!
                                          .toLowerCase()
                                          .contains(v.toLowerCase()));
                                    },
                                    itemBuilder: (context, suggestion) {
                                      return ListTile(
                                        onTap: () async {
                                          setState(() {
                                            itemController.text =
                                                suggestion.cmmfIFoodItemName!;
                                            _suggestionsBoxController.close();
                                          });
                                        },
                                        title: Text(
                                          suggestion.cmmfIFoodItemName!,
                                          style: Get.textTheme.titleSmall,
                                        ),
                                      );
                                    },
                                    onSuggestionSelected: (suggestion) {},
                                    noItemsFoundBuilder: (context) {
                                      return const SizedBox();
                                    },
                                  ),
                                ),
                              ),
                            )
                          : (selectedData == 'Refund' ||
                                  selectedData == 'Recharge' ||
                                  selectedData == 'Collection')
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: List.generate(
                                            refundList.length, (index) {
                                          return Card(
                                            color: selectedRefundType ==
                                                    refundList[index]
                                                ? Colors.greenAccent
                                                : Colors.white,
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.15,
                                              child: Theme(
                                                data:
                                                    Theme.of(context).copyWith(
                                                  unselectedWidgetColor:
                                                      Colors.grey,
                                                  // hoverColor: Colors.greenAccent.shade100,
                                                  listTileTheme:
                                                      const ListTileThemeData(
                                                          horizontalTitleGap: 5,
                                                          minVerticalPadding:
                                                              0),
                                                ),
                                                child: RadioListTile(
                                                    contentPadding:
                                                        const EdgeInsets.all(0),
                                                    title: Text(
                                                      refundList[index],
                                                      style: Get
                                                          .textTheme.titleSmall,
                                                    ),
                                                    selectedTileColor:
                                                        Theme.of(context)
                                                            .primaryColor,
                                                    activeColor:
                                                        Theme.of(context)
                                                            .primaryColor,
                                                    visualDensity:
                                                        const VisualDensity(
                                                            vertical: 0,
                                                            horizontal: -4),
                                                    value: refundList[index],
                                                    groupValue:
                                                        selectedRefundType,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        widget.controller
                                                            .reportList
                                                            .clear();
                                                        selectedRefundType =
                                                            value.toString();
                                                        if (selectedData ==
                                                            'Refund') {
                                                          if (selectedRefundType ==
                                                              "Wallet") {
                                                            newCategoryData =
                                                                'Refundwallet';
                                                          } else {
                                                            newCategoryData =
                                                                'Refundpda';
                                                          }
                                                        } else if (selectedData ==
                                                            'Recharge') {
                                                          if (selectedRefundType ==
                                                              "Wallet") {
                                                            newCategoryData =
                                                                'Rechargewallet';
                                                          } else {
                                                            newCategoryData =
                                                                'Rechargepda';
                                                          }
                                                        } else if (selectedData ==
                                                            'Collection') {
                                                          if (selectedRefundType ==
                                                              "Wallet") {
                                                            newCategoryData =
                                                                'Collectionwallet';
                                                          } else {
                                                            newCategoryData =
                                                                'Collectionpda';
                                                          }
                                                        } else if (selectedData ==
                                                            'Institution') {}
                                                      });
                                                    }),
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.15,
                                        child: TextFormField(
                                          style: Get.textTheme.titleSmall!,
                                          readOnly: true,
                                          controller: fromController,
                                          decoration: InputDecoration(
                                              hintText: 'From Date',
                                              hintStyle: Get
                                                  .textTheme.titleSmall!
                                                  .copyWith(color: Colors.grey),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey))),
                                          onTap: () async {
                                            fromDate = await showDatePicker(
                                                context: context,
                                                firstDate: DateTime(2000),
                                                initialDate: DateTime.now(),
                                                lastDate: DateTime.now());
                                            if (fromDate != null) {
                                              fromController.text =
                                                  dateFormat(fromDate!);
                                            }
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.15,
                                        child: TextFormField(
                                          style: Get.textTheme.titleSmall!,
                                          readOnly: true,
                                          controller: toController,
                                          decoration: InputDecoration(
                                              hintText: 'To Date',
                                              hintStyle: Get
                                                  .textTheme.titleSmall!
                                                  .copyWith(color: Colors.grey),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey))),
                                          onTap: () async {
                                            if (fromDate != null) {
                                              toDate = await showDatePicker(
                                                  context: context,
                                                  firstDate: fromDate!,
                                                  initialDate: DateTime.now(),
                                                  lastDate: DateTime.now());
                                              if (toDate != null) {
                                                toController.text =
                                                    dateFormat(toDate!);
                                              }
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                  "Select FromDate",
                                                  style:
                                                      Get.textTheme.titleSmall,
                                                ),
                                                backgroundColor: Colors.red,
                                              ));
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : (selectedData == 'Institution')
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 12.0),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          height: 45,
                                          child: TypeAheadFormField<
                                              CanteenInsListValues>(
                                            suggestionsBoxController:
                                                _suggestionsBoxController1,
                                            getImmediateSuggestions: true,
                                            textFieldConfiguration:
                                                TextFieldConfiguration(
                                              style: Get.textTheme.titleSmall,
                                              controller: instituteController,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide:
                                                        const BorderSide(
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide:
                                                        const BorderSide(
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                  hintStyle: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .copyWith(
                                                          color: Colors.grey,
                                                          fontSize: 14),
                                                  hintText: controller
                                                          .institutionList
                                                          .isNotEmpty
                                                      ? 'Select Institute'
                                                      : 'No data available',
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior
                                                          .always,
                                                  suffixIcon: (instituteController
                                                          .text.isEmpty)
                                                      ? const Icon(
                                                          Icons
                                                              .keyboard_arrow_down,
                                                          color: Colors.black,
                                                          size: 30,
                                                        )
                                                      : IconButton(
                                                          onPressed: () {
                                                            instituteController
                                                                .clear();
                                                            miId = 0;
                                                            setState(() {});
                                                          },
                                                          icon: const Icon(Icons
                                                              .clear_outlined))),
                                            ),
                                            suggestionsCallback: (v) {
                                              return controller.institutionList
                                                  .where((d) => d.mIName!
                                                      .toLowerCase()
                                                      .contains(
                                                          v.toLowerCase()));
                                            },
                                            itemBuilder: (context, suggestion) {
                                              return ListTile(
                                                onTap: () async {
                                                  setState(() {
                                                    instituteController.text =
                                                        suggestion.mIName!;
                                                    miId = suggestion.mIId!;
                                                    _suggestionsBoxController1
                                                        .close();
                                                  });
                                                },
                                                title: Text(
                                                  suggestion.mIName!,
                                                  style:
                                                      Get.textTheme.titleSmall,
                                                ),
                                              );
                                            },
                                            onSuggestionSelected:
                                                (suggestion) {},
                                            noItemsFoundBuilder: (context) {
                                              return const SizedBox();
                                            },
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
              (selectedData == '')
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: MSkollBtn(
                            title: "Search",
                            onPress: () async {
                              if (selectedData == 'Refund' ||
                                  selectedData == 'Recharge' ||
                                  selectedData == 'Collection') {
                                if (newCategoryData == '') {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                      "Select Sub Category",
                                      style: Get.textTheme.titleSmall!
                                          .copyWith(color: Colors.white),
                                    ),
                                    backgroundColor: Colors.red,
                                  ));
                                  return;
                                }

                              }
                              widget.controller.report(true);
                              await AdminAPI.i.reportAPI(
                                  base: baseUrlFromInsCode(
                                      'canteen', widget.mskoolController),
                                  body: {
                                    "CMMCO_Id": counterId,
                                    "Flag": (selectedData == 'Date Wise')
                                        ? "Date"
                                        : (selectedData == 'Category Wise')
                                            ? "Category"
                                            : (selectedData == 'Item Wise')
                                                ? "Item"
                                                : (selectedData == 'Refund')
                                                    ? "Refund"
                                                    : (selectedData ==
                                                            'Recharge')
                                                        ? "Recharge"
                                                        : (selectedData ==
                                                                'Collection')
                                                            ? "Collection"
                                                            : (selectedData ==
                                                                    'Institution')
                                                                ? "Institutionwise"
                                                                : "",
                                    "Fromdate": (fromDate != null)
                                        ? fromDate!.toIso8601String()
                                        : DateTime.now().toIso8601String(),
                                    "Todate": (toDate != null)
                                        ? toDate!.toIso8601String()
                                        : DateTime.now().toIso8601String(),
                                    "ItemName": itemController.text.trim(),
                                    "Category":
                                        (selectedData == 'Category Wise')
                                            ? selectedCategory.trim()
                                            : newCategoryData.trim(),
                                    "MI_Id": miId
                                  },
                                  controller: widget.controller);
                              widget.controller.report(false);
                            }),
                      ),
                    ),
              const SizedBox(height: 10),
              (selectedData == '')
                  ? const SizedBox()
                  : (widget.controller.isReport.value)
                      ? const Center(
                          child: AnimatedProgressWidget(
                              title: "Loading",
                              desc: "",
                              animationPath: "assets/json/default.json"),
                        )
                      : (widget.controller.reportList.isEmpty &&
                              widget.controller.lastReportList.isEmpty)
                          ? const Center(
                              child: AnimatedProgressWidget(
                                  title: "Data is not Available",
                                  desc: "",
                                  animationPath: "assets/json/nodata.json",animatorHeight: 250,),
                            )
                          : Center(
                              child: (selectedData == 'Date Wise' ||
                                      selectedData == 'Category Wise' ||
                                      selectedData == 'Item Wise' ||
                                      selectedData == 'Institution')
                                  ? Column(
                                      children: [
                                        (widget.controller.reportList
                                                .isNotEmpty)
                                            ? SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: itemWiseTable(),
                                                ),
                                              )
                                            : const SizedBox(),

                                        (widget.controller.lastReportList
                                                .isEmpty)
                                            ? const SizedBox()
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12.0),
                                                child: Text(
                                                  "Total Quantity:- ${widget.controller.lastReportList.first.totalQuantity ?? 0}    Total Amount:- ${widget.controller.lastReportList.first.totalAmount ?? 0}",
                                                  style: Get
                                                      .textTheme.titleSmall!
                                                      .copyWith(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                ),
                                              ),
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        Text(
                                          'Total Amount:- ${widget.controller.lastReportList.first.totalAmount ?? 0}',
                                          style: Get.textTheme.titleSmall!
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                            ),
              (widget.controller.reportList.isNotEmpty)
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MSkollBtn(
                                title: "Excel",
                                onPress: () {
                                  generateAndSaveExcel(
                                      widget.controller.reportList,
                                      context,
                                      fromController.text,
                                      toController.text,
                                      itemController.text,
                                      selectedCategory);
                                }),
                            const SizedBox(width: 10),
                            MSkollBtn(
                                title: "Download PDF",
                                onPress: () {
                                  generateAndSavePDF(
                                      widget.controller.reportList,
                                      context,
                                      fromController.text,
                                      toController.text,
                                      itemController.text,
                                      selectedCategory);
                                })
                          ],
                        ),
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        );
      }),
    );
  }

  DataTable dataTable() {
    return DataTable(
      headingRowHeight: 45,
      headingTextStyle: const TextStyle(color: Colors.white),
      border: TableBorder.all(
        color: Colors.black,
        width: 0.6,
        borderRadius: BorderRadius.circular(10),
      ),
      headingRowColor: WidgetStateColor.resolveWith(
          (states) => Theme.of(context).primaryColor),
      columns: const [
        DataColumn(label: Text("SL No.")),
        DataColumn(label: Text("Date")),
        DataColumn(label: Text("Food Name")),
        DataColumn(label: Text("Qty")),
        DataColumn(label: Text("Amount")),
        DataColumn(label: Text("Total Amount")),
      ],
      rows: List.generate(widget.controller.reportList.length, (index) {
        var i = index + 1;
        var v = widget.controller.reportList.elementAt(index);
        return DataRow(cells: [
          DataCell(Text(i.toString())),
          DataCell(Text(dateFormat(DateTime.parse(
              v.orderedDate ?? DateTime.now().toIso8601String())))),
          DataCell(Text(v.cMMFIFoodItemName ?? '')),
          DataCell(Text(v.totalQuantity.toString())),
          DataCell(
              Text((v.totalAmount! / v.totalQuantity!.toInt()).toString())),
          DataCell(Text(v.totalAmount!.toStringAsFixed(2))),
        ]);
      }),
    );
  }

  DataTable itemWiseTable() {
    // Sort the reportList based on orderedDate
    List<ReportListModelValues> sortedList = List.from(widget.controller.reportList);
    sortedList.sort((a, b) {
      DateTime dateA = DateTime.parse(a.orderedDate ?? DateTime.now().toIso8601String());
      DateTime dateB = DateTime.parse(b.orderedDate ?? DateTime.now().toIso8601String());
      return dateA.compareTo(dateB);
    });

    return DataTable(
      headingRowHeight: 45,
      headingTextStyle: const TextStyle(color: Colors.white),
      border: TableBorder.all(
        color: Colors.black,
        width: 0.6,
        borderRadius: BorderRadius.circular(10),
      ),
      headingRowColor: MaterialStateColor.resolveWith(
              (states) => Theme.of(context).primaryColor),
      columns: const [
        DataColumn(label: Text("SL No.")),
        DataColumn(label: Text("Date")),
        DataColumn(label: Text("Food Name")),
        DataColumn(label: Text("Qty")),
        DataColumn(label: Text("Amount")),
        DataColumn(label: Text("Total Amount")),
      ],
      rows: List.generate(sortedList.length, (index) {
        var i = index + 1;
        var v = sortedList.elementAt(index);
        return DataRow(cells: [
          DataCell(Text(i.toString())),
          DataCell(Text(dateFormat(DateTime.parse(
              v.orderedDate ?? DateTime.now().toIso8601String())))),
          DataCell(Text(v.cMMFIFoodItemName ?? '')),
          DataCell(Text(v.totalQuantity.toString())),
          DataCell(
              Text((v.totalAmount! / v.totalQuantity!.toInt()).toString())),
          DataCell(Text(v.totalAmount!.toStringAsFixed(2))),
        ]);
      }),
    );
  }

}
