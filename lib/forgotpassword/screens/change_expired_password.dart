import 'package:canteen_management/controller/mskool_controller.dart';
import 'package:canteen_management/forgotpassword/api/reset_password.dart';
import 'package:canteen_management/forgotpassword/screens/forgot_password_screen.dart';
import 'package:canteen_management/main.dart';
import 'package:canteen_management/screens/splash_screen.dart';
import 'package:canteen_management/widgets/animated_progress.dart';
import 'package:canteen_management/widgets/custom_appbar.dart';
import 'package:canteen_management/widgets/custom_container.dart';
import 'package:canteen_management/widgets/error_widget.dart';
import 'package:canteen_management/widgets/success_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetExpiredPassword extends StatefulWidget {
  final String base;
  final String userName;
  final MskoolController mskoolController;
  final String? fromSplash;

  const ResetExpiredPassword({
    super.key,
    required this.base,
    required this.userName,
    required this.mskoolController,
    this.fromSplash,
  });

  @override
  State<ResetExpiredPassword> createState() => _ResetExpiredPasswordState();
}

class _ResetExpiredPasswordState extends State<ResetExpiredPassword> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Update Password").getAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Change Expired Password",
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
            Text(
              "Previous Password",
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
                controller: previousPassword,
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
                    hintText: " Enter your previous password"),
              ),
            ),
            // const SizedBox(
            //   height: 30.0,
            // ),
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) {
                          return ForgotPasswordScreen(
                            mskoolController: widget.mskoolController,
                            forExpire: false,
                          );
                        },
                      ),
                    );
                  },
                  child: Text(
                    "FORGOT PASSWORD ?",
                    style: Theme.of(context).textTheme.labelSmall!.merge(
                          const TextStyle(
                            decoration: TextDecoration.underline,
                            color: Color(0xFF666FB0),
                          ),
                        ),
                  )),
            ),
            // const SizedBox(
            //   height: 30.0,
            // ),
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
                controller: confirmPassword,
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
                      minimumSize: Size(Get.width * 0.6, 50)),
                  onPressed: () {
                    if (previousPassword.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                        "Please provide previously used password",
                        style: Get.textTheme.titleSmall!.copyWith(color: Colors.white),
                      ),backgroundColor: Colors.red,));

                      return;
                    }

                    if (previousPassword.text != logInBox!.get("password") &&
                        widget.fromSplash != null) {
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
                            insetPadding: const EdgeInsets.all(16.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0)),
                            child: FutureBuilder<bool>(
                              future: ResetPasswordApi.instance
                                  .changeExpiredPassword(
                                password: previousPassword.text,
                                newPassword: newPassword.text,
                                entryDate: DateTime.now().toLocal().toString(),
                                userName: widget.userName,
                                base: widget.base,
                              ),
                              builder: (_, snapshot) {
                                if (snapshot.hasData && snapshot.data!) {
                                  logInBox!.put("password", newPassword.text);
                                  return SuccessWidget(
                                    title: "Password Changed Successfully",
                                    message:
                                        "You can now use your new password for login.",
                                    onPressed: () {
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (_) {
                                        return const SplashScreen(
                                            // isStudentlogin: false,
                                            // password: newPassword.text,
                                            // userName: '',
                                            // id: 0,
                                            );
                                      }));
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
