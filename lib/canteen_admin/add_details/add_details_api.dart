import 'package:canteen_management/canteen_admin/add_details/model/added_category_model.dart';
import 'package:canteen_management/canteen_management/model/food_list_model.dart';
import 'package:canteen_management/constants/api_url.dart';
import 'package:canteen_management/controller/global_utility.dart';
import 'package:canteen_management/main.dart';
import 'package:dio/dio.dart';

import 'add_details_controller.dart';

class AddDetailsAPI {
  AddDetailsAPI.init();

  static final AddDetailsAPI instance = AddDetailsAPI.init();
  var dio = Dio();

  Future<String?> saveCategory(
      {required String base, required Map<String, dynamic> body}) async {
    var api = base + URLS.addCategory;
    logger.i(api);
    logger.w(body);
    try {
      var response = await dio.post(api,
          options: Options(headers: getSession()), data: body);
      return response.data['returnval'];
    } on DioException catch (e) {
      logger.e(e);
    }
    return null;
  }

  categoryList(
      {required String base,
      required int counterId,
      required AddDetailsController controller}) async {
    var api = base + URLS.addedCategoryList;
    logger.w(api);
    try {
      var response = await dio.post(api,
          data: {"CMMCO_Id": counterId}, options: Options(headers: getSession()));
      logger.w({"CMMCO_Id": counterId});
      if (response.statusCode == 200) {
        if (response.data['foodcategeory'] != null) {
          AddedCategoryModel addedCategoryModel =
              AddedCategoryModel.fromJson(response.data['foodcategeory']);
          controller.addedCategoryList.clear();
          controller.addedCategoryList.addAll(addedCategoryModel.values!);
        }if(response.data['foodcategeoryactive'] != null){
          AddedCategoryModel addedCategoryModel =
          AddedCategoryModel.fromJson(response.data['foodcategeoryactive']);
          controller.activeCategoryList.clear();
          controller.activeCategoryList.addAll(addedCategoryModel.values!);
        }
      }
    } catch (e) {
      logger.e(e);
    }
  }

  Future<String?> activeAPI(
      {required String base, required Map<String, dynamic> body}) async {
    var api = base + URLS.deActiveAPII;
    logger.i(api);
    logger.e(body);
    try {
      var response = await dio.post(api,
          data: body, options: Options(headers: getSession()));
      return response.data['returnval'];
    } catch (e) {
      logger.e(e);
    }
    return null;
  }

// Canteen
  Future<String?> saveCanteen(
      {required String base, required Map<String, dynamic> body}) async {
    var api = base + URLS.addCanteen;
    logger.i(api);
    logger.w(body);
    try {
      var response = await dio.post(api,
          options: Options(headers: getSession()), data: body);
      return response.data['returnval'];
    } on DioException catch (e) {
      logger.e(e);
    }
    return null;
  }

  Future<String?> canteenActiveAPI(
      {required String base, required Map<String, dynamic> body}) async {
    var api = base + URLS.activateCounter;
    logger.i(api);
    logger.e(body);
    try {
      var response = await dio.post(api,
          data: body, options: Options(headers: getSession()));
      return response.data['returnval'];
    } catch (e) {
      logger.e(e);
    }
    return null;
  }

//Food
  Future<String?> saveFood(
      {required String base, required Map<String, dynamic> body}) async {
    var api = base + URLS.addFood;
    logger.i(api);
    logger.w(body);
    try {
      var response = await dio.post(api,
          options: Options(headers: getSession()), data: body);
      return response.data['returnval'];
    } on DioException catch (e) {
      logger.e(e);
    }
    return null;
  }

  getFoodList(
      {required String base,
      required int miId,
      required AddDetailsController controller}) async {
    var api = base + URLS.loadFoodList;
    logger.i(api);
    try {
      var res = await dio.post(api,
          data: {"CMMCO_Id": counterId}, options: Options(headers: getSession()));
      if (res.statusCode == 200) {
        if (res.data['fooditeamDeatils'] != null) {
          FoodListModel foodListModel =
              FoodListModel.fromJson(res.data['fooditeamDeatils']);
          controller.foodList.clear();
          controller.foodList.addAll(foodListModel.values!);
        }
        // if (res.data['counterlist'] != null) {
        //   CounterListModel counterListModel =
        //       CounterListModel.fromJson(res.data['counterlist']);
        //   controller.counterListData.clear();
        //   controller.counterListData.addAll(counterListModel.values!);
        // }
        // if (res.data['institutedeails'] != null) {
        //   CanteenInsList canteenInsList =
        //       CanteenInsList.fromJson(res.data['institutedeails']);
        //   controller.instituteList.clear();
        //   controller.instituteList.addAll(canteenInsList.values!);
        // }
      }
    } catch (e) {
      logger.e(e);
    }
  }

  Future<String?> activeFood(
      {required String base,
      required Map<String, dynamic> body,
      required AddDetailsController controller}) async {
    var api = base + URLS.activeFood;
    logger.i(api);
    logger.w(body);
    try {
      var response = await dio.post(api,
          data: body, options: Options(headers: getSession()));
      controller.flag = response.data['cmmfI_ActiveFlg'];
      return response.data['returnval'];
    } catch (e) {
      logger.e(e);
    }
    return null;
  }
}
