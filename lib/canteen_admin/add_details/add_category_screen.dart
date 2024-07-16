import 'package:canteen_management/canteen_admin/add_details/add_details_api.dart';
import 'package:canteen_management/canteen_admin/add_details/add_details_controller.dart';
import 'package:canteen_management/canteen_management/controller/canteen_controller.dart';
import 'package:canteen_management/controller/global_utility.dart';
import 'package:canteen_management/controller/mskool_controller.dart';
import 'package:canteen_management/widgets/animated_progress.dart';
import 'package:canteen_management/widgets/cancel_btn.dart';
import 'package:canteen_management/widgets/custom_appbar.dart';
import 'package:canteen_management/widgets/m_skool_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

class AddCategoryScreen extends StatefulWidget {
  final int miId;
  final MskoolController mskoolController;
  final CanteenManagementController controller;

  const AddCategoryScreen(
      {super.key,
      required this.miId,
      required this.mskoolController,
      required this.controller});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final nameController = TextEditingController();
  final remarkController = TextEditingController();
  final canteenNameController = TextEditingController();
  final canteenRemarkController = TextEditingController();
  final _key = GlobalKey<FormState>();
  AddDetailsController controller = Get.put(AddDetailsController());

  _onLoad() async {
    controller.category(true);
    await AddDetailsAPI.instance.categoryList(
        base: baseUrlFromInsCode('canteen', widget.mskoolController),
        counterId: counterId,
        controller: controller);

    controller.category(false);
  }



  final counterController = TextEditingController();
  final suggestionController = SuggestionsBoxController();

