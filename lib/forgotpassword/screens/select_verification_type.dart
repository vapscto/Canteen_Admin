import 'package:canteen_management/controller/mskool_controller.dart';
import 'package:canteen_management/forgotpassword/screens/otp_verification_screen.dart';
import 'package:canteen_management/widgets/custom_appbar.dart';
import 'package:canteen_management/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


class SelectVerificationType extends StatefulWidget {
  final String mobileNo;
  final String emailId;
  final MskoolController mskoolController;
  final String userName;
  final bool forVerify;
  const SelectVerificationType({
    super.key,
    required this.mobileNo,
    required this.emailId,
    required this.mskoolController,
    required this.userName,
    required this.forVerify,
  });

  @override
  State<SelectVerificationType> createState() => _SelectVerificationTypeState();
}

class _SelectVerificationTypeState extends State<SelectVerificationType> {
  String verificationType = "mobile";
  final TextEditingController controller = TextEditingController();
  @override
  void initState() {
    if (verificationType == "mobile") {
      controller.text = widget.mobileNo;
    } else {
      controller.text = widget.emailId;
    }
    super.initState();
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
                SvgPicture.asset('assets/svg/slctmob.svg'),
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
                  ],
                ),
              ]),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: Get.height * 0.39),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Select Email/ Mobile Number",
                          style: Theme.of(context).textTheme.titleMedium!.merge(
                                const TextStyle(fontSize: 20.0),
                              ),
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        const Text(
                          "To sent the password recovery instructions choose mail\\ Mobile Number.",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Theme(
                              data: ThemeData(
                                  unselectedWidgetColor:
                                      Theme.of(context).primaryColor),
                              child: Radio(
                                value: "mobile",
                                activeColor: Theme.of(context).primaryColor,
                                focusColor: Theme.of(context).primaryColor,
                                visualDensity: const VisualDensity(
                                  horizontal: VisualDensity.minimumDensity,
                                  vertical: VisualDensity.minimumDensity,
                                ),
                                groupValue: verificationType,
                                onChanged: (e) {
                                  verificationType = e!;
                                  controller.text = widget.mobileNo;
                                  setState(() {});
                                },
                              ),
                            ),
                            Text(
                              "Mobile Number",
                              style:
                                  Theme.of(context).textTheme.titleSmall!.merge(
                                        const TextStyle(fontSize: 16.0),
                                      ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Theme(
                              data: ThemeData(
                                  unselectedWidgetColor:
                                      Theme.of(context).primaryColor),
                              child: Radio(
                                value: "email",
                                activeColor: Theme.of(context).primaryColor,
                                visualDensity: const VisualDensity(
                                  horizontal: VisualDensity.minimumDensity,
                                  vertical: VisualDensity.minimumDensity,
                                ),
                                groupValue: verificationType,
                                onChanged: (e) {
                                  verificationType = e!;
                                  controller.text = widget.emailId;
                                  setState(() {});
                                },
                              ),
                            ),
                            Text(
                              "E-mail",
                              style:
                                  Theme.of(context).textTheme.titleSmall!.merge(
                                        const TextStyle(fontSize: 16.0),
                                      ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: CustomContainer(
                      child: TextField(
                        controller: controller,
                        readOnly: true,
                        style: Theme.of(context).textTheme.titleSmall!.merge(
                              TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .color),
                            ),
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 8.0),
                            border: InputBorder.none,
                            hintText: verificationType.toLowerCase() == "mobile"
                                ? " Enter your Phone Number"
                                : " Enter your Email Id"),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 36.0,
                  ),
                  Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                            minimumSize: Size(Get.width * 0.4, 50)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) {
                                return OTPScreen(
                                  isEmailVerification:
                                      verificationType == "email"
                                          ? true
                                          : false,
                                  mskoolController: widget.mskoolController,
                                  otpSendingInfo: controller.text,
                                  userName: widget.userName,
                                  forExpiry: widget.forVerify,
                                );
                              },
                            ),
                          );
                        },
                        child: Text(
                          "Continue",
                          style: Theme.of(context).textTheme.titleSmall!.merge(
                              const TextStyle(
                                  color: Colors.white, fontSize: 18.0)),
                        )),
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
