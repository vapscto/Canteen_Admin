import 'package:canteen_management/canteen_admin/model/counter_wise_food_model.dart';
import 'package:canteen_management/canteen_management/controller/canteen_controller.dart';
import 'package:canteen_management/controller/mskool_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemListWidget extends StatefulWidget {
  final CanteenManagementController canteenManagementController;
  final CounterWiseFoodModelValues values;
  final MskoolController mskoolController;

  const ItemListWidget(
      {super.key,
      required this.canteenManagementController,
      required this.values,
      required this.mskoolController});

  @override
  State<ItemListWidget> createState() => _ItemListWidgetState();
}

class _ItemListWidgetState extends State<ItemListWidget> {
  int foodId = 0;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: Get.width,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                widget.values.cmmfIPathURL ?? '',
                fit: BoxFit.fill,
                errorBuilder: (context, object, stackTrace) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "Image is not available",
                      maxLines: 3,
                      style: Get.textTheme.titleSmall,
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.values.cmmfIFoodItemName!.toUpperCase(),
                        style: Get.textTheme.titleMedium,
                      ),
                    ),
                    Text(
                      ' ₹ ${widget.values.cmmfIUnitRate} ',
                      style: Get.textTheme.titleSmall!
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                    // const SizedBox(width: 2),
                    (widget.values.cmmfIFoodItemFlag == true)
                        ? const Icon(
                      Icons.circle,
                      size: 13,
                      color: Colors.green,
                    )
                        : const Icon(
                      Icons.circle,
                      size: 13,
                      color: Colors.red,
                    )
                  ],
                ),
              ],
            ),
          ),
          Obx(() {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              child: Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: (widget.canteenManagementController
                              .addToCartList
                              .contains(widget.values))
                          ? Colors.green
                          : Theme.of(context).primaryColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 26, vertical: 14.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: () {
                      if (widget.canteenManagementController.addToCartList.isEmpty) {
                        widget.canteenManagementController.addToCartList.add(widget.values);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            // shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(8)),
                            elevation: 2,
                            content: Text(
                              "${widget.values.cmmfIFoodItemName} add to cart",
                              style: Get.textTheme.titleSmall!
                                  .copyWith(color: Colors.white),
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );
                        // Get.back();
                      } else {
                        if (widget.canteenManagementController.addToCartList
                            .contains(widget.values)) {
                          widget.canteenManagementController.addToCartList
                              .remove(widget.values);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              // shape: RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.circular(8)),
                              elevation: 2,
                              content: Text(
                                "${widget.values.cmmfIFoodItemName} removed from cart",
                                style: Get.textTheme.titleSmall!
                                    .copyWith(color: Colors.white),
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        } else {
                          widget.canteenManagementController.addToCartList.add(widget.values);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: const Duration(milliseconds: 400),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              elevation: 2,
                              content: Text(
                                "${widget.values.cmmfIFoodItemName} add to cart",
                                style: Get.textTheme.titleSmall!
                                    .copyWith(color: Colors.white),
                              ),
                              backgroundColor: Colors.green,
                            ),
                          );
                          // Get.back();
                        }
                      }
                    },
                    child: Text(
                      "Add to Cart",
                      style: Theme.of(context).textTheme.labelSmall!.merge(
                            const TextStyle(
                              color: Colors.white,
                              letterSpacing: 0.3,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                    ),
                  )),
            );
          }),
        ],
      ),
    );
  }
}
