import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../controller/mskool_controller.dart';
import '../../model/login_success_model.dart';
import '../controller/canteen_controller.dart';

class SuccessAnimation extends StatefulWidget {
  final CanteenManagementController controller;
  final MskoolController mskoolController;
  final LoginSuccessModel loginSuccessModel;

  const SuccessAnimation(
      {super.key,
      required this.controller,
      required this.mskoolController,
      required this.loginSuccessModel});

  @override
  State<SuccessAnimation> createState() => _SuccessAnimationState();
}

class _SuccessAnimationState extends State<SuccessAnimation> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      Get.back();
      Get.back();
      Get.back();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset("assets/json/success_animation.json"),
          Text(
            "Transaction Success, please check transaction history",
            style: Get.textTheme.titleSmall!.copyWith(color: Colors.green),
          ),
          TextButton(
              onPressed: () async {
                Get.back();
                Get.back();
                Get.back();
              },
              child: Text(
                "Back",
                style: Get.textTheme.titleMedium!
                    .copyWith(color: Theme.of(context).primaryColor),
              ))
        ],
      ),
    );
  }
}