  @override
  void initState() {
    _onLoad();
    categoryId = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Category Master').getAppBar(),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Add Category",
                  style: Get.textTheme.titleMedium!
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter name';
                      }
                      return null;
                    },
                    style: Get.textTheme.titleSmall,
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Category Name',
                      labelStyle: Get.textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w500,fontSize: 15),
                      hintText: 'Category Name',
                      hintStyle: Get.textTheme.titleSmall!
                          .copyWith(color: Colors.grey),
                      contentPadding: const EdgeInsets.all(5),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.red)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.grey)),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(width: MediaQuery.of(context).size.width * 0.3,
                  child: TextFormField(
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Please enter Remarks';
                    //   }
                    // },
                    style: Get.textTheme.titleSmall,
                    controller: remarkController,
                    decoration: InputDecoration(
                      labelText: 'Category Remarks',
                      labelStyle: Get.textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w500,fontSize: 15),
                      hintText: 'Category Remarks',
                      hintStyle: Get.textTheme.titleSmall!
                          .copyWith(color: Colors.grey),
                      contentPadding: const EdgeInsets.all(5),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.red)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.grey)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MSkollBtn(
                          title: "Save",
                          onPress: () async {
                            if (_key.currentState!.validate() == true) {
                              await AddDetailsAPI.instance.saveCategory(
                                  base: baseUrlFromInsCode(
                                      'canteen', widget.mskoolController),
                                  body: {
                                    "CMMCA_CategoryName": nameController.text,
                                    "CMMCA_Remarks": remarkController.text,
                                    "CMMCO_Id": counterId,
                                    "CMMCA_Id": categoryId,
                                  }).then((value) {
                                _onLoad();
                                if (value!.toLowerCase() == 'save') {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          backgroundColor: Colors.green,
                                          content: Text(
                                            "Category Added Successfully",
                                            style: Get.textTheme.titleSmall!
                                                .copyWith(color: Colors.white),
                                          )));
                                  nameController.clear();
                                  remarkController.clear();
                                } else if (value.toLowerCase() == 'update') {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          backgroundColor: Colors.green,
                                          content: Text(
                                            "Category Updated Successfully",
                                            style: Get.textTheme.titleSmall!
                                                .copyWith(color: Colors.white),
                                          )));
                                } else if (value.toLowerCase() == 'exit') {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text(
                                            "Category Name Already Exist",
                                            style: Get.textTheme.titleSmall!
                                                .copyWith(color: Colors.white),
                                          )));
                                } else if (value.toLowerCase() == 'Notupdate') {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text(
                                            "Category is not Updated",
                                            style: Get.textTheme.titleSmall!
                                                .copyWith(color: Colors.white),
                                          )));
                                } else if (value.toLowerCase() == 'Notsave') {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text(
                                            "Category is not Saved",
                                            style: Get.textTheme.titleSmall!
                                                .copyWith(color: Colors.white),
                                          )));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text(
                                            "Something went Wrong",
                                            style: Get.textTheme.titleSmall!
                                                .copyWith(color: Colors.white),
                                          )));
                                }
                              });
                            }
                          }),
                      RejectBtn(
                          title: "Cancel",
                          onPress: () {
                            _onLoad();
                            nameController.clear();
                            remarkController.clear();
                          })
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          Obx(() {
            return (controller.isCategoryLoading.value)
                ? const Center(
                    child: AnimatedProgressWidget(
                        title: "Loading",
                        desc: "",
                        animationPath: "assets/json/default.json"),
                  )
                : controller.addedCategoryList.isEmpty
                    ? const Center(
                        child: AnimatedProgressWidget(
                            title: "Data is not Available",
                            desc: "",
                            animationPath: "assets/json/nodata.json"),
                      )
                    : Align(
                        alignment: Alignment.center,
                        child: RawScrollbar(
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
                              controller: scrollController,
                              scrollDirection: Axis.horizontal,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: DataTable(
                                  headingTextStyle:
                                      const TextStyle(color: Colors.white),
                                  border: TableBorder.all(
                                    color: Colors.black,
                                    width: 0.6,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  headingRowColor: WidgetStateColor.resolveWith(
                                        (states) => Theme.of(context).primaryColor,
                                  ),
                                  columns: const [
                                    DataColumn(label: Text("Sl. No.")),
                                    DataColumn(label: Text("Category Name")),
                                    DataColumn(label: Text("Remarks")),
                                    DataColumn(label: Text('Action')),
                                  ],
                                  rows: List.generate(
                                      controller.addedCategoryList.length, (index) {
                                    var i = index + 1;
                                    var d = controller.addedCategoryList
                                        .elementAt(index);
                                    return DataRow(cells: [
                                      DataCell(Text(i.toString())),
                                      DataCell(Text(d.cmmcACategoryName ?? '')),
                                      DataCell(Text(d.cmmcARemarks ?? "")),
                                      DataCell(Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              nameController.clear();
                                              remarkController.clear();
                                              nameController.text =
                                                  d.cmmcACategoryName ?? "";
                                              remarkController.text =
                                                  d.cmmcARemarks ?? "";
                                              categoryId = d.cmmcAId ?? 0;
                                            },
                                            icon: Icon(
                                              Icons.edit,
                                              color: Theme.of(context).primaryColor,
                                            ),
                                            padding: EdgeInsets.zero,
                                            visualDensity:
                                                const VisualDensity(horizontal: 0),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              await AddDetailsAPI.instance
                                                  .activeAPI(
                                                      base: baseUrlFromInsCode(
                                                          'canteen',
                                                          widget.mskoolController),
                                                      body: {
                                                    "CMMCA_Id": d.cmmcAId,
                                                    "cmmcA_ActiveFlag":
                                                        d.cmmcAActiveFlag
                                                  }).then((value) {
                                                showDialog(
                                                    context: context,
                                                    builder: (_) {
                                                      return AlertDialog(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
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
                                            child: (d.cmmcAActiveFlag == false)
                                                ? Text(
                                                    "Activate",
                                                    style: Get.textTheme.titleSmall!
                                                        .copyWith(
                                                            color: Colors.green,
                                                            fontWeight:
                                                                FontWeight.w600),
                                                  )
                                                : Text(
                                                    "Deactivate",
                                                    style: Get.textTheme.titleSmall!
                                                        .copyWith(
                                                            color: Colors.red,
                                                            fontWeight:
                                                                FontWeight.w600),
                                                  ),
                                          ),
                                        ],
                                      ))
                                    ]);
                                  }),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
          }),
        ],
      ),
    );
  }
  final scrollController = ScrollController();
  int cmcAId = 0;
  int cmoId = 0;
  int categoryId = 0;
}
