import 'package:canteen_management/canteen_admin/add_details/model/added_category_model.dart';
import 'package:canteen_management/canteen_management/model/food_list_model.dart';
import 'package:get/get.dart';

import 'model/canteen_ins_list.dart';
import 'model/counter_list_model.dart';

class AddDetailsController extends GetxController {
  RxBool isCategoryLoading = RxBool(false);

  void category(bool l) {
    isCategoryLoading.value = l;
  }

  RxList<AddedCategoryModelValues> addedCategoryList =
      <AddedCategoryModelValues>[].obs;
  RxList<AddedCategoryModelValues> activeCategoryList =
      <AddedCategoryModelValues>[].obs;
  RxBool isCounter = RxBool(false);

  void counter(bool b) {
    isCounter.value = b;
  }

  RxList<FoodListModelValues> foodList = <FoodListModelValues>[].obs;
  RxBool isFoodLoading = RxBool(false);

  void foodData(bool l) {
    isFoodLoading.value = l;
  }

  RxList<CounterListModelValues> counterListData =
      <CounterListModelValues>[].obs;
  RxBool isCounterLoading = RxBool(false);

  void counterData(bool b) {
    isCounterLoading.value = b;
  }

  bool flag = false;
  RxList<CanteenInsListValues> instituteList = <CanteenInsListValues>[].obs;
  RxList<CanteenInsListValues> selectedInstituteList =
      <CanteenInsListValues>[].obs;

  RxBool selectAll = RxBool(false);
  List<bool> isSelect = [];
  void addData(CanteenInsListValues data){
    selectedInstituteList.add(data);
  }
  void removeData(int index){
    selectedInstituteList.removeAt(index);
  }
}
