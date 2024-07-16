import 'package:canteen_management/api/institution_code_api.dart';
import 'package:canteen_management/constants/api_url.dart';
import 'package:canteen_management/controller/mskool_controller.dart';
import 'package:canteen_management/main.dart';
import 'package:canteen_management/model/institution_data_model.dart';
import 'package:canteen_management/screens/splash_screen.dart';
import 'package:canteen_management/widgets/animated_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'login_screen.dart';

class InstitutionLogin extends StatefulWidget {
  const InstitutionLogin({super.key});

  @override
  State<InstitutionLogin> createState() => _InstitutionLoginState();
}

class _InstitutionLoginState extends State<InstitutionLogin> {
  final MskoolController mskoolController = Get.put(MskoolController());
  final TextEditingController insCode = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final FocusNode _focusNode1 = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    _focusNode1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KeyboardListener(
        focusNode: _focusNode,
        autofocus: true,
        onKeyEvent: (event) {
          if (event is KeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.enter) {
            if (insCode.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(
                    "Please provide an institutional code",
                    style:
                        Get.textTheme.titleSmall!.copyWith(color: Colors.white),
                  )));
              return;
            }
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: FutureBuilder<InstitutionalCodeModel>(
                        future: InstitutionalCodeApi.instance
                            .loginWithInsCode(insCode.text, false),
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data != null) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              mskoolController.updateUniversalInsCodeModel(snapshot.data!);
                            });
                            return Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: KeyboardListener(
                                focusNode: _focusNode1,
                                autofocus: true,
                                onKeyEvent: (e) async {
                                  if (e is KeyDownEvent &&
                                      e.logicalKey ==
                                          LogicalKeyboardKey.enter) {
                                    await importantIds!
                                        .put(URLS.miId, snapshot.data!.miId);
                                    await importantIds!.put(
                                        URLS.userId, snapshot.data!.userId);
                                    await importantIds!.put(
                                        URLS.asmayId, snapshot.data!.asmaYId);
                                    await importantIds!.put(URLS.ivrmrtId, 0);
                                    await importantIds!.put(
                                        URLS.amstId, snapshot.data!.amstId);
                                    institutionalCode!
                                        .put(
                                      "institutionalCode",
                                      snapshot.data!.institutecode,
                                    )
                                        .then(
                                      (value) {
                                        Navigator.pop(context);
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) {
                                              return
                                                  // CanteenHomeScreen(
                                                  //   miId: snapshot.data!.miId,
                                                  //   mskoolController:
                                                  //   mskoolController,
                                                  // );
                                                  LoginScreen(
                                                mskoolController:
                                                    mskoolController,
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  }
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.grey.shade100,
                                      radius: 36.0,
                                      backgroundImage: NetworkImage(
                                          snapshot.data!.institutioNLOGO),
                                    ),
                                    const SizedBox(
                                      height: 16.0,
                                    ),
                                    Text(
                                      snapshot.data!.institutioNNAME,
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .merge(
                                            const TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w600),
                                          ),
                                    ),
                                    const SizedBox(
                                      height: 8.0,
                                    ),
                                    Text(
                                      "We successfully found institution with this code, you can now continue with next step",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .merge(TextStyle(
                                              letterSpacing: 0.2,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium!
                                                  .color,
                                              fontSize: 14)),
                                    ),
                                    const SizedBox(
                                      height: 16.0,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: const Size(
                                            double.infinity,
                                            50,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                          ),
                                        ),
                                        onPressed: () async {
                                          await importantIds!.put(
                                              URLS.miId, snapshot.data!.miId);
                                          await importantIds!.put(URLS.userId,
                                              snapshot.data!.userId);
                                          await importantIds!.put(URLS.asmayId,
                                              snapshot.data!.asmaYId);
                                          await importantIds!
                                              .put(URLS.ivrmrtId, 0);
                                          await importantIds!.put(URLS.amstId,
                                              snapshot.data!.amstId);
                                          institutionalCode!
                                              .put(
                                            "institutionalCode",
                                            snapshot.data!.institutecode,
                                          )
                                              .then(
                                            (value) {
                                              Navigator.pop(context);
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) {
                                                    return
                                                        // CanteenHomeScreen(
                                                        //   miId: snapshot.data!.miId,
                                                        //   mskoolController:
                                                        //   mskoolController,
                                                        // );
                                                        LoginScreen(
                                                      mskoolController:
                                                          mskoolController,
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Text(
                                          "Continue",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium!
                                              .merge(
                                                const TextStyle(
                                                    color: Colors.white),
                                              ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          if (snapshot.hasError) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              institutionalCode!.clear();
                              insCode.clear();
                            });
                            return Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Invalid Institute Code",
                                    style: Get
                                        .textTheme.titleSmall!
                                        .copyWith(
                                        color: Colors.red,
                                        fontWeight:
                                        FontWeight
                                            .w600),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                const SplashScreen()));
                                      },
                                      child: Text(
                                        "OK",
                                        style: Get.textTheme
                                            .titleSmall!
                                            .copyWith(
                                            fontWeight:
                                            FontWeight
                                                .w600),
                                      ))
                                ],
                              ),
                            );
                          }
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: const AnimatedProgressWidget(
                                    title: "Please Wait",
                                    desc:
                                        "We are getting into your institutional detail's",
                                    animationPath: "assets/json/default.json"),
                              ),
                            ],
                          );
                        }),
                  ),
                );
              },
            );
          }
        },
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                  padding: const EdgeInsets.only(top: 48.0),
                  height: Get.height * 0.45,
                  width: double.infinity,
                  color: Theme.of(context).primaryColor,
                  child: Image.asset("assets/images/student.png")),
              Container(
                padding: const EdgeInsets.all(24.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.0),
                    topRight: Radius.circular(24.0),
                  ),
                ),
                margin: EdgeInsets.only(top: Get.height * 0.39),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Image.asset(
                        //   "assets/images/vpslogo.png",
                        //   height: 100,
                        // ),
                        // const SizedBox(
                        //   width: 12.0,
                        // ),
                        Text(
                          "I Vidyalaya Resource Management",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 36.0,
                    ),
                    Text(
                      "INSTITUTE ID",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: TextField(
                        autofocus: true,
                        controller: insCode,
                        keyboardType: TextInputType.text,
                        style: Theme.of(context).textTheme.titleSmall!.merge(
                            TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .color,
                                fontSize: 17)),
                        decoration: InputDecoration(
                          filled: true,
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
                          hintText: 'Institute Id',
                          //label: Text("Institutional Code"),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SvgPicture.asset(
                              'assets/svg/open_book.svg',
                              height: 24.0,
                              width: 24.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.05,
                    ),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                minimumSize: Size(Get.width * 0.6, 50)),
                            child: Text(
                              "Submit",
                              style:
                                  Theme.of(context).textTheme.labelLarge!.merge(
                                        const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600),
                                      ),
                            ),
                            onPressed: () {
                              if (insCode.text.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text(
                                          "Please provide an institutional code",
                                          style: Get.textTheme.titleMedium!
                                              .copyWith(color: Colors.white),
                                        )));

                                return;
                              }

                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (_) {
                                  return SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                      child: FutureBuilder<
                                              InstitutionalCodeModel>(
                                          future: InstitutionalCodeApi.instance
                                              .loginWithInsCode(
                                                  insCode.text, false),
                                          builder: (context, snapshot) {
                                            if (  snapshot.hasData &&snapshot.data != null) {
                                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                                mskoolController.updateUniversalInsCodeModel(snapshot.data!);
                                              });
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundColor:
                                                          Colors.grey.shade100,
                                                      radius: 36.0,
                                                      backgroundImage:
                                                          NetworkImage(snapshot
                                                              .data!
                                                              .institutioNLOGO),
                                                    ),
                                                    const SizedBox(
                                                      height: 16.0,
                                                    ),
                                                    Text(
                                                      snapshot.data!
                                                          .institutioNNAME,
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
                                                                        .w600),
                                                          ),
                                                    ),
                                                    const SizedBox(
                                                      height: 8.0,
                                                    ),
                                                    Text(
                                                      "We successfully found institution with this code, you can now continue with next step",
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
                                                          minimumSize:
                                                              const Size(
                                                            double.infinity,
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
                                                          await importantIds!
                                                              .put(
                                                                  URLS.miId,
                                                                  snapshot.data!
                                                                      .miId);
                                                          await importantIds!
                                                              .put(
                                                                  URLS.userId,
                                                                  snapshot.data!
                                                                      .userId);
                                                          await importantIds!
                                                              .put(
                                                                  URLS.asmayId,
                                                                  snapshot.data!
                                                                      .asmaYId);
                                                          await importantIds!
                                                              .put(
                                                                  URLS.ivrmrtId,
                                                                  0);
                                                          await importantIds!
                                                              .put(
                                                                  URLS.amstId,
                                                                  snapshot.data!
                                                                      .amstId);
                                                          institutionalCode!
                                                              .put(
                                                            "institutionalCode",
                                                            snapshot.data!
                                                                .institutecode,
                                                          )
                                                              .then(
                                                            (value) {
                                                              Navigator.pop(
                                                                  context);
                                                              Navigator
                                                                  .pushReplacement(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder: (_) {
                                                                    return
                                                                        //     CanteenHomeScreen(
                                                                        //   miId: snapshot.data!.miId,
                                                                        //   mskoolController:
                                                                        //   mskoolController,
                                                                        // );
                                                                        LoginScreen(
                                                                      mskoolController:
                                                                          mskoolController,
                                                                    );
                                                                  },
                                                                ),
                                                              );
                                                            },
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
                                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                                institutionalCode!.clear();
                                                insCode.clear();
                                              });
                                              return Padding(
                                                padding: const EdgeInsets.all(12.0),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      "Invalid Institute Code",
                                                      style: Get
                                                          .textTheme.titleSmall!
                                                          .copyWith(
                                                              color: Colors.red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                          Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (_) =>
                                                                      const SplashScreen()));
                                                        },
                                                        child: Text(
                                                          "OK",
                                                          style: Get.textTheme
                                                              .titleSmall!
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                        ))
                                                  ],
                                                ),
                                              );
                                            }
                                            return Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.5,
                                                  child: const AnimatedProgressWidget(
                                                      title: "Please Wait",
                                                      desc:
                                                          "We are getting into your institutional detail's",
                                                      animationPath:
                                                          "assets/json/default.json"),
                                                ),
                                              ],
                                            );
                                          }),
                                    ),
                                  );
                                },
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
