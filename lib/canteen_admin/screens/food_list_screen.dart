import 'package:canteen_management/controller/mskool_controller.dart';
import 'package:canteen_management/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../canteen_management/constants/canteen_constants.dart';
import '../admin_controller/admin_controller.dart';

class FoodListScreen extends StatefulWidget {
  final AdminController controller;
  final int miId;
  final MskoolController mskoolController;

  const FoodListScreen(
      {super.key,
      required this.controller,
      required this.miId,
      required this.mskoolController});

  @override
  State<FoodListScreen> createState() => _FoodListScreenState();
}

class _FoodListScreenState extends State<FoodListScreen> {
  @override
  void initState() {
    super.initState();
  }

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Food List').getAppBar(),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  height: 40,
                  child: TextFormField(
                    controller: searchController,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                        hintText: 'Search....',
                        hintStyle:
                            Get.textTheme.titleSmall!.copyWith(color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey))),
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            menuItems[index]['isSelect'] =
                                !menuItems[index]['isSelect'];
                          });
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: menuItems[index]['isSelect'] == true
                              ? const Color(0xffFE907A)
                              : const Color(0xffAEFE7A),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              menuItems[index]['name'],
                              style: Get.textTheme.titleSmall!
                                  .copyWith(color: ( menuItems[index]['isSelect'] == true
                                  )? Colors.white:Colors.black),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 10);
                    },
                    itemCount: menuItems.length),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
