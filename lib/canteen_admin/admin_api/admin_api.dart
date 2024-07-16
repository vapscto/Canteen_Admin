import 'package:canteen_management/canteen_admin/admin_controller/admin_controller.dart';
import 'package:canteen_management/canteen_admin/model/dash_bord_model.dart';
import 'package:canteen_management/canteen_admin/model/day_wise_graph_model.dart';
import 'package:canteen_management/canteen_admin/model/quick_search_model.dart';
import 'package:canteen_management/canteen_admin/model/report_list_model.dart';
import 'package:canteen_management/canteen_admin/model/year_graph_model.dart';
import 'package:canteen_management/canteen_management/model/one_time_print_model.dart';
import 'package:canteen_management/canteen_management/model/transation_his_model.dart';
import 'package:canteen_management/constants/api_url.dart';
import 'package:canteen_management/controller/global_utility.dart';
import 'package:canteen_management/main.dart';
import 'package:dio/dio.dart';

class AdminAPI {
  AdminAPI.init();

  static final AdminAPI i = AdminAPI.init();
  var dio = Dio();

  studentTransationData(
      {required AdminController controller,
      required String base,
      required int miId,
      required int acmstId,
      required int counterId}) async {
    var dio = Dio();
    var url = base + URLS.transationHistory;
    try {
      controller.history(true);
      var response = await dio.post(url,
          data: {
            "MI_Id": miId,
            "Flag": '',
            "ACMST_Id": acmstId,
            "CMMCO_Id": counterId
          },
          options: Options(headers: getSession()));
      logger.d(url);
      logger.w({
        "MI_Id": miId,
        "Flag": '',
        "ACMST_Id": acmstId,
        "CMMCO_Id": counterId
      });
      if (response.statusCode == 200) {
        if (response.data['transactiondeatils'] != null) {
          TransationHistoryModel transationHistoryModel =
              TransationHistoryModel.fromJson(
                  response.data['transactiondeatils']);
          controller.transationHistory.clear();
          controller.transationHistory.addAll(transationHistoryModel.values!);
          controller.history(false);
        }
      }
    } on Exception catch (e) {
      logger.e(e.toString());
    }
  }

//Refund Amount
  refundAmount(
      {required AdminController controller,
      required String base,
      required Map<String, dynamic> body}) async {
    var dio = Dio();
    var url = base + URLS.refundAmount;
    logger.w(url);
    logger.i(body);
    try {
      var response = await dio.post(url,
          data: body, options: Options(headers: getSession()));
      logger.w(response);
      logger.d(url);
      logger.e(body);
    } on Exception catch (e) {
      logger.e(e.toString());
    }
  }

  dasBoardAPI(
      {required String base,
      required int miId,
      required AdminController controller}) async {
    var dio = Dio();
    var api = base + URLS.adminDashboard;
    try {
      var response = await dio.post(api,
          data: {"MI_Id": miId}, options: Options(headers: getSession()));
      if (response.statusCode == 200) {
        if (response.data['order_deatils'] != null) {
          DashBordModel dashBordModel =
              DashBordModel.fromJson(response.data['order_deatils']);
          controller.getData(dashBordModel.values!);
        }
      }
    } catch (e) {
      logger.e(e);
    }
  }

  dayWiseGraph({
    required String base,
    required int miId,
    required AdminController controller,
  }) async {
    var api = base + URLS.dayWiseGraph;
    try {
      var response = await dio.post(api,
          data: {"MI_Id": miId}, options: Options(headers: getSession()));
      if (response.statusCode == 200) {
        DayWiseGraphModel dayWiseGraphModel =
            DayWiseGraphModel.fromJson(response.data['month_Daywise_deatils']);
        controller.dayWiseGraphList.clear();
        controller.dayWiseGraphList.addAll(dayWiseGraphModel.values!);
      }
    } catch (e) {
      logger.e(e);
    }
  }

  monthWiseGraph({
    required String base,
    required int miId,
    required AdminController controller,
  }) async {
    var api = base + URLS.monthWiseGraph;
    try {
      var response = await dio.post(api,
          data: {"MI_Id": miId}, options: Options(headers: getSession()));
      if (response.statusCode == 200) {
        YearWiseGraphModel yearWiseGraphModel =
            YearWiseGraphModel.fromJson(response.data['yearWise_deatils']);
        controller.yearWiseGraphList.clear();
        controller.yearWiseGraphList.addAll(yearWiseGraphModel.values!);
      }
    } catch (e) {
      logger.e(e);
    }
  }

// Report API
  reportAPI(
      {required String base,
      required Map<String, dynamic> body,
      required AdminController controller}) async {
    var api = base + URLS.report;
    logger.i(api);
    logger.i(body);
    try {
      var response = await dio.post(api,
          data: body, options: Options(headers: getSession()));
      if (response.statusCode == 200) {
        ReportListModel reportListModel =
            ReportListModel.fromJson(response.data['food_OrderDetails']);
        controller.reportList.clear();
        controller.lastReportList.clear();
        controller.reportList.addAll(reportListModel.values!);
        logger.i(controller.reportList.first.totalAmount);
        controller.lastReportList.add(controller.reportList.last);
        controller.reportList.remove(controller.reportList.last);
      }
    } catch (e) {
      logger.e(e);
    }
  }
}

Future<QuickSearchModel?> quickSearch({
  required String base,
  required int orderId,
  required String flag,
  required AdminController controller,
}) async {
  var dio = Dio();
  var api = base + URLS.quickSearch;
  logger.w({"CM_orderID": orderId, "flag": flag});
  logger.i(api);
  try {
    var response = await dio.post(api,
        data: {"CM_orderID": orderId, "flag": flag},
        options: Options(headers: getSession()));
    QuickSearchModel quickSearchModel =
        QuickSearchModel.fromJson(response.data['payment_deatils_print']);
    controller.quickSearchList.clear();
    controller.quickSearchList.addAll(quickSearchModel.values!);

    return quickSearchModel;
  } catch (e) {
    logger.e(e);
  }
  return null;
}

Future<OneTimePrintModel?> oneTimePrint(
    {required String base, required int orderId}) async {
  var dio = Dio();
  var api = base + URLS.printOnce;
  logger.i(api);
  logger.w({"CM_orderID": orderId});
  try {
    var res = await dio.post(api,
        data: {"CM_orderID": orderId}, options: Options(headers: getSession()));
    OneTimePrintModel oneTimePrintModel =
        OneTimePrintModel.fromJson(res.data['payment_deatils_print']);

    return oneTimePrintModel;
  } on Exception catch (e) {
    logger.e(e.toString());
  }
  return null;
}
