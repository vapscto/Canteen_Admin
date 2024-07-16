import 'dart:async';

import 'package:canteen_management/constants/theme_constants.dart';
import 'package:canteen_management/controller/global_utility.dart';
import 'package:canteen_management/controller/mskool_controller.dart';
import 'package:canteen_management/forgotpassword/api/send_otp_mobile.dart';
import 'package:canteen_management/forgotpassword/api/send_otp_to_email.dart';
import 'package:canteen_management/forgotpassword/controller/opt_sent_controller.dart';
import 'package:canteen_management/forgotpassword/screens/change_expired_password.dart';
import 'package:canteen_management/forgotpassword/screens/change_password.dart';
import 'package:canteen_management/widgets/animated_progress.dart';
import 'package:canteen_management/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class OTPScreen extends StatefulWidget {
  final MskoolController mskoolController;
  final bool isEmailVerification;
  final String otpSendingInfo;
  final bool forExpiry;
  final String userName;

  const OTPScreen({
    super.key,
    required this.mskoolController,
    required this.isEmailVerification,
    required this.otpSendingInfo,
    required this.userName,
    required this.forExpiry,
  });

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final OtpSentStatusController otpSentStatusController =
      Get.put(OtpSentStatusController());
  final TextEditingController entredOtp = TextEditingController();

  Timer? timer;

  // int seconds = 59;
  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (otpSentStatusController.remainingTime.value == 0) {
        otpSentStatusController.updateDisableResendBtn(false);
      } else {
        otpSentStatusController.remainingTime.value -= 1;
      }
    });
    if (widget.isEmailVerification) {
      SendOtpToEmail.instance.sendOtpNow(
          miId: widget.mskoolController.universalInsCodeModel!.value.miId,
          email: widget.otpSendingInfo,
          base: baseUrlFromInsCode("login", widget.mskoolController),
          statusController: otpSentStatusController);
    } else {
      SendOtpToMobile.instance.sendOtp(
          miId: widget.mskoolController.universalInsCodeModel!.value.miId,
          mobileNo: int.parse(widget.otpSendingInfo.trim()),
          base: baseUrlFromInsCode("login", widget.mskoolController),
          statusController: otpSentStatusController);
    }
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<OtpSentStatusController>();
    entredOtp.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Forgot Password").getAppBar(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: Get.height * 0.44,
              width: double.infinity,
              color: Theme.of(context).primaryColor,
              child: Column(children: [
                const SizedBox(
                  height: 16.0,
                ),
                SvgPicture.asset('assets/svg/verification.svg'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 7,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    Container(
                      height: 7,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    Container(
                      height: 7,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                  ],
                ),
              ]),
            ),
            Container(
              padding: const EdgeInsets.all(24.0),
              width: double.infinity,
              margin: EdgeInsets.only(top: Get.height * 0.39),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
              ),
              child: Obx(() {
                return !otpSentStatusController.isOtpSent.value
                    ? AnimatedProgressWidget(
                        title: "Sending Otp",
                        desc: "We are sending otp on ${widget.otpSendingInfo}.",
                        animationPath: "assets/json/forgot.json")
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Verification Code",
                            style:
                                Theme.of(context).textTheme.titleMedium!.merge(
                                      const TextStyle(fontSize: 20.0),
                                    ),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          Text(
                            "We’ve send the verification code on ${widget.otpSendingInfo}.",
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Pinput(
                            length: 6,
                            controller: entredOtp,
                            defaultPinTheme: PinTheme(
                              //padding: const EdgeInsets.all(16.0),
                              width: 56,
                              height: 56,
                              textStyle:
                                  Theme.of(context).textTheme.titleMedium!,
                              decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: CustomThemeData.getShadow(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(() {
                                return TextButton(
                                    onPressed: otpSentStatusController
                                            .disableResendBtn.value
                                        ? null
                                        : () async {
                                            otpSentStatusController
                                                .updateDisableResendBtn(true);
                                            if (widget.isEmailVerification) {
                                              await SendOtpToEmail.instance
                                                  .sendOtpNow(
                                                      miId: widget
                                                          .mskoolController
                                                          .universalInsCodeModel!
                                                          .value
                                                          .miId,
                                                      email:
                                                          widget.otpSendingInfo,
                                                      base: baseUrlFromInsCode(
                                                          "login",
                                                          widget
                                                              .mskoolController),
                                                      statusController:
                                                          otpSentStatusController);
                                            } else {
                                              await SendOtpToMobile.instance.sendOtp(
                                                  miId: widget
                                                      .mskoolController
                                                      .universalInsCodeModel!
                                                      .value
                                                      .miId,
                                                  mobileNo: int.parse(widget
                                                      .otpSendingInfo
                                                      .trim()),
                                                  base: baseUrlFromInsCode(
                                                      "login",
                                                      widget.mskoolController),
                                                  statusController:
                                                      otpSentStatusController);
                                            }
                                            otpSentStatusController
                                                .updateRemainingTime(59);
                                          },
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6.0),
                                    ),
                                    child: Text(
                                      "Resend Code",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .merge(
                                            TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                color: otpSentStatusController
                                                        .disableResendBtn.value
                                                    ? Theme.of(context)
                                                        .disabledColor
                                                    : Theme.of(context)
                                                        .textTheme
                                                        .titleSmall!
                                                        .color),
                                          ),
                                    ));
                              }),
                              Obx(() {
                                return Text(
                                  otpSentStatusController.remainingTime.value <
                                          10
                                      ? "0:0${otpSentStatusController.remainingTime.value}"
                                      : "0:${otpSentStatusController.remainingTime.value}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .merge(
                                        const TextStyle(
                                            // decoration: TextDecoration.underline,
                                            color: Color(0xFFFF828A)),
                                      ),
                                );
                              }),
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.1,
                          ),
                          Center(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24.0),
                                    ),
                                    minimumSize: Size(Get.width * 0.4, 50)),
                                onPressed: () {
                                  if (entredOtp.text.isEmpty) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                        "Please provide otp to continue",
                                        style: Get.textTheme.titleSmall!
                                            .copyWith(color: Colors.white),
                                      ),
                                      backgroundColor: Colors.red,
                                    ));

                                    return;
                                  }

                                  if (entredOtp.text !=
                                      otpSentStatusController.otp.value) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                        "You are entering wrong otp, we didn't sent this otp, check and try again",
                                        style: Get.textTheme.titleSmall!
                                            .copyWith(color: Colors.white),
                                      ),
                                      backgroundColor: Colors.red,
                                    ));

                                    return;
                                  }
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                      "Otp Verified Successfully, you can now change your password",
                                      style: Get.textTheme.titleSmall!
                                          .copyWith(color: Colors.white),
                                    ),
                                    backgroundColor: Colors.red,
                                  ));

                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) {
                                        return widget.forExpiry
                                            ? ResetExpiredPassword(
                                                base: baseUrlFromInsCode(
                                                    "login",
                                                    widget.mskoolController),
                                                userName: widget.userName,
                                                mskoolController:
                                                    widget.mskoolController,
                                              )
                                            : ChangePassword(
                                                mskoolController:
                                                    widget.mskoolController,
                                                userName: widget.userName,
                                              );
                                      },
                                    ),
                                  );
                                },
                                child: Text(
                                  "Continue",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .merge(const TextStyle(
                                          color: Colors.white, fontSize: 18.0)),
                                )),
                          ),
                        ],
                      );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
