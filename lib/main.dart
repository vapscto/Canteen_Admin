import 'dart:io';

import 'package:canteen_management/screens/institution_login.dart';
import 'package:canteen_management/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:window_manager/window_manager.dart';
import 'constants/theme_constants.dart';
import 'controller/theme_controller.dart';

class MyFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return true;
  }
}

Logger logger = Logger(printer: PrettyPrinter(methodCount: 0), filter: MyFilter());
ThemeController themeData = Get.put(ThemeController());
Box? themeBox;
Box? logInBox;
Box? cookieBox;
Box? institutionalCode;
Box? institutionalCookie;
Box? importantIds;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDesktopFeatures();
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  themeBox = await Hive.openBox("themeData");
  logInBox = await Hive.openBox("login");
  Hive.openBox("cookie").then((value) => cookieBox = value);
  Hive.openBox("institutionalCode").then((value) => institutionalCode = value);
  Hive.openBox("insCookie").then((value) => institutionalCookie = value);
  importantIds = await Hive.openBox("commonCodes");
  if (themeBox!.get("isLightMode") != null) {
    themeData.isLightMode.value = themeBox!.get("isLightMode");
  } else {
    await themeBox!.put("isLightMode", themeData.isLightMode.value);
  }
  runApp(const MyApp());
}

Future<void> initializeDesktopFeatures() async {
  await windowManager.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await windowManager.waitUntilReadyToShow();
    // await windowManager.setPosition(const Offset(100, 100));
    await windowManager.show();
    await windowManager.focus();
    await windowManager.isFullScreen();

  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          darkTheme: CustomThemeData().getThemeData(
            themeData.isLightMode.value,
            themeData.theme.value,
          ),
          theme: CustomThemeData().getThemeData(
            themeData.isLightMode.value,
            themeData.theme.value,
          ),
          home: const InstitutionLogin(),
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: const TextScaler.linear(1.0),
              ),
              child: child!,
            );
          },
        ),
      );
    });
  }
}
