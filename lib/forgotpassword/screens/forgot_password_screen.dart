import 'package:canteen_management/controller/global_utility.dart';
import 'package:canteen_management/controller/mskool_controller.dart';
import 'package:canteen_management/forgotpassword/api/verify_username.dart';
import 'package:canteen_management/forgotpassword/model/verify_user_model.dart';
import 'package:canteen_management/forgotpassword/screens/select_verification_type.dart';
import 'package:canteen_management/widgets/animated_progress.dart';
import 'package:canteen_management/widgets/custom_appbar.dart';
import 'package:canteen_management/widgets/custom_container.dart';
import 'package:canteen_management/widgets/error_widget.dart';
import 'package:canteen_management/widgets/success_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final MskoolController mskoolController;
  final bool forExpire;

  const ForgotPasswordScreen(
      {super.key, required this.mskoolController, required this.forExpire});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController userName = TextEditingController();

  @override
  void dispose() {
    userName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Theme.of(context).primaryColor,
      appBar: const CustomAppBar(title: "Forgot Password").getAppBar(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: Get.height * 0.44,
              width: double.infinity,
              color: Theme.of(context).primaryColor,
              child: Column(

                  children: [
                const SizedBox(
                  height: 16.0,
                ),
                SvgPicture.asset('assets/svg/fp.svg'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 7,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
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
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                  ],
                ),
              ]),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: Get.height * 0.4),
              padding: const EdgeInsets.all(24.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Forgot Password ?",
                    style: Theme.of(context).textTheme.titleMedium!.merge(
                          const TextStyle(fontSize: 20.0),
                        ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  const Text(
                    "Enter your User name below to receive the forgot password instructions.",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 36.0,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.3,
                    child: CustomContainer(
                      child: TextField(
                        controller: userName,
                        style: Theme.of(context).textTheme.titleSmall!.merge(
                              TextStyle(
                                  fontSize: 18,
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .color),
                            ),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelStyle:
                                Theme.of(context).textTheme.labelSmall!.merge(
                                      TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 0.3,
                                        color: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .color,
                                      ),
                                    ),
                            // hintText: "Eg: Demo0485",
                            // floatingLabelBehavior: FloatingLabelBehavior.always,
                            label: const Text(
                              "User Name",
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.2,
                    child: Center(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                              minimumSize: Size(Get.width * 0.4, 50)),
                          onPressed: () {
                            if (userName.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                  "Please provide a username to get started your password reset process.",
                                  style: Get.textTheme.titleSmall!
                                      .copyWith(color: Colors.white),
                                ),
                                backgroundColor: Colors.red,
                              ));

                              return;
                            }
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (_) {
                                  return Dialog(
                                    insetPadding: const EdgeInsets.all(16.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(24.0)),
                                    child: FutureBuilder<VerifyUserNameModel>(
                                      future: VerifyUserNameApi.instance
                                          .verifyUserName(
                                        miId: widget.mskoolController
                                            .universalInsCodeModel!.value.miId,
                                        userName: userName.text,
                                        base: baseUrlFromInsCode(
                                          "login",
                                          widget.mskoolController,
                                        ),
                                      ),
                                      builder: (_, snapshot) {
                                        if (snapshot.hasData) {
                                          return SuccessWidget(
                                            title: "Account Found Successfully",
                                            message:
                                                "In the next step, you will be going to receive otp to reset your password",
                                            onPressed: () {
                                              Navigator.pop(context);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) {
                                                    return SelectVerificationType(
                                                      mskoolController:
                                                          widget.mskoolController,
                                                      emailId:
                                                          snapshot.data!.email!,
                                                      mobileNo: snapshot
                                                          .data!.mobileNo!,
                                                      userName:
                                                          userName.text.trim(),
                                                      forVerify: widget.forExpire,
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                          );
                                        }
                                        if (snapshot.hasError) {
                                          return ErrWidget(
                                              err: snapshot.error
                                                  as Map<String, dynamic>);
                                        }
                                        return const Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            AnimatedProgressWidget(
                                                title: "Please wait",
                                                desc:
                                                    "We are searching for your account",
                                                animationPath:
                                                    "assets/json/default.json"),
                                          ],
                                        );
                                      },
                                    ),
                                  );
                                });
                          },
                          child: Text(
                            "Continue",
                            style: Theme.of(context).textTheme.titleSmall!.merge(
                                  const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                  ),
                                ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
