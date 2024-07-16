import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';

class CustomThemeData {
  ThemeData? getThemeData(isLightMode, int v) {
    // int value = themeBox!.get("colorTheme");
    int value = 0;
    if (themeBox!.get("colorTheme") == null) {
      themeBox!.put("colorTheme", 0);
    } else {
      value = themeBox!.get("colorTheme");
    }
    return isLightMode
        ? ThemeData(
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFF1E38FC),
        onPrimary: Colors.white,
        secondary: Color(0xFFDFEFFD),
        onSecondary: Colors.white,
        error: Colors.red,
        onError: Colors.white,
        surface: Colors.white,
        onSurface: Color(0xff525252),

      ),
      primaryColor: value == 0
          ? const Color(0xFF1E38FC)
          : value == 1
          ? const Color(0xFFFF385C)
          : value == 2
          ? const Color(0xFF604A7B)
          : const Color(0xFFFFA500),

      textTheme: TextTheme(
        titleSmall: GoogleFonts.openSans(
          fontSize: 15,
          color: Colors.black,
          textStyle: const TextStyle(
            overflow: TextOverflow.visible,
          ),
        ),
        titleMedium: GoogleFonts.openSans(
          fontSize: 17,
          color: const Color(0xFF1A1A1A),
          fontWeight: FontWeight.w700,
        ),
        titleLarge: GoogleFonts.openSans(
          fontSize: 22,
          fontWeight: FontWeight.w500,
        ),
        labelSmall: GoogleFonts.openSans(
          fontSize: 13,
          fontWeight: FontWeight.w400,
        ),
        labelMedium: GoogleFonts.openSans(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.grey.shade600,
          textStyle: const TextStyle(
            overflow: TextOverflow.visible,
          ),
        ),
        labelLarge: GoogleFonts.openSans(
          fontSize: 19,
          fontWeight: FontWeight.w400,
          textStyle: const TextStyle(
            overflow: TextOverflow.visible,
          ),
        ),
      ),
      scaffoldBackgroundColor: Colors.white, //const Color(0xff121212),
      appBarTheme: AppBarTheme(
        //color: Colors.white,
        backgroundColor: value == 0
            ? const Color(0xFF1E38FC)
            : value == 1
            ? const Color(0xFFFF385C)
            : value == 2
            ? const Color(0xFF604A7B)
            : const Color(0xFFFFA500),
        centerTitle: false,
        titleTextStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          // color: Colors.black,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        elevation: 1,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                value == 0
                    ? const Color(0xFF1E38FC)
                    : value == 1
                    ? const Color(0xFFFF385C)
                    : value == 2
                    ? const Color(0xFF604A7B)
                    : const Color(0xFFFFA500),
              ))),
      bottomAppBarTheme: const BottomAppBarTheme(
        color: Colors.white,
        elevation: 5,
      ),
      cardTheme: const CardTheme(
        color: Colors.white,
        elevation: 4,
        shadowColor: Colors.white,
      ),
      tabBarTheme: const TabBarTheme(
        unselectedLabelColor: Colors.black54,
      ),
      shadowColor: const Color(0xffBDC8DF).withOpacity(0.7),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all<Color>(
            const Color(
              0xff4EA995,
            ),
          ),
          textStyle: WidgetStateProperty.all<TextStyle>(
            const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      radioTheme: RadioThemeData(
        fillColor:
        WidgetStateProperty.all<Color>(const Color(0xff4EA995)),
      ),
    )
        : ThemeData(
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Colors.black,
        onPrimary: Colors.black,
        secondary: Colors.black,
        onSecondary: Colors.white,
        error: Colors.red,
        onError: Colors.white,
        surface: Colors.white,
        onSurface: Colors.black,
      ),
      textTheme: TextTheme(
        titleSmall: TextStyle(
          fontSize: Get.height * 0.0193,
          color: Colors.green,
        ),
        titleMedium: TextStyle(
          fontSize: Get.height * 0.0201,
          fontWeight: FontWeight.w500,
        ),
        titleLarge: TextStyle(
          fontSize: Get.height * 0.0241,
          fontWeight: FontWeight.w500,
        ),
        labelSmall: TextStyle(
          fontSize: Get.height * 0.0101,
          fontWeight: FontWeight.w500,
          color: Get.theme.primaryColor,
        ),
      ),
      scaffoldBackgroundColor: Colors.black87,
      appBarTheme: const AppBarTheme(
        color: Colors.white,
        elevation: 0,
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        color: Color(
          0xfff4f4f4,
        ),
        elevation: 5,
      ),
      shadowColor: const Color(0xffBDC8DF).withOpacity(0.7),
      cardTheme: CardTheme(
        color: Colors.white,
        elevation: 4,
        shadowColor: const Color(0xffBDC8DF).withOpacity(0.7),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all<Color>(
            const Color(
              0xffFB8402,
            ),
          ),
        ),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.all<Color>(
          const Color(
            0xffFB8402,
          ),
        ),
      ),
    );
  }

  static List<BoxShadow> getShadow() {
    return const [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 4,
        offset: Offset(0, 1),
      ),
    ];
  }

  static void changeStatusBarColor(BuildContext context) {
    int value = 0;
    if (themeBox!.get("colorTheme") == null) {
    } else {
      value = themeBox!.get("colorTheme");
    }
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor:
        MediaQuery.of(context).platformBrightness == Brightness.light
            ? value == 0
            ? const Color(0xFF1E38FC)
            : value == 1
            ? const Color(0xFFFF385C)
            : value == 2
            ? const Color(0xFF604A7B)
            : const Color(0xFFFFA500)
            : Colors.black,
        statusBarIconBrightness:
        MediaQuery.of(context).platformBrightness == Brightness.light
            ? Brightness.dark
            : Brightness.light,
        systemNavigationBarColor:
        MediaQuery.of(context).platformBrightness == Brightness.light
            ? Colors.white
            : Colors.black,
        systemNavigationBarIconBrightness:
        MediaQuery.of(context).platformBrightness == Brightness.light
            ? Brightness.dark
            : Brightness.light,
      ),
    );
  }
}
