import 'package:canteen_management/controller/global_utility.dart';
import 'package:canteen_management/controller/mskool_controller.dart';
import 'package:canteen_management/forgotpassword/api/change_password_api.dart';
import 'package:canteen_management/main.dart';
import 'package:canteen_management/widgets/animated_progress.dart';
import 'package:canteen_management/widgets/custom_appbar.dart';
import 'package:canteen_management/widgets/custom_container.dart';
import 'package:canteen_management/widgets/error_widget.dart';
import 'package:canteen_management/widgets/success_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePassword extends StatefulWidget {
  final String userName;
  final MskoolController mskoolController;

  const ChangePassword({
    super.key,
    required this.userName,
    required this.mskoolController,
  });

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  @override
  void dispose() {
    newPassword.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Forgot Password").getAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Reset Password",
              style: Theme.of(context).textTheme.titleMedium!.merge(
                    const TextStyle(fontSize: 20.0),
                  ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              "Please choose your new password",
              style: Theme.of(context).textTheme.titleSmall!.merge(
                    const TextStyle(fontSize: 16.0),
                  ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              "New Password",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .merge(const TextStyle(fontSize: 16.0)),
            ),
            const SizedBox(
              height: 8.0,
            ),
            CustomContainer(
              child: TextField(
                controller: newPassword,
                obscureText: true,
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
            const SizedBox(
              height: 20.0,
            ),
            Text(
              "Confirm Password",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .merge(const TextStyle(fontSize: 16.0)),
            ),
            const SizedBox(
              height: 8.0,
            ),
            CustomContainer(
              child: TextField(
                obscureText: true,
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
            const SizedBox(
              height: 48.0,
            ),
            Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      minimumSize: Size(Get.width * 0.1, 50)),
                  onPressed: () {
                    if (newPassword.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                        "Please provide new password",
                        style: Get.textTheme.titleSmall!
                            .copyWith(color: Colors.white),
                      ),backgroundColor: Colors.red,));

                      return;
                    }

                    if (newPassword.text != confirmPassword.text) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          "New Password and confirm passwords are not matching. It should match",
                          style: Get.textTheme.titleSmall!
                              .copyWith(color: Colors.white),
                        ),backgroundColor: Colors.red,));


                      return;
                    }

                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) {
                          return Dialog(
                            insetPadding: const EdgeInsets.all(16.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0)),
                            child: FutureBuilder<bool>(
                              future: ChangePasswordApi.instance.changePassword(
                                  newPassword: newPassword.text,
                                  miId: widget.mskoolController
                                      .universalInsCodeModel!.value.miId,
                                  userName: widget.userName,
                                  base: baseUrlFromInsCode(
                                      "login", widget.mskoolController)),
                              builder: (_, snapshot) {
                                if (snapshot.hasData && snapshot.data!) {
                                  logInBox!.put("password", newPassword.text);
                                  return SuccessWidget(
                                    title: "Password Changed Successfully",
                                    message:
                                        "You can now login using your new password.",
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
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
                                            "We are changing your password, just a sec.",
                                        animationPath:
                                            "assets/json/default.json"),
                                  ],
                                );
                              },
                            ),
                          );
                        });
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (_) {
                    //       return ResetPassword();
                    //     },
                    //   ),
                    // );
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
