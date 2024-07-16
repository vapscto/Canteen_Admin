import 'package:canteen_management/controller/mskool_controller.dart';
import 'package:canteen_management/main.dart';
import 'package:canteen_management/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogoutConfirmationPopup extends StatefulWidget {
  const LogoutConfirmationPopup({
    Key? key,
  }) : super(key: key);

  @override
  State<LogoutConfirmationPopup> createState() =>
      _LogoutConfirmationPopupState();
}

class _LogoutConfirmationPopupState extends State<LogoutConfirmationPopup>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> scaleAnimation;
  final MskoolController mskoolController = Get.find<MskoolController>();

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 450), vsync: this);
    scaleAnimation = CurvedAnimation(
        parent: animationController, curve: Curves.elasticInOut);
    animationController.addListener(() {
      // setState(() {});
    });
    animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scaleAnimation,
      child: AlertDialog(
        title: Text("Logout".tr,
            style:
                Theme.of(context).textTheme.titleSmall!.merge(const TextStyle(
                      fontWeight: FontWeight.w600,
                    ))),
        content: Text("Are you sure, you want to logout?".tr,
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .merge(const TextStyle(letterSpacing: 0.2))),
        actions: [
          TextButton(
            onPressed: () async {
              Get.back();
              logInBox!.put("isLoggedIn", false);
              logInBox!.clear();
              institutionalCode!.put("institutionalCode", null);
              institutionalCode!.clear();
              Get.offAll(
                () => const SplashScreen(),
              );
            },
            child: Text(
              "Yes".tr,
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              "No".tr,
            ),
          ),
        ],
      ),
    );
  }
}
