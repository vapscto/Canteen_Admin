import 'package:canteen_management/controller/global_utility.dart';
import 'package:canteen_management/controller/mskool_controller.dart';
import 'package:canteen_management/forgotpassword/screens/forgot_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:platform_device_id_v3/platform_device_id.dart';

import '../api/login_api.dart';
import '../main.dart';
import '../model/category_item_model.dart';
import '../model/login_success_model.dart';
import '../widgets/animated_progress.dart';
import '../widgets/error_widget.dart';
import 'common_file.dart';

class LoginScreen extends StatefulWidget {
  final MskoolController mskoolController;

  const LoginScreen({super.key, required this.mskoolController});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userName = TextEditingController();
  final TextEditingController password = TextEditingController();
  RxBool showPassword = RxBool(false);
  bool policyAccepted = false;
  String deviceToken = '';
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _getToken();
    super.initState();
  }

  _getToken() async {
    deviceToken = (await PlatformDeviceId.getDeviceId)!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
                height: Get.height * 0.39,
                width: double.infinity,
                color: Theme.of(context).primaryColor,
                child: Image.asset(
                  "assets/images/stars.png",
                  fit: BoxFit.cover,
                )),
            Container(
              margin: EdgeInsets.only(top: Get.height * 0.36),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0),
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(
                            widget.mskoolController.universalInsCodeModel!.value
                                .institutioNLOGO,
                          ),
                          // const SizedBox(
                          //   width: 12.0,
                          // ),
                          // Expanded(
                          //   child: Text(
                          //     "${widget.mskoolController.universalInsCodeModel!.value.institutioNNAME} ",
                          //     style: Theme.of(context).textTheme.titleMedium,
                          //   ),
                          // ),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Login",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: TextField(
                          autofocus: true,
                          textInputAction: TextInputAction.next,
                          controller: userName,
                          style: Theme.of(context).textTheme.titleSmall!.merge(
                              TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .color,
                                  fontSize: 17)),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(18.0),
                            filled: true,
                            isDense: false,
                            fillColor: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14.0),
                              borderSide: const BorderSide(color: Colors.indigo),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14.0),
                              borderSide: const BorderSide(color: Colors.indigo),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14.0),
                              borderSide: const BorderSide(color: Colors.indigo),
                            ),
                            hintText: 'User Id',
                            //label: Text("Institutional Code"),
                            prefixIcon: Container(
                              margin: const EdgeInsets.only(bottom: 2.0),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SvgPicture.asset(
                                  'assets/svg/profile.svg',
                                  colorFilter: const ColorFilter.mode(
                                    Color.fromARGB(188, 30, 60, 194),
                                    BlendMode.srcIn,
                                  ),
                                  height: 24.0,
                                  width: 24.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Obx(() {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: TextField(
                            controller: password,
                            obscureText: !showPassword.value,
                            style: Theme.of(context).textTheme.titleSmall!.merge(
                                TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .color,
                                    fontSize: 17)),
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(18.0),
                                isDense: true,
                                filled: true,
                                fillColor: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.5),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14.0),
                                  borderSide:
                                      const BorderSide(color: Colors.indigo),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14.0),
                                  borderSide:
                                      const BorderSide(color: Colors.indigo),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14.0),
                                  borderSide:
                                      const BorderSide(color: Colors.indigo),
                                ),
                                hintText: 'Password',
                                //label: Text("Institutional Code"),
                                prefixIcon: Container(
                                  margin: const EdgeInsets.only(bottom: 2.0),
                                  child: const Icon(
                                    Icons.lock_outline,
                                    color: Color.fromARGB(188, 30, 60, 194),
                                    size: 24,
                                  ),
                                ),
                                suffixIcon: InkWell(
                                    onTap: () {
                                      showPassword.value = !showPassword.value;
                                    },
                                    child: showPassword.value
                                        ? Icon(
                                            Icons.visibility,
                                            size: 24.0,
                                            color: Theme.of(context).primaryColor,
                                          )
                                        : Icon(
                                            Icons.visibility_off_outlined,
                                            size: 24.0,
                                            color: Theme.of(context).primaryColor,
                                          ))),
                          ),
                        );
                      }),
                      Align(
                        alignment: Alignment.center,
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
                              style:
                                  Theme.of(context).textTheme.labelSmall!.merge(
                                        const TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Color(0xFF666FB0),
                                        ),
                                      ),
                            )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                              visualDensity: const VisualDensity(
                                  horizontal: VisualDensity.minimumDensity),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              activeColor: Theme.of(context).primaryColor,
                              value: policyAccepted,
                              onChanged: (v) {
                                policyAccepted = v!;
                                setState(() {});
                              }),
                          RichText(
                              text: TextSpan(
                                  text: 'I agree to all your ',
                                  style: Theme.of(context).textTheme.titleSmall,
                                  children: [
                                TextSpan(
                                    text: "T&C",
                                    style:
                                        Theme.of(context).textTheme.titleMedium),
                                const TextSpan(text: " and "),
                                TextSpan(
                                    text: "Privacy Policy",
                                    style:
                                        Theme.of(context).textTheme.titleMedium)
                              ]))
                          //  Text("I agree to all your T&C and Privacy Policy")
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: ElevatedButton(
                            onPressed: ()  {
                              if (userName.text.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text(
                                          "Please provide a valid username",
                                          style: Get.textTheme.titleMedium!
                                              .copyWith(color: Colors.white),
                                        )));

                                return;
                              }
                              if (password.text.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text(
                                          "Please provide a valid password",
                                          style: Get.textTheme.titleMedium!
                                              .copyWith(color: Colors.white),
                                        )));

                                return;
                              }
                              if (!policyAccepted) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text(
                                          "Please accept T&C and Privacy Policy",
                                          style: Get.textTheme.titleMedium!
                                              .copyWith(color: Colors.white),
                                        )));
                                return;
                              }
                              String loginBaseUrl = "";
                              for (int i = 0;
                                  i <
                                      widget
                                          .mskoolController
                                          .universalInsCodeModel!
                                          .value
                                          .apiarray
                                          .values
                                          .length;
                                  i++) {
                                final CategoriesApiItem apiItem = widget
                                    .mskoolController
                                    .universalInsCodeModel!
                                    .value
                                    .apiarray
                                    .values
                                    .elementAt(i);
                                if (apiItem.iivrscurLAPIName.toLowerCase() ==
                                    "login") {
                                  loginBaseUrl = apiItem.iivrscurLAPIURL;
                                }
                              }
                               Future.delayed(
                                  const Duration(milliseconds: 200));
                              showDialog(
                                  context: context,
                                  builder: (_) {
                                    return SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width * 0.5,
                                      child: Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                        child: FutureBuilder<LoginSuccessModel>(
                                            future: AuthenticateUserApi.instance
                                                .authenticateNow(
                                                    userName.text,
                                                    password.text,
                                                    widget
                                                        .mskoolController
                                                        .universalInsCodeModel!
                                                        .value
                                                        .miId,
                                                    loginBaseUrl,
                                                    deviceToken),
                                            builder: (_, snapshot) {
                                              if (snapshot.hasData) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(20.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      // CircleAvatar(
                                                      //   backgroundColor:
                                                      //       Colors.grey.shade100,
                                                      //   radius: 36.0,
                                                      //   backgroundImage:
                                                      //       NetworkImage(snapshot
                                                      //               .data!
                                                      //               .userImagePath ??
                                                      //           ''),
                                                      // ),
                                                      const SizedBox(
                                                        height: 16.0,
                                                      ),
                                                      Text(
                                                        snapshot.data!.userName!,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall!
                                                            .merge(
                                                              const TextStyle(
                                                                fontSize: 16.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                      ),
                                                      const SizedBox(
                                                        height: 8.0,
                                                      ),
                                                      Text(
                                                        "Welcome back ${snapshot.data!.userName}, you can now continue to home screen",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelSmall!
                                                            .merge(TextStyle(
                                                                letterSpacing:
                                                                    0.2,
                                                                color: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .labelMedium!
                                                                    .color,
                                                                fontSize: 14)),
                                                      ),
                                                      const SizedBox(
                                                        height: 16.0,
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            MediaQuery.of(context)
                                                                    .size
                                                                    .width *
                                                                0.2,
                                                        child: ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            minimumSize: Size(
                                                              Get.width * 0.5,
                                                              50,
                                                            ),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16.0),
                                                            ),
                                                          ),
                                                          onPressed: () async {
                                                            counterId = snapshot.data!.counterNameModel!.values!.first.cMMCOId!;
                                                            Navigator.pop(
                                                                context);
                                                            logInBox!.put(
                                                                "isLoggedIn",
                                                                true);
                                                            Get.offAll(() =>
                                                                CommonFile(
                                                                  miId:
                                                                  snapshot.data!.mIID!,
                                                                  mskoolController: widget
                                                                      .mskoolController,
                                                                  loginSuccessModel: snapshot.data!,
                                                                )
                                                            );
                                                          },
                                                          child: Text(
                                                            "Continue",
                                                            style:
                                                                Theme.of(context)
                                                                    .textTheme
                                                                    .labelMedium!
                                                                    .merge(
                                                                      const TextStyle(
                                                                          color: Colors
                                                                              .white),
                                                                    ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }

                                              if (snapshot.hasError) {
                                                final Map<String, dynamic> err =
                                                    snapshot.error
                                                        as Map<String, dynamic>;
                                                return err['type'] == "exp"
                                                    ? ErrWidget(
                                                        err: err,
                                                        btnTitle:
                                                            "Update Password",
                                                        onPressed: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (_) {
                                                                return ForgotPasswordScreen(
                                                                  mskoolController:
                                                                      widget
                                                                          .mskoolController,
                                                                  forExpire: true,
                                                                );
                                                              },
                                                            ),
                                                          );
                                                        },
                                                      )
                                                    : ErrWidget(
                                                        err: err,
                                                      );
                                              }
                                              return SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5,
                                                child: const Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    AnimatedProgressWidget(
                                                        title: "Please Wait",
                                                        desc:
                                                            "We are trying to logging you in.",
                                                        animationPath:
                                                            "assets/json/default.json")
                                                  ],
                                                ),
                                              );
                                            }),
                                      ),
                                    );
                                  });
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                minimumSize: Size(Get.width * 0.5, 50)),
                            child: Text(
                              "Login",
                              style:
                                  Theme.of(context).textTheme.titleSmall!.merge(
                                        const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
