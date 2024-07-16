import 'dart:async';
import 'dart:io';
import 'package:canteen_management/controller/mskool_controller.dart';
import 'package:canteen_management/main.dart';
import 'package:canteen_management/model/category_item_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:motion_toast/motion_toast.dart';
Map<String, String> getSession() {
  Map<String, String> header = {
    "Cookie": cookieBox!.get("cookie") ?? "",
  };
  return header;
}
String staffStudentFlag ='';
int counterId = 0;

String baseUrlFromInsCode(String pageName, MskoolController mskoolController) {
  for (int i = 0;
      i < mskoolController.universalInsCodeModel!.value.apiarray.values.length;
      i++) {
    final CategoriesApiItem api = mskoolController
        .universalInsCodeModel!.value.apiarray.values
        .elementAt(i);
    if (api.iivrscurLAPIName.toLowerCase() == pageName) {
      return api.iivrscurLAPIURL;
    }
  }
  return "";
}

List<Color> lighterColor = const [
  Color.fromARGB(255, 255, 202, 202),
  Color.fromARGB(255, 201, 230, 255),
  Color.fromARGB(255, 225, 200, 255),
  Color.fromARGB(255, 212, 250, 255),
  Color.fromARGB(255, 234, 255, 236),
  Color.fromARGB(255, 255, 227, 221),
  Color.fromARGB(255, 254, 209, 255),
];
List<Color> noticeColor = const [
  Color(0xFFF54c4c),
  Color(0xFF015DAF),
  Color(0xFF824CC3),
  Color(0xFFEC16F0),
  Color(0xFF28B6C8),
  Color(0xFFAF6152),
  Color(0xFF3FCF52),
];
List<Color> dashBoardColor = const [
  Color(0xFF020242),
  Color(0xFFF54c4c),
  Color(0xFFEC16F0),
  Color(0xffF90737),
];
String ipAddress = '';

Future printIps() async {
  var interface = await NetworkInterface.list();
  ipAddress = interface.first.addresses.last.address;
  logger.w(ipAddress);
}

String dateFormat(DateTime dt) {
  return '${dt.day}-${months[dt.month - 1]}-${dt.year}';
}

String getMonthName(int monthNumber) {
  DateFormat formatter = DateFormat('MMMM');
  DateTime date = DateTime(DateTime.now().year, monthNumber);
  return formatter.format(date);
}

List months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec'
];

Future<bool> checkConnectivity() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult.contains(ConnectivityResult.wifi)) {
    return true;
  } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
    return true;
  } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
    return true;
  }
  return false;
}
String formatNumber(int number) {
  if (number >= 1000000000) {
    return '${(number / 1000000000).toStringAsFixed(1)}B';
  } else if (number >= 1000000) {
    return '${(number / 1000000).toStringAsFixed(1)}M';
  } else if (number >= 1000) {
    return '${(number / 1000).toStringAsFixed(1)}K';
  } else {
    return number.toStringAsFixed(0);
  }
}
String formatAmount(double number) {
  if (number >= 1000000000) {
    return '${(number / 1000000000).toStringAsFixed(1)}B';
  } else if (number >= 1000000) {
    return '${(number / 1000000).toStringAsFixed(1)}M';
  } else if (number >= 1000) {
    return '${(number / 1000).toStringAsFixed(1)}K';
  } else {
    return number.toStringAsFixed(2);
  }
}
toastMessage(String title, BuildContext context, Color color) {
  return MotionToast(
    description: Text(
      title,
      style: Get.textTheme.titleSmall!
          .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
    ),
    primaryColor: color,
    layoutOrientation: ToastOrientation.rtl,
    animationType: AnimationType.fromTop,
    animationDuration: const Duration(milliseconds: 1500),
    toastDuration: const Duration(seconds: 2),
  ).show(context);
}