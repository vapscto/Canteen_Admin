import 'package:canteen_management/constants/api_url.dart';
import 'package:canteen_management/controller/global_utility.dart';
import 'package:canteen_management/main.dart';
import 'package:dio/dio.dart';


class ResetPasswordApi {
  ResetPasswordApi.init();
  static final ResetPasswordApi instance = ResetPasswordApi.init();
var dio = Dio();
  Future<bool> resetPassword({
    required String password,
    required String newPassword,
    required int userId,
    required int miId,
    required String base,
  }) async {
    final String apiUrl = base + URLS.resetPassword;

    try {
      final Response response = await dio
          .post(apiUrl, options: Options(headers: getSession()), data: {
        "password": password,
        "new_password": newPassword,
        "User_Id": userId,
        "MI_Id": miId,
      });

      if (response.data['returnMsg'].toString().toLowerCase() == "success") {
        return Future.value(true);
      }
      return Future.error({
        "errorTitle": "Password Not Matched",
        "errorMsg":
            "Your previous password doesn't get matched with the password we have for your account",
      });
    } on Exception catch (e) {
      logger.e(e.toString());
      return Future.error({
        "errorTitle": "Unable to connect to server",
        "errorMsg":
            "Sorry! but we are unable to connect to server right now, try  again later",
      });
    }
  }

  Future<bool> changeExpiredPassword({
    required String userName,
    required String password,
    required String newPassword,
    required String entryDate,
    required String base,
  }) async {
    final String api = base + URLS.expiredPwd;
    final  ins = Dio();

    try {
      final Response response =
          await ins.post(api, options: Options(headers: getSession()), data: {
        "username": userName,
        "password": password,
        "schoolcollege": "\u0000",
        "Logintype": "mobile",
        "old_password": null,
        "new_password": newPassword,
        "Entry_Date": entryDate,
        "changepasswordtypeflag": "expired"
      });

      if (response.data['returnMsg'].toString().toLowerCase() == "success") {
        return Future.value(true);
      }
      return Future.error({
        "errorTitle": "Password Not Matched",
        "errorMsg": response.data['returnMsg'].toString(),
      });
    } on Exception catch (e) {
      logger.e(e.toString());
    }

    return Future.error(false);
  }
}
