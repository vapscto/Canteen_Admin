import 'dart:io';

import 'package:canteen_management/canteen_admin/add_details/add_details_api.dart';
import 'package:canteen_management/canteen_admin/add_details/add_details_controller.dart';
import 'package:canteen_management/canteen_management/model/food_list_model.dart';
import 'package:canteen_management/controller/global_utility.dart';
import 'package:canteen_management/controller/mskool_controller.dart';
import 'package:canteen_management/main.dart';
import 'package:canteen_management/model/upload_image_model.dart';
import 'package:canteen_management/widgets/animated_progress.dart';
import 'package:canteen_management/widgets/cancel_btn.dart';
import 'package:canteen_management/widgets/custom_appbar.dart';
import 'package:canteen_management/widgets/m_skool_btn.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

import '../../api/upload_file.dart';
import 'model/added_category_model.dart';

class AddFoodItemScreen extends StatefulWidget {
  final MskoolController mskoolController;
  final int miId;

  const AddFoodItemScreen(
      {super.key, required this.mskoolController, required this.miId});

  @override
  State<AddFoodItemScreen> createState() => _AddFoodItemScreenState();
}

class _AddFoodItemScreenState extends State<AddFoodItemScreen> {
  AddDetailsController controller = Get.put(AddDetailsController());
  final categoryController = TextEditingController();
  final counterController = TextEditingController();
  String itemType = '';
  final foodNameController = TextEditingController();
  final desController = TextEditingController();
  final codeController = TextEditingController();
  final rateController = TextEditingController();
  final searchController = TextEditingController();
  final suggestionController = SuggestionsBoxController();
  final suggestionController1 = SuggestionsBoxController();
  List<String> item = ['Veg', 'Non-Veg'];
  final _key = GlobalKey<FormState>();
  RxList<FoodListModelValues> filterList = <FoodListModelValues>[].obs;

  _onLoad() async {
    await AddDetailsAPI.instance.categoryList(
        base: baseUrlFromInsCode('canteen', widget.mskoolController),
        counterId: counterId,
        controller: controller);
    controller.foodData(true);
    await AddDetailsAPI.instance.getFoodList(
        base: baseUrlFromInsCode('canteen', widget.mskoolController),
        miId: widget.miId,
        controller: controller);
    controller.foodData(false);
    filterList.value = controller.foodList;
  }

  _getFilter(String data) async {
    if (data.isEmpty) {
      filterList.value = controller.foodList;
    } else {
      filterList.value = controller.foodList.where((value) {
        return value.cmmfIFoodItemName!
                .toLowerCase()
                .contains(data.toLowerCase()) ||
            value.foodCode!.toLowerCase().contains(data.toLowerCase());
      }).toList();
    }
    setState(() {});
  }

  @override
  void initState() {
    _onLoad();
    super.initState();
  }

