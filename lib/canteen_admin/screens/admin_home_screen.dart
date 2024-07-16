import 'dart:async';

import 'package:canteen_management/canteen_admin/add_details/add_category_screen.dart';
import 'package:canteen_management/canteen_admin/add_details/add_food_item.dart';
import 'package:canteen_management/canteen_admin/admin_api/admin_api.dart';
import 'package:canteen_management/canteen_admin/admin_controller/admin_controller.dart';
import 'package:canteen_management/canteen_admin/screens/all_booking_history.dart';
import 'package:canteen_management/canteen_admin/screens/quick_search.dart';
import 'package:canteen_management/canteen_admin/screens/report_screen.dart';
import 'package:canteen_management/canteen_admin/screens/select_theme.dart';
import 'package:canteen_management/canteen_admin/screens/wide_bill_screen.dart';
import 'package:canteen_management/canteen_admin/widgets/log_out_widget.dart';
import 'package:canteen_management/canteen_admin/widgets/ring_chart_widget.dart';
import 'package:canteen_management/canteen_management/api/item_list_api.dart';
import 'package:canteen_management/canteen_management/constants/canteen_constants.dart';
import 'package:canteen_management/canteen_management/controller/canteen_controller.dart';
import 'package:canteen_management/controller/global_utility.dart';
import 'package:canteen_management/controller/mskool_controller.dart';
import 'package:canteen_management/forgotpassword/screens/forgot_password_screen.dart';
import 'package:canteen_management/forgotpassword/screens/reset_password.dart';
import 'package:canteen_management/main.dart';
import 'package:canteen_management/model/login_success_model.dart';
import 'package:canteen_management/widgets/animated_progress.dart';
import 'package:canteen_management/widgets/fade_in.dart';
import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'card_widget.dart';

class CanteenAdminHome extends StatefulWidget {
  final MskoolController mskoolController;
  final int miId;
  final LoginSuccessModel loginSuccessModel;

  const CanteenAdminHome(
      {super.key,
      required this.mskoolController,
      required this.miId,
      required this.loginSuccessModel});

  @override
  State<CanteenAdminHome> createState() => _CanteenAdminHomeState();
}

int bgColor = 0;
final cron = Cron();

class _CanteenAdminHomeState extends State<CanteenAdminHome> {
  AdminController controller = Get.put(AdminController());
  CanteenManagementController controller1 =
      Get.put(CanteenManagementController());
  List<Map<String, dynamic>> dashboardListData = [];
  int totalQuantity = 0;
  double totalAmount = 0;
  int todayTotalQty = 0;
  double todayTotalAmount = 0;

  _onLoad() async {
    controller.loading(true);
    await  CanteeenCategoryAPI.instance.getCanteenItems(
      canteenManagementController: controller1,
      base: baseUrlFromInsCode('canteen', widget.mskoolController),
      miId: widget.miId,
      categoryId: 0,
      counterId: counterId,
    );
    await AdminAPI.i.dasBoardAPI(
        base: baseUrlFromInsCode("canteen", widget.mskoolController),
        miId: widget.miId,
        controller: controller);
    totalQuantity = (controller.dashBoardList.isNotEmpty)
        ? controller.dashBoardList.first.totalQtySold ?? 0
        : 0;
    totalAmount = (controller.dashBoardList.isNotEmpty)
        ? controller.dashBoardList.first.totalAmount ?? 0
        : 0;
    todayTotalQty = (controller.dashBoardList.isNotEmpty)
        ? controller.dashBoardList.first.todayTotalQtySold ?? 0
        : 0;
    todayTotalAmount = (controller.dashBoardList.isNotEmpty)
        ? controller.dashBoardList.first.todayTotalAmount ?? 0
        : 0;
    controller.loading(false);
  }

