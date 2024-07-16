import 'package:canteen_management/widgets/custom_appbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/global_utility.dart';
import '../../controller/mskool_controller.dart';
import '../api/item_list_api.dart';
import '../controller/canteen_controller.dart';
import '../model/food_list_model.dart';

class ButtonSheetContainer extends StatefulWidget {
  final CanteenManagementController controller;
  final FoodListModelValues values;
  final int index;
  final MskoolController mskoolController;

  const ButtonSheetContainer(
      {super.key,
      required this.values,
      required this.controller,
      required this.index,
      required this.mskoolController});

  @override
  State<ButtonSheetContainer> createState() => _ButtonSheetContainerState();
}

class _ButtonSheetContainerState extends State<ButtonSheetContainer> {
  List<String> imageList = [];
  bool isLoading = false;

  _loadImage() async {
    setState(() {
      isLoading = true;
    });
    await CanteenItemApi.ap.foodImageList(
      base: baseUrlFromInsCode('canteen', widget.mskoolController),
      canteenManagementController: widget.controller,
      cmmfiId: widget.values.cmmfIId!,
    );
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    _loadImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Obx(() {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: const CustomAppBar(title: "Add to Cart").getAppBar(),
            body: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                (widget.controller.foodImageList.isEmpty)
                    ? const SizedBox()
                    : SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: CarouselSlider.builder(
                          itemCount: widget.controller.foodImageList.length,
                          itemBuilder: (_, index, previousIndex) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  widget.controller.foodImageList[index]
                                      .icaIAttachment!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                          options: CarouselOptions(
                            autoPlayAnimationDuration:
                                const Duration(seconds: 3),
                            autoPlayInterval: const Duration(seconds: 5),
                            viewportFraction: 1.0,
                            enableInfiniteScroll: false,
                            autoPlay: true,
                            onPageChanged: (index, reason) {},
                          ),
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.values.cmmfIFoodItemName!.toUpperCase(),
                        style: Get.textTheme.titleMedium,
                      ),
                      Text(
                        "₹ ${widget.values.cmmfIUnitRate}",
                        style: Get.textTheme.titleMedium,
                      ),
                      Text(
                        widget.values.cmmfIFoodItemDescription ?? '',
                        style: Get.textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
    // });
  }
}
