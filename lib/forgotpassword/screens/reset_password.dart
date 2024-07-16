import 'package:canteen_management/controller/global_utility.dart';
import 'package:canteen_management/controller/mskool_controller.dart';
import 'package:canteen_management/forgotpassword/api/reset_password.dart';
import 'package:canteen_management/main.dart';
import 'package:canteen_management/model/login_success_model.dart';
import 'package:canteen_management/widgets/animated_progress.dart';
import 'package:canteen_management/widgets/custom_appbar.dart';
import 'package:canteen_management/widgets/custom_container.dart';
import 'package:canteen_management/widgets/error_widget.dart';
import 'package:canteen_management/widgets/success_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ResetPassword extends StatefulWidget {
  final MskoolController mskoolController;
  final LoginSuccessModel loginSuccessModel;

  const ResetPassword(
      {super.key,
      required this.mskoolController,
      required this.loginSuccessModel});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController previousPassword = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  @override
  void dispose() {
    previousPassword.dispose();
    newPassword.dispose();
    confirmPassword.dispose();
    super.dispose();
  }
  List newList = [];
  int id = 0;
  String name = '';
  String photo = '';
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Change Password").getAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Create New Password",
              style: Theme.of(context).textTheme.titleMedium!.merge(
                    const TextStyle(fontSize: 20.0),
                  ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              "Your new password must be different from the previous used passwords.",
              style: Theme.of(context).textTheme.titleSmall!.merge(
                    const TextStyle(fontSize: 16.0),
                  ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            // Text(
            //   "Previous Password",
            //   style: Theme.of(context)
            //       .textTheme
            //       .titleSmall!
            //       .merge(const TextStyle(fontSize: 16.0)),
            // ),
            // const SizedBox(
            //   height: 8.0,
            // ),
            SizedBox(
              width: MediaQuery.of(context).size.width *0.4,
              child: CustomContainer(
                child: TextField(
                  controller: previousPassword,
                  style: Theme.of(context).textTheme.titleSmall!.merge(
                        TextStyle(
                            fontSize: 16,
                            color:
                                Theme.of(context).textTheme.titleMedium!.color),
                      ),
                  decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                      border: InputBorder.none,
                      hintText: " Enter your previous password"),
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            // Text(
            //   "New Password",
            //   style: Theme.of(context)
            //       .textTheme
            //       .titleSmall!
            //       .merge(const TextStyle(fontSize: 16.0)),
            // ),
            // const SizedBox(
            //   height: 8.0,
            // ),
            SizedBox(
              width: MediaQuery.of(context).size.width *0.4,
              child: CustomContainer(
                child: TextField(
                  controller: newPassword,
                  style: Theme.of(context).textTheme.titleSmall!.merge(
                        TextStyle(
                            fontSize: 16,
                            color:
                                Theme.of(context).textTheme.titleMedium!.color),
                      ),
                  decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                      border: InputBorder.none,
                      hintText: " Enter your new password"),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            // Text(
            //   "Confirm Password",
            //   style: Theme.of(context)
            //       .textTheme
            //       .titleSmall!
            //       .merge(const TextStyle(fontSize: 16.0)),
            // ),
            // const SizedBox(
            //   height: 8.0,
            // ),
            SizedBox(width: MediaQuery.of(context).size.width *0.4,
              child: CustomContainer(
                child: TextField(
                  controller: confirmPassword,
                  style: Theme.of(context).textTheme.titleSmall!.merge(
                        TextStyle(
                            fontSize: 16,
                            color:
                                Theme.of(context).textTheme.titleMedium!.color),
                      ),
                  decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                      border: InputBorder.none,
                      hintText: " Confirm your new password"),
                ),
              ),
            ),
            const SizedBox(
              height: 48.0,
            ),
            Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      minimumSize: Size(Get.width * 0.2, 50)),
                  onPressed: () {
                    if (previousPassword.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          "Please provide previously used password",
                          style: Get.textTheme.titleSmall!.copyWith(color: Colors.white),
                        ),backgroundColor: Colors.red,));

                      return;
                    }
                    if (previousPassword.text == newPassword.text) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          "New Password must not be same as previous password.",
                          style: Get.textTheme.titleSmall!.copyWith(color: Colors.white),
                        ),backgroundColor: Colors.red,));

                      return;
                    }

                    if (newPassword.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          "Please provide new password",
                          style: Get.textTheme.titleSmall!.copyWith(color: Colors.white),
                        ),backgroundColor: Colors.red,));

                      return;
                    }
                    if (newPassword.text != confirmPassword.text) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          "New Password and confirm password is not matching. It should match",
                          style: Get.textTheme.titleSmall!.copyWith(color: Colors.white),
                        ),backgroundColor: Colors.red,));

                      return;
                    }
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0)),
                            child: FutureBuilder<bool>(
                              future: ResetPasswordApi.instance.resetPassword(
                                  password: previousPassword.text,
                                  newPassword: newPassword.text,
                                  userId: widget.loginSuccessModel.userId!,
                                  miId: widget.mskoolController
                                      .universalInsCodeModel!.value.miId,
                                  base: baseUrlFromInsCode(
                                      "login", widget.mskoolController)),
                              builder: (_, snapshot) {
                                if (snapshot.hasData && snapshot.data!) {
                                  logInBox!.put("password", newPassword.text);
                                  return SuccessWidget(
                                    title: "Password Changed Successfully",
                                    message:
                                        "You can now use your new password for login.",
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
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
                                            "We are changing your password, just a sec",
                                        animationPath:
                                            "assets/json/changepass.json"),
                                  ],
                                );
                              },
                            ),
                          );
                        });
                  },
                  child: Text(
                    "Save Password",
                    style: Theme.of(context).textTheme.titleSmall!.merge(
                        const TextStyle(color: Colors.white, fontSize: 18.0)),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
