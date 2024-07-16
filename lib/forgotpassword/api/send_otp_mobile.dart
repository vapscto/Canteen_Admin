import 'package:canteen_management/constants/api_url.dart';
import 'package:canteen_management/controller/global_utility.dart';
import 'package:canteen_management/forgotpassword/controller/opt_sent_controller.dart';
import 'package:canteen_management/forgotpassword/model/opt_verification_model.dart';
import 'package:canteen_management/main.dart';
import 'package:dio/dio.dart';


class SendOtpToMobile {
  SendOtpToMobile.init();
  static SendOtpToMobile instance = SendOtpToMobile.init();

  Future<OptVerificationModel> sendOtp(
      {required int miId,
      required int mobileNo,
      required String base,
      required OtpSentStatusController statusController}) async {
    final String apiUrl = base + URLS.sendOtp;

    final  dio = Dio();
    if (statusController.isOtpSent.value == true) {
      statusController.updateOptSent(false);
    }
    try {
      final Response response = await dio
          .post(apiUrl, options: Options(headers: getSession()), data: {
        "MI_Id": miId,
        "MobileNo": mobileNo,
      });

      if (response.data['displaymessage'] == null) {
        return Future.error({
          "errorTitle": "Unable to send otp",
          "errorMsg": "We are unable to send otp to $mobileNo",
        });
      }

      OptVerificationModel optVerificationModel =
          OptVerificationModel.fromJson(response.data);
      logger.d(response.data['displaymessage']);
      statusController.updateOtp(response.data['displaymessage']);
      statusController.updateOptSent(true);
      return Future.value(optVerificationModel);
    } on Exception catch (e) {
      logger.e(e.toString());
      return Future.error({
        "errorTitle": "Unable to send otp",
        "errorMsg":
            "We are unable to send otp to $mobileNo, because server is not working right now, try again later",
      });
    }
  }
}