  bool isVeg = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: 'Master Food Items').getAppBar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Form(
                    key: _key,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                          child: TypeAheadFormField<AddedCategoryModelValues>(
                              suggestionsBoxController: suggestionController,
                              getImmediateSuggestions: true,
                              textFieldConfiguration: TextFieldConfiguration(
                                style: Get.textTheme.titleSmall,
                                controller: categoryController,
                                decoration: InputDecoration(
                                    hintStyle: Get.textTheme.titleSmall,
                                    hintText: 'Select Category',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                            color: Colors.grey)),
                                    suffixIcon:
                                        (categoryController.text.isEmpty)
                                            ? const Icon(
                                                Icons.keyboard_arrow_down,
                                                color: Colors.black,
                                                size: 30,
                                              )
                                            : IconButton(
                                                onPressed: () {
                                                  categoryController.clear();
                                                  categoryId = 0;
                                                  setState(() {});
                                                },
                                                icon: const Icon(
                                                    Icons.clear_outlined))),
                              ),
                              onSuggestionSelected: (v) {},
                              itemBuilder: (context, data) {
                                return ListTile(
                                  title: Text(
                                    data.cmmcACategoryName ?? '',
                                    style: Get.textTheme.titleSmall,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      categoryController.text =
                                          data.cmmcACategoryName ?? '';
                                      categoryId = data.cmmcAId!;
                                      suggestionController.close();
                                    });
                                  },
                                );
                              },
                              suggestionsCallback: (v) {
                                return controller.activeCategoryList.where(
                                    (d) => d.cmmcACategoryName!
                                        .toLowerCase()
                                        .contains(v.toLowerCase()));
                              }),
                        ),
                        const SizedBox(height: 8),
                        Card(
                          color: Colors.white,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(item.length, (index) {
                              return SizedBox(
                                width: MediaQuery.of(context).size.width * 0.09,
                                child: RadioListTile(
                                  visualDensity: const VisualDensity(
                                      vertical: 0, horizontal: -4),
                                  contentPadding: EdgeInsets.zero,
                                  hoverColor: Colors.black12,
                                  fillColor: WidgetStateColor.resolveWith(
                                      (states) =>
                                          Theme.of(context).primaryColor),
                                  title: Text(
                                    item[index],
                                    style: Get.textTheme.titleSmall!.copyWith(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  groupValue: itemType,
                                  value: item[index],
                                  onChanged: (value) {
                                    setState(() {
                                      itemType = value!;
                                      if (itemType == 'Veg') {
                                        isVeg = true;
                                      } else {
                                        isVeg = false;
                                      }
                                      logger.i(isVeg);
                                    });
                                  },
                                ),
                              );
                            }),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 40,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return;
                              }
                              return null;
                            },
                            controller: foodNameController,
                            style: Get.textTheme.titleSmall,
                            decoration: InputDecoration(
                                labelText: 'Food Item Name',
                                labelStyle: Get.textTheme.titleSmall!.copyWith(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                                hintText: 'Food Item Name',
                                hintStyle: Get.textTheme.titleSmall!
                                    .copyWith(color: Colors.grey),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                )),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 40,
                          child: TextFormField(
                            controller: desController,
                            style: Get.textTheme.titleSmall,
                            decoration: InputDecoration(
                                labelText: 'Food Item Description',
                                labelStyle: Get.textTheme.titleSmall!.copyWith(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                                hintText: 'Food Item Description',
                                hintStyle: Get.textTheme.titleSmall!
                                    .copyWith(color: Colors.grey),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                )),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 40,
                          child: TextFormField(
                            controller: codeController,
                            style: Get.textTheme.titleSmall,
                            decoration: InputDecoration(
                                labelText: 'Food Item Code',
                                labelStyle: Get.textTheme.titleSmall!.copyWith(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                                hintText: 'Food Item Code',
                                hintStyle: Get.textTheme.titleSmall!
                                    .copyWith(color: Colors.grey),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                )),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 40,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return;
                              }
                              return null;
                            },
                            controller: rateController,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[0-9.]"))
                            ],
                            style: Get.textTheme.titleSmall,
                            decoration: InputDecoration(
                                labelText: 'Food Item Rate',
                                labelStyle: Get.textTheme.titleSmall!.copyWith(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                                hintText: 'Food Item Rate',
                                hintStyle: Get.textTheme.titleSmall!
                                    .copyWith(color: Colors.grey),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                )),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Column(
                          children: [
                            Text(
                              "Upload Image",
                              style: Get.textTheme.titleMedium!.copyWith(
                                  color: Theme.of(context).primaryColor),
                            ),
                            const SizedBox(height: 8),
                            (path == '')
                                ? GestureDetector(
                                    onTap: () {
                                      loading = false;
                                      _pickFile();
                                    },
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border:
                                              Border.all(color: Colors.black),
                                          color: Colors.grey),
                                      child: const Center(
                                        child: Icon(
                                          Icons.add,
                                          size: 60,
                                        ),
                                      ),
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {
                                      loading = false;
                                      _pickFile();
                                    },
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border:
                                              Border.all(color: Colors.black),
                                          color: Colors.grey,
                                          boxShadow: const [
                                            BoxShadow(
                                                offset: Offset(2, 2.1),
                                                blurRadius: 0,
                                                spreadRadius: 0,
                                                color: Colors.black12)
                                          ]),
                                      child: Center(
                                        child: (loading == true)
                                            ? const CircularProgressIndicator(
                                                backgroundColor:
                                                    Colors.amberAccent,
                                                valueColor:
                                                    AlwaysStoppedAnimation(
                                                        Colors.teal),
                                                strokeWidth: 10,
                                              )
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.network(
                                                  path,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              MSkollBtn(
                                  title: "Save",
                                  onPress: () async {
                                    if (itemType == '') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                        "Select Food Type",
                                        style: Get.textTheme.titleSmall,
                                      )));
                                      return;
                                    } else if (foodNameController
                                        .text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                        "Enter Food Name",
                                        style: Get.textTheme.titleSmall,
                                      )));
                                      return;
                                    } else if (codeController.text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                        "Enter Food Code",
                                        style: Get.textTheme.titleSmall,
                                      )));
                                      return;
                                    } else if (rateController.text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                        "Enter Food Amount",
                                        style: Get.textTheme.titleSmall,
                                      )));
                                      return;
                                    } else if (path == '') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                        "select Image",
                                        style: Get.textTheme.titleSmall,
                                      )));
                                      return;
                                    } else {
                                      await AddDetailsAPI.instance.saveFood(
                                          base: baseUrlFromInsCode('canteen',
                                              widget.mskoolController),
                                          body: {
                                            "MI_Id": widget.miId,
                                            "CMMFI_FoodItemName":
                                                foodNameController.text,
                                            "CMMFI_FoodItemDescription":
                                                desController.text,
                                            "CMMFI_FoodItemCode":
                                                codeController.text,
                                            "CMMFI_UnitRate": double.parse(
                                                rateController.text),
                                            "CMMFI_Id_FilePath_Array": [
                                              {
                                                "IHW_FilePath":
                                                    (imageData != null)
                                                        ? imageData!.path
                                                        : path,
                                                "FileName": (imageData != null)
                                                    ? imageData!.name
                                                    : ''
                                              }
                                            ],
                                            "CMMFI_OutofStockFlg": false,
                                            "CMMFI_FoodItemFlag": isVeg,
                                            "CMMCA_Id": categoryId,
                                            "CMMFI_Id": cmmfId,
                                            "CMMCO_Id": counterId,
                                          }).then((value) {
                                        if (value!.toLowerCase() == 'save') {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  backgroundColor: Colors.green,
                                                  content: Text(
                                                    "Food Item Added Successfully",
                                                    style: Get
                                                        .textTheme.titleSmall!
                                                        .copyWith(
                                                            color:
                                                                Colors.white),
                                                  )));
                                          setState(() {
                                            foodNameController.clear();
                                            desController.clear();
                                            rateController.clear();
                                            itemType = '';
                                            imageData = null;
                                            categoryId = 0;
                                            cmmfId = 0;
                                            categoryController.clear();
                                            path = '';
                                            codeController.clear();
                                          });
                                          _onLoad();
                                        } else if (value.toLowerCase() ==
                                            'update') {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  backgroundColor: Colors.green,
                                                  content: Text(
                                                    "Food Item Updated Successfully",
                                                    style: Get
                                                        .textTheme.titleSmall!
                                                        .copyWith(
                                                            color:
                                                                Colors.white),
                                                  )));
                                          setState(() {
                                            foodNameController.clear();
                                            desController.clear();
                                            rateController.clear();
                                            itemType = '';
                                            imageData = null;
                                            categoryId = 0;
                                            cmmfId = 0;
                                            path = '';
                                          });

                                          codeController.clear();
                                          _onLoad();
                                        } else if (value.toLowerCase() ==
                                            'exit') {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  backgroundColor: Colors.red,
                                                  content: Text(
                                                    "Food Item Already Exist",
                                                    style: Get
                                                        .textTheme.titleSmall!
                                                        .copyWith(
                                                            color:
                                                                Colors.white),
                                                  )));
                                        } else if (value.toLowerCase() ==
                                            'Notupdate') {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  backgroundColor: Colors.red,
                                                  content: Text(
                                                    "Food Item is not Updated",
                                                    style: Get
                                                        .textTheme.titleSmall!
                                                        .copyWith(
                                                            color:
                                                                Colors.white),
                                                  )));
                                        } else if (value.toLowerCase() ==
                                            'Notsave') {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  backgroundColor: Colors.red,
                                                  content: Text(
                                                    "Food item is not Saved",
                                                    style: Get
                                                        .textTheme.titleSmall!
                                                        .copyWith(
                                                            color:
                                                                Colors.white),
                                                  )));
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  backgroundColor: Colors.red,
                                                  content: Text(
                                                    "Something went Wrong",
                                                    style: Get
                                                        .textTheme.titleSmall!
                                                        .copyWith(
                                                            color:
                                                                Colors.white),
                                                  )));
                                        }
                                        path = '';
                                      });
                                    }
                                  }),
                              RejectBtn(
                                  title: "Cancel",
                                  onPress: () {
                                    setState(() {
                                      foodNameController.clear();
                                      desController.clear();
                                      rateController.clear();
                                      itemType = '';
                                      imageData = null;
                                      categoryController.clear();
                                      path = '';
                                      codeController.clear();
                                      _onLoad();
                                    });
                                  }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 40,
                    child: TextFormField(
                      style: Get.textTheme.titleSmall,
                      controller: searchController,
                      onChanged: (value) {
                        setState(() {
                          _getFilter(value);
                        });
                      },
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(5),
                          hintText: 'Search Food Name',
                          hintStyle: Get.textTheme.titleSmall!
                              .copyWith(color: Colors.grey),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.grey))),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Obx(() {
                return (controller.isFoodLoading.value)
                    ? const Center(
                        child: AnimatedProgressWidget(
                            title: "Loading",
                            desc: "",
                            animationPath: "assets/json/default.json"),
                      )
                    : controller.foodList.isEmpty
                        ? const Center(
                            child: AnimatedProgressWidget(
                                title: "Food is not Available",
                                desc: "",
                                animationPath: "assets/json/nodata.json"),
                          )
                        : RawScrollbar(
                            controller: scrollController,
                            thumbColor: const Color(0xFF1E38FC),
                            trackColor: const Color.fromRGBO(223, 239, 253, 1),
                            trackRadius: const Radius.circular(10),
                            trackVisibility: true,
                            radius: const Radius.circular(10),
                            thickness: 14,
                            thumbVisibility: true,
                            mainAxisMargin: 10,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                controller: scrollController,
                                physics: const AlwaysScrollableScrollPhysics(),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: DataTable(
                                    dataRowMinHeight: MediaQuery.of(context).size.height*0.15,
                                    dataRowMaxHeight: MediaQuery.of(context).size.height*0.15,
                                    headingTextStyle:
                                        const TextStyle(color: Colors.white),
                                    dataTextStyle: Get.textTheme.titleSmall,
                                    border: TableBorder.all(
                                      color: Colors.black,
                                      width: 0.6,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    headingRowColor: WidgetStateColor.resolveWith(
                                        (states) => Theme.of(context).primaryColor),
                                    columns: const [
                                      DataColumn(label: Text("Sl. No.")),
                                      DataColumn(label: Text("Category")),
                                      DataColumn(label: Text("Food Item Name")),
                                      DataColumn(
                                          label: Text('Food Item Description')),
                                      DataColumn(label: Text("Food Item Code")),
                                      DataColumn(label: Text('Unit Rate')),
                                      DataColumn(label: Text('Image')),
                                      DataColumn(label: Text('Action')),
                                      DataColumn(
                                          label: Text('Activate/Deactivate')),
                                    ],
                                    rows: List.generate(filterList.length, (index) {
                                      var i = index + 1;
                                      var d = filterList.elementAt(index);

                                      return DataRow(cells: [
                                        DataCell(Text(i.toString())),
                                        DataCell(Text(
                                          d.cmmcACategoryName ?? '',
                                          maxLines: 2,
                                        )),
                                        DataCell(Row(
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.09,
                                              child: Text(
                                                d.cmmfIFoodItemName ?? "",
                                                maxLines: 4,
                                              ),
                                            ),
                                            Icon(
                                              Icons.circle,
                                              size: 10,
                                              color: (d.cmmfIFoodItemFlag == true)
                                                  ? Colors.green
                                                  : Colors.red,
                                            )
                                          ],
                                        )),
                                        DataCell(Text(
                                          d.cmmfIFoodItemDescription ?? "",
                                          maxLines: 2,
                                        )),
                                        DataCell(Text(
                                          d.foodCode ?? "",
                                          maxLines: 2,
                                        )),
                                        DataCell(Text(d.cmmfIUnitRate.toString())),
                                        DataCell(Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: (d.cmmfIPathURL == null)
                                              ? const SizedBox()
                                              : Container(
                                                  height: 150,
                                                  width: 150,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(10),
                                                      border: Border.all(
                                                          color: Colors.black12)),
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(10),
                                                      child: Image.network(
                                                        d.cmmfIPathURL ?? '',
                                                        fit: BoxFit.fill,
                                                      )),
                                                ),
                                        )),
                                        DataCell(
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                categoryController.text =
                                                    d.cmmcACategoryName ?? "";
                                                categoryId = d.cmmcAId ?? 0;
                                                cmmfId = d.cmmfIId ?? 0;
                                                foodNameController.text =
                                                    d.cmmfIFoodItemName ?? "";
                                                desController.text =
                                                    d.cmmfIFoodItemDescription ??
                                                        "";
                                                rateController.text =
                                                    d.cmmfIUnitRate.toString();
                                                path = d.cmmfIPathURL ?? '';
                                                codeController.text =
                                                    d.foodCode ?? "";
                                                if (d.cmmfIFoodItemFlag == true) {
                                                  isVeg = true;
                                                  itemType = item[0];
                                                } else {
                                                  isVeg = false;
                                                  itemType = item[1];
                                                }
                                              });
                                            },
                                            icon: Icon(
                                              Icons.edit_square,
                                              color: Theme.of(context).primaryColor,
                                            ),
                                            padding: EdgeInsets.zero,
                                            visualDensity:
                                                const VisualDensity(horizontal: 0),
                                          ),
                                        ),
                                        DataCell(TextButton(
                                          onPressed: () async {
                                            await AddDetailsAPI.instance
                                                .activeFood(
                                                    base: baseUrlFromInsCode(
                                                        'canteen',
                                                        widget.mskoolController),
                                                    body: {
                                                      "MI_Id": d.mIId,
                                                      "CMMFI_Id": d.cmmfIId,
                                                      "CMMFI_ActiveFlg": filterList
                                                                  .elementAt(index)
                                                                  .cmmfIActiveFlg ==
                                                              true
                                                          ? true
                                                          : false
                                                    },
                                                    controller: controller)
                                                .then((value) {
                                              showDialog(
                                                  context: context,
                                                  builder: (_) {
                                                    return AlertDialog(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  10)),
                                                      content: Text(
                                                        value!,
                                                        style: Get
                                                            .textTheme.titleSmall,
                                                        maxLines: 2,
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () {
                                                              Get.back();
                                                            },
                                                            child: Text(
                                                              "OK",
                                                              style: Get.textTheme
                                                                  .titleMedium!
                                                                  .copyWith(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .primaryColor),
                                                            ))
                                                      ],
                                                    );
                                                  });
                                              _onLoad();
                                            });
                                          },
                                          child: (filterList
                                                      .elementAt(index)
                                                      .cmmfIActiveFlg ==
                                                  false)
                                              ? Text(
                                                  "Activate",
                                                  style: Get.textTheme.titleSmall!
                                                      .copyWith(
                                                          color: Colors.green,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                )
                                              : (d.cmmfIActiveFlg == true)
                                                  ? Text(
                                                      "Deactivate",
                                                      style: Get
                                                          .textTheme.titleSmall!
                                                          .copyWith(
                                                              color: Colors.red,
                                                              fontWeight:
                                                                  FontWeight.w600),
                                                    )
                                                  : const SizedBox(),
                                        ))
                                      ]);
                                    }),
                                  ),
                                ),
                              ),
                            ),
                          );
              })
            ],
          ),
        ));
  }

  final scrollController = ScrollController();

  _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );
    if (result != null) {
      setState(() {
        loading = true;
      });
      imageData = await uploadAtt(
          miId: widget.miId, file: File(result.files.single.path!));
      setState(() {
        loading = false;
      });
      path = imageData!.path;
      logger.w(imageData!.path);
    } else {}
  }

  UploadHwCwModel? imageData;

  bool loading = false;
  int categoryId = 0;
  int cmmfId = 0;
  String path = '';

  @override
  void dispose() {
    imageData = null;
    super.dispose();
  }
}
