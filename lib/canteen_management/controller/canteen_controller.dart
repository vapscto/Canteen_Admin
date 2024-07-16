import 'package:canteen_management/canteen_admin/add_details/model/canteen_ins_list.dart';
import 'package:canteen_management/canteen_admin/add_details/model/counter_list_model.dart';
import 'package:canteen_management/canteen_admin/model/counter_wise_food_model.dart';
import 'package:get/get.dart';

import '../model/bill_model.dart';
import '../model/card_reader_model.dart';
import '../model/food_category_model.dart';
import '../model/food_image_list_model.dart';
import '../model/generate_pin_model.dart';
import '../model/student_wallet_model.dart';
import '../model/transation_his_model.dart';

class CanteenManagementController extends GetxController {
  String item = 'All';
  List userType = ['Student', 'Staff'];
  String selectedType = '';
  RxInt count = 0.obs;
  RxBool isItemLoading = RxBool(false);

  itemLoading(bool loading) {
    isItemLoading.value = loading;
  }

  List<int> itemCounts = List.generate(100, (index) => 0);

  // new Data
  RxBool isCategoryLoading = RxBool(false);

  void categoryLoading(bool l) {
    isCategoryLoading.value = l;
  }

  RxBool isFoodLoading = RxBool(false);

  void foodLoading(bool l) {
    isFoodLoading.value = l;
  }

  RxList<FoodCategoryModelValues> foodCategoryList =
      <FoodCategoryModelValues>[].obs;

  void foodCategory(List<FoodCategoryModelValues> foodCategory) {
    if (foodCategoryList.isNotEmpty) {
      foodCategoryList.clear();
    }
    for (int i = 0; i < foodCategory.length; i++) {
      foodCategoryList.add(foodCategory.elementAt(i));
    }
  }

  RxList<CounterWiseFoodModelValues> foodList = <CounterWiseFoodModelValues>[].obs;
  RxList<CounterWiseFoodModelValues> vegFoodList = <CounterWiseFoodModelValues>[].obs;
  RxList<CounterWiseFoodModelValues> nonVegFoodList = <CounterWiseFoodModelValues>[].obs;

  void foodData(List<CounterWiseFoodModelValues> food) {
    if (foodList.isNotEmpty) {
      foodList.clear();
    }
    if (nonVegFoodList.isNotEmpty) {
      nonVegFoodList.clear();
    }
    if (vegFoodList.isNotEmpty) {
      vegFoodList.clear();
    }
    for (var i in food) {
      if (item == 'VEG' && i.cmmfIFoodItemFlag == false) {
        vegFoodList.add(CounterWiseFoodModelValues(
          cmmfIId: i.cmmfIId,
          // mIId: i.mIId,
          // amsTId: i.amsTId,
          // asmaYId: i.asmaYId,
          // userId: i.userId,
          // icaIId: i.icaIId,
          cmmfIFoodItemName: i.cmmfIFoodItemName,
          cmmfIFoodItemDescription: i.cmmfIFoodItemDescription,
          cmmcACategoryName: i.cmmcACategoryName,
          cmmfIUnitRate: i.cmmfIUnitRate,
          cmmfIOutofStockFlg: i.cmmfIOutofStockFlg,
          cmmfIPathURL: i.cmmfIPathURL,
          cmmcAId: i.cmmcAId,
          cmmfIActiveFlg: i.cmmfIActiveFlg,
          cmmfIFoodItemFlag: i.cmmfIFoodItemFlag,
          // icaIAttachment: i.icaIAttachment,
        ));
      } else if (item == 'NON-VEG' && i.cmmfIFoodItemFlag == true) {
        nonVegFoodList.add(CounterWiseFoodModelValues(
          cmmfIId: i.cmmfIId,
          // mIId: i.mIId,
          // amsTId: i.amsTId,
          // asmaYId: i.asmaYId,
          // userId: i.userId,
          // icaIId: i.icaIId,
          cmmfIFoodItemName: i.cmmfIFoodItemName,
          cmmfIFoodItemDescription: i.cmmfIFoodItemDescription,
          cmmcACategoryName: i.cmmcACategoryName,
          cmmfIUnitRate: i.cmmfIUnitRate,
          cmmfIOutofStockFlg: i.cmmfIOutofStockFlg,
          cmmfIPathURL: i.cmmfIPathURL,
          cmmcAId: i.cmmcAId,
          cmmfIActiveFlg: i.cmmfIActiveFlg,
          cmmfIFoodItemFlag: i.cmmfIFoodItemFlag,
          // icaIAttachment: i.icaIAttachment,
        ));
      } else {
        foodList.add(CounterWiseFoodModelValues(
          cmmfIId: i.cmmfIId,
          // mIId: i.mIId,
          // amsTId: i.amsTId,
          // asmaYId: i.asmaYId,
          // userId: i.userId,
          // icaIId: i.icaIId,
          cmmfIFoodItemName: i.cmmfIFoodItemName,
          cmmfIFoodItemDescription: i.cmmfIFoodItemDescription,
          cmmcACategoryName: i.cmmcACategoryName,
          cmmfIUnitRate: i.cmmfIUnitRate,
          cmmfIOutofStockFlg: i.cmmfIOutofStockFlg,
          cmmfIPathURL: i.cmmfIPathURL,
          cmmcAId: i.cmmcAId,
          cmmfIActiveFlg: i.cmmfIActiveFlg,
          cmmfIFoodItemFlag: i.cmmfIFoodItemFlag,
          // icaIAttachment: i.icaIAttachment,
        ));
      }
    }
  }

  RxList<StudentWalletModelValues> studentWalletData =
      <StudentWalletModelValues>[].obs;

  RxList<CounterWiseFoodModelValues> addToCartList = <CounterWiseFoodModelValues>[].obs;
  RxList<FoodImageListModelValues> foodImageList =
      <FoodImageListModelValues>[].obs;

// PIN section
  RxBool isPinGenerate = RxBool(false);

  void generatePin(bool l) {
    isPinGenerate.value = l;
  }

  RxBool isPinUpdate = RxBool(false);

  void updatePin(bool i) {
    isPinUpdate.value = i;
  }

  List<GeneratePinModelValues> pinlist = <GeneratePinModelValues>[];
  String email = '';
  List<Map<String, dynamic>> itemDetails = [];
  String paymentMode = '0';
  String paymentName = '';

  // History
  RxBool isHistory = RxBool(false);

  void historyLoading(bool l) {
    isHistory.value = l;
  }

  RxList<TransationHistoryModelValues> transationHistory =
      <TransationHistoryModelValues>[].obs;
  RxList<TransationBillModelValues> billModel =
      <TransationBillModelValues>[].obs;
  double quantity = 0;

  RxList<CardReaderModelValues> cardReaderList = <CardReaderModelValues>[].obs;
  int transactionId = 0;
  RxList<CounterListModelValues> counterList = <CounterListModelValues>[].obs;
  RxList<CanteenInsListValues> institutionList = <CanteenInsListValues>[].obs;
}