  Timer? _timer;
  getData() async {
    _timer =  Timer.periodic(const Duration(seconds: 1), (Timer timer) async {
     try{
       await  CanteeenCategoryAPI.instance.getCanteenItems(
         canteenManagementController: controller1,
         base: baseUrlFromInsCode('canteen', widget.mskoolController),
         miId: widget.miId,
         categoryId: 0,
         counterId: counterId,
       );
       await AdminAPI.i.dasBoardAPI(
           base: baseUrlFromInsCode("canteen", widget.mskoolController),
           miId: widget.miId,
           controller: controller);

       totalQuantity = (controller.dashBoardList.isEmpty)
           ? 0
           : controller.dashBoardList.first.totalQtySold ?? 0;
       totalAmount = (controller.dashBoardList.isEmpty)
           ? 0
           : controller.dashBoardList.first.totalAmount ?? 0;
       todayTotalQty = (controller.dashBoardList.isEmpty)
           ? 0
           : controller.dashBoardList.first.todayTotalQtySold ?? 0;
       todayTotalAmount = (controller.dashBoardList.isEmpty)
           ? 0
           : controller.dashBoardList.first.todayTotalAmount ?? 0;

       AdminAPI.i.dayWiseGraph(
           base: baseUrlFromInsCode("canteen", widget.mskoolController),
           miId: widget.miId,
           controller: controller);
       chartData.clear();
       for (var i in controller.dayWiseGraphList) {
         chartData
             .add(DateWiseData(DateTime.parse(i.date!).day, i.totalAmount ?? 0));
       }
       AdminAPI.i.monthWiseGraph(
           base: baseUrlFromInsCode("canteen", widget.mskoolController),
           miId: widget.miId,
           controller: controller);
       controller.dayGraph(false);
       data.clear();
       for (var i in controller.yearWiseGraphList) {
         data.add(MonthWiseData(i.month!, i.totalAmount ?? 0));
       }
       setState(() {});
     }catch(e){
       logger.e(e);
     }

    });
  }

  _dayWiseGraph() async {
    controller.dayGraph(true);
    await AdminAPI.i.dayWiseGraph(
        base: baseUrlFromInsCode("canteen", widget.mskoolController),
        miId: widget.miId,
        controller: controller);
    chartData.clear();
    for (var i in controller.dayWiseGraphList) {
      chartData
          .add(DateWiseData(DateTime.parse(i.date!).day, i.totalAmount ?? 0));
    }
  }

  _monthGraph() async {
    await AdminAPI.i.monthWiseGraph(
        base: baseUrlFromInsCode("canteen", widget.mskoolController),
        miId: widget.miId,
        controller: controller);
    controller.dayGraph(false);
    data.clear();
    for (var i in controller.yearWiseGraphList) {
      data.add(MonthWiseData(i.month!, i.totalAmount ?? 0));
    }
  }

