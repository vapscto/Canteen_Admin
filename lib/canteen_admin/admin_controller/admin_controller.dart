import 'package:canteen_management/canteen_admin/model/dash_bord_model.dart';
import 'package:canteen_management/canteen_admin/model/day_wise_graph_model.dart';
import 'package:canteen_management/canteen_admin/model/quick_search_model.dart';
import 'package:canteen_management/canteen_admin/model/report_list_model.dart';
import 'package:canteen_management/canteen_admin/model/year_graph_model.dart';
import 'package:canteen_management/canteen_management/model/transation_his_model.dart';
import 'package:get/get.dart';

import '../model/item_model.dart';

class AdminController extends GetxController{
  RxBool isHistoryLoading = RxBool(false);
  void history(bool b){
    isHistoryLoading.value = b;
  }
  RxList<TransationHistoryModelValues> transationHistory =
      <TransationHistoryModelValues>[].obs;
  RxList<ItemModel> itemListData = <ItemModel>[].obs;
  RxList<DashBordModelValues> dashBoardList = <DashBordModelValues>[].obs;

  void getData(List<DashBordModelValues> dashBoard){
    if(dashBoardList.isNotEmpty){
      dashBoardList.clear();
    }
    for(int i=0; i<dashBoard.length; i++){
      dashBoardList.add(dashBoard[i]);
    }

  }
  RxBool isAdminLoading = RxBool(false);
  void loading(bool l){
    isAdminLoading.value = l;
  }
  RxBool isReport = RxBool(false);
  void report(bool b){
    isReport.value = b;
  }
  RxBool isItemLoading = RxBool(false);
  void loadingItem(bool l){
    isItemLoading.value = l;
  }
  RxBool isDayGraph = RxBool(false);
  dayGraph(bool b){
    isDayGraph.value = b;
  }
  //graph
  RxList<DayWiseGraphModelValues> dayWiseGraphList = <DayWiseGraphModelValues>[].obs;
  RxList<YearWiseGraphModelValues> yearWiseGraphList = <YearWiseGraphModelValues>[].obs;
  //Report
  RxList<ReportListModelValues> reportList = <ReportListModelValues>[].obs;
  RxList<ReportListModelValues> lastReportList = <ReportListModelValues>[].obs;
  // Print Bill
  List<QuickSearchModelValues> quickSearchList = [];
}