  @override
  void initState() {
    getData();
    _onLoad();
    _dayWiseGraph();
    _monthGraph();

    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffold = GlobalKey();

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffold,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              _scaffold.currentState!.openDrawer();
            },
            icon: SvgPicture.asset('assets/svg/menu.svg'),
          ),
          elevation: 0,
          title: Text(
            "Canteen Management",
            style: Get.textTheme.titleMedium!.copyWith(color: Colors.white),
          ),
        ),
        drawer: Drawer(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          elevation: 5,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  // height: 200,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.only(bottomRight: Radius.circular(40)),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      (widget.loginSuccessModel.mILogo != null)
                          ? CircleAvatar(
                              radius: 100,
                              backgroundColor: Colors.purple.shade100,
                              child:
                                  Image.network(widget.loginSuccessModel.mILogo!),
                            )
                          : const SizedBox(),
                      Text(
                        widget.loginSuccessModel.userName ?? "N/A",
                        style: Get.textTheme.titleMedium!
                            .copyWith(color: Colors.white),
                      )
                    ],
                  ),
                ),
                ...List.generate(drawerList.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      onTap: () {
                        if (index == 0) {
                          Get.back();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AllBookingHistory(
                                        controller: controller,
                                        mskoolController: widget.mskoolController,
                                        miId: widget.miId,
                                      )));
                        } else if (index == 1) {
                          Get.back();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WideBillScreen(
                                        mskoolController: widget.mskoolController,
                                        miId: widget.miId,
                                      )));
                        } else if (index == 2) {
                          Get.back();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ReportScreen(
                                        mskoolController: widget.mskoolController,
                                        miId: widget.miId,
                                        controller: controller,
                                      )));
                        } else if (index == 3) {
                          Get.back();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => QuickSearchScreen(
                                        mskoolController: widget.mskoolController,
                                        miId: widget.miId,
                                        controller: controller,
                                      )));
                        } else if (index == 4) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddCategoryScreen(
                                        mskoolController: widget.mskoolController,
                                        miId: widget.miId,
                                        controller: controller1,
                                      )));
                        } else if (index == 5) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddFoodItemScreen(
                                        mskoolController: widget.mskoolController,
                                        miId: widget.miId,
                                      )));
                        }
                        // else if (index == 6) {
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (_) => InstitutionMappingScreen(
                        //                 mskoolController: widget.mskoolController,
                        //                 loginSuccessModel:
                        //                     widget.loginSuccessModel,
                        //                 controller: controller1,
                        //                 miId: widget.miId,
                        //               )));
                        // }
                      },
                      leading: Image.asset(
                        drawerList[index]['image'],
                        height: 40,
                        width: 40,
                      ),
                      title: Text(
                        drawerList[index]['name'],
                        style: Get.textTheme.titleSmall!.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  );
                }),
                ListTile(
                  title: Text(
                    "Change Password",
                    style: Get.textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                  leading: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: const CircleAvatar(
                      // radius: 18,
                      backgroundImage: AssetImage(
                        "assets/images/ChangePassword.png",
                      ),
                      backgroundColor: Colors.white,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Get.to(() => ResetPassword(
                          mskoolController: widget.mskoolController,
                          loginSuccessModel: widget.loginSuccessModel,
                        ));
                  },
                ),
                ListTile(
                  title: Text(
                    "Forgot Password",
                    style: Get.textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                  leading: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: const CircleAvatar(
                      // radius: 18,
                      backgroundImage: AssetImage(
                        "assets/images/ForgotPassword.png",
                      ),
                      backgroundColor: Colors.white,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Get.to(() => ForgotPasswordScreen(
                          mskoolController: widget.mskoolController,
                          forExpire: false,
                        ));
                  },
                ),
                ListTile(
                  title: Text(
                    "Select Theme",
                    style: Get.textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                  leading: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: const CircleAvatar(
                      // radius: 18,
                      backgroundImage: AssetImage(
                        "assets/images/theme.png",
                      ),
                      backgroundColor: Colors.white,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Get.to(() => const ThemeSwitcher());
                  },
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: InkWell(
                    onTap: () {
                      Get.back();
                      Get.dialog(const LogoutConfirmationPopup());
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.07,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(1, 2.1),
                              spreadRadius: 0,
                              blurRadius: 0,
                              color: Colors.black12,
                            )
                          ]),
                      padding: const EdgeInsets.all(8),
                      child: Center(
                        child: Text(
                          "Log Out",
                          style: Get.textTheme.titleMedium!
                              .copyWith(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Obx(() {
          return (controller.isAdminLoading.value)
              ? const Center(
                  child: AnimatedProgressWidget(
                      title: "Loading",
                      desc: "",
                      animationPath: "assets/json/default.json"),
                )
              : LayoutBuilder(builder: (context, BoxConstraints contains) {
                  return ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      Text(
                        "Dashboard",
                        style: Get.textTheme.titleLarge!
                            .copyWith(color: Theme.of(context).primaryColor),
                      ),
                      const SizedBox(height: 20),

                      Center(
                        child: GridView.builder(
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: dashboardData.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: _calculateCrossAxisCount(
                                        contains.maxWidth),
                                    mainAxisSpacing: 20,
                                    crossAxisSpacing: 20,
                                    childAspectRatio: 2),
                            itemBuilder: (context, index) {
                              bgColor += 1;
                              if (bgColor % 4 == 0) {
                                bgColor = 0;
                              }
                              return FadeInAnimation(delay: 2.0+index,
                                direction: FadeInDirection.ltr,
                                fadeOffset: index == 0 ? 100 : 100.0 + index,
                                child: InkWell(
                                  onTap: () {},
                                  child: CardWidget(
                                    color: dashBoardColor[bgColor],
                                    title: dashboardData[index]['name'],
                                    value: (index == 0)
                                        ? totalQuantity.toString()
                                        : (index == 1)
                                        ? totalAmount.toString()
                                        : (index == 2)
                                        ? todayTotalQty.toString()
                                        : todayTotalAmount.toString(),
                                    icon: (index == 0)
                                        ? const Icon(
                                      Icons.shopping_bag_outlined,
                                      size: 50,
                                      color: Colors.white,
                                    )
                                        : (index == 1)
                                        ? const Icon(
                                      Icons.currency_rupee,
                                      size: 50,
                                      color: Colors.white,
                                    )
                                        : (index == 2)
                                        ? const Icon(
                                      Icons.shopping_cart_outlined,
                                      size: 50,
                                      color: Colors.white,
                                    )
                                        : const Icon(
                                      Icons.currency_rupee,
                                      size: 50,
                                      color: Colors.white,
                                    ),
                                    style: Get.textTheme.titleSmall!.copyWith(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ),);


                            }),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            // height: MediaQuery.of(context).size.height * 0.2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        topLeft: Radius.circular(10)),
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Total Veg and Non-Veg Count",
                                      textAlign: TextAlign.center,
                                      style: Get.textTheme.titleMedium!
                                          .copyWith(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      RingChartWidget(
                                        vegCount:
                                            (controller.dashBoardList.isEmpty)
                                                ? 0
                                                : double.parse(controller
                                                    .dashBoardList
                                                    .last
                                                    .vegTotalQtySold
                                                    .toString()),
                                        nonVegCount:
                                            (controller.dashBoardList.isEmpty)
                                                ? 0
                                                : double.parse(controller
                                                    .dashBoardList
                                                    .last
                                                    .nonVegTotalQtySold
                                                    .toString()),
                                        title1: "VEG",
                                        title2: "NON-VEG",
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Total Veg Count:-',
                                                  style: Get
                                                      .textTheme.titleMedium!
                                                      .copyWith(
                                                          color: Colors.green),
                                                ),
                                                TextSpan(
                                                    text: (controller
                                                            .dashBoardList
                                                            .isEmpty)
                                                        ? ""
                                                        : '${controller.dashBoardList.last.vegTotalQtySold}',
                                                    style: Get
                                                        .textTheme.titleMedium!
                                                        .copyWith(
                                                            color:
                                                                Colors.green)),
                                              ],
                                            ),
                                          ),
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text:
                                                      'Total Non-Veg Count:- ',
                                                  style: Get
                                                      .textTheme.titleMedium!
                                                      .copyWith(
                                                          color: Colors.red),
                                                ),
                                                TextSpan(
                                                    text: (controller
                                                            .dashBoardList
                                                            .isEmpty)
                                                        ? ""
                                                        : ' ${controller.dashBoardList.last.nonVegTotalQtySold}',
                                                    style: Get
                                                        .textTheme.titleMedium!
                                                        .copyWith(
                                                            color: Colors.red)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            // height: MediaQuery.of(context).size.height * 0.2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        topLeft: Radius.circular(10)),
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Current Month Orders and Amount",
                                      textAlign: TextAlign.center,
                                      style: Get.textTheme.titleMedium!
                                          .copyWith(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      RingChartWidget(
                                        vegCount:
                                            (controller.dashBoardList.isEmpty)
                                                ? 0
                                                : double.parse(controller
                                                    .dashBoardList
                                                    .last
                                                    .monthTotalQtySold
                                                    .toString()),
                                        nonVegCount:
                                            (controller.dashBoardList.isEmpty)
                                                ? 0
                                                : double.parse(controller
                                                    .dashBoardList
                                                    .last
                                                    .monthTotalAmount
                                                    .toString()),
                                        title1: "Total Order",
                                        title2: "Total Amount",
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            DateFormat.MMMM().format(dt),
                                            style: Get.textTheme.titleSmall,
                                          ),
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Total Order:- ',
                                                  style: Get
                                                      .textTheme.titleMedium!
                                                      .copyWith(
                                                    color: Colors.green,
                                                  ),
                                                ),
                                                TextSpan(
                                                    text: (controller
                                                            .dashBoardList
                                                            .isEmpty)
                                                        ? ''
                                                        : ' ${controller.dashBoardList.last.monthTotalQtySold}',
                                                    style: Get
                                                        .textTheme.titleMedium!
                                                        .copyWith(
                                                            color:
                                                                Colors.green)),
                                              ],
                                            ),
                                          ),
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Total Amount:- ',
                                                  style: Get
                                                      .textTheme.titleMedium!
                                                      .copyWith(
                                                          color: Colors.red),
                                                ),
                                                TextSpan(
                                                    text: (controller
                                                            .dashBoardList
                                                            .isEmpty)
                                                        ? ''
                                                        : ' ₹ ${controller.dashBoardList.last.monthTotalAmount}',
                                                    style: Get
                                                        .textTheme.titleMedium!
                                                        .copyWith(
                                                            color: Colors.red)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              (data.isEmpty)
                                  ? const SizedBox()
                                  : SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.48,
                                      child: SfCartesianChart(
                                        title: ChartTitle(
                                            text: "Year Wise Details",
                                            textStyle: Get.textTheme.titleSmall!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w600)),
                                        margin: EdgeInsets.zero,
                                        palette: const [
                                          Color(0xFF1070F9),
                                          Color(0xffF90737),
                                        ],
                                        primaryXAxis: CategoryAxis(),
                                        legend: const Legend(isVisible: true),
                                        tooltipBehavior:
                                            TooltipBehavior(enable: true),
                                        series: <ColumnSeries>[
                                          ColumnSeries<MonthWiseData, String>(
                                              name: "Current Year",
                                              enableTooltip: true,
                                              dataSource: data,
                                              xValueMapper:
                                                  (MonthWiseData month, _) =>
                                                      month.month,
                                              yValueMapper:
                                                  (MonthWiseData month, _) =>
                                                      month.value,
                                              isVisibleInLegend: true,
                                              legendIconType:
                                                  LegendIconType.circle,
                                              legendItemText: 'Current Year',
                                              dataLabelSettings:
                                                  const DataLabelSettings(
                                                      // color: Colors.transparent,
                                                      isVisible: false,
                                                      labelPosition:
                                                          ChartDataLabelPosition
                                                              .inside,
                                                      textStyle: TextStyle(
                                                          fontSize: 14))),
                                          ColumnSeries<MonthWiseData, String>(
                                            name: 'Last Year',
                                            dataSource: getMonthWiseData(
                                                DateTime.now().year - 1),
                                            xValueMapper:
                                                (MonthWiseData sales, _) =>
                                                    sales.month,
                                            yValueMapper:
                                                (MonthWiseData sales, _) =>
                                                    sales.value,
                                            isVisibleInLegend: true,
                                            legendIconType:
                                                LegendIconType.circle,
                                            legendItemText: 'Last Year',
                                          ),
                                        ],
                                      ),
                                    ),
                              (chartData.isEmpty)
                                  ? const SizedBox()
                                  : SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.49,
                                        child: SfCartesianChart(
                                          title: ChartTitle(
                                              text:
                                                  "${DateFormat('MMMM').format(DateTime.now())} Month Details",
                                              textStyle: Get
                                                  .textTheme.titleSmall!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600)),
                                          margin: EdgeInsets.zero,
                                          palette: const [
                                            Color(0xff1070F9),
                                          ],
                                          primaryXAxis: CategoryAxis(),
                                          // DateTimeCategoryAxis(
                                          //     dateFormat: DateFormat.yMMMd()),
                                          tooltipBehavior:
                                              TooltipBehavior(enable: true),
                                          series: <CartesianSeries<DateWiseData,
                                              dynamic>>[
                                            SplineSeries<DateWiseData, dynamic>(
                                                name: 'Month',
                                                isVisibleInLegend: true,
                                                markerSettings:
                                                    const MarkerSettings(
                                                        isVisible: true),
                                                dataLabelSettings:
                                                    const DataLabelSettings(
                                                  isVisible: true,
                                                  textStyle:
                                                      TextStyle(fontSize: 14),
                                                ),
                                                dataSource: chartData,
                                                xValueMapper:
                                                    (DateWiseData data, _) =>
                                                        data.date,
                                                yValueMapper:
                                                    (DateWiseData data, _) =>
                                                        data.value)
                                          ],
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                });
        }));
  }

  int _calculateCrossAxisCount(double width) {
    return (width / 325).floor();
  }

  DateTime dt = DateTime.now();

  //
  List<MonthWiseData> data = [];

  List<MonthWiseData> getMonthWiseData(int year) {
    List<MonthWiseData> data1 = [];
    for (var i in controller.yearWiseGraphList) {
      if (year == i.year) {
        data1.add(MonthWiseData(i.month!, i.totalAmount ?? 0));
      }
    }
    return data1;
  }

  final List<DateWiseData> chartData = [];
}

class MonthWiseData {
  String month;
  double value;

  MonthWiseData(this.month, this.value);
}

class DateWiseData {
  int date;
  double value;

  DateWiseData(this.date, this.value);
}
