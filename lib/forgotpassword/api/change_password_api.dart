import 'package:canteen_management/constants/api_url.dart';
import 'package:canteen_management/controller/global_utility.dart';
import 'package:canteen_management/forgotpassword/model/password_changed_model.dart';
import 'package:dio/dio.dart';

import '../../main.dart';


class ChangePasswordApi {
  ChangePasswordApi.init();
  static final ChangePasswordApi instance = ChangePasswordApi.init();
var dio = Dio();
  Future<bool> changePassword(
      {required String newPassword,
      required int miId,
      required String userName,
      required String base}) async {
    final String apiUrl = base + URLS.changePassword;

    try {
      final Response response = await dio.post(
        apiUrl,
        options: Options(headers: getSession()),
        data: {
          "newPassword": newPassword,
          "miId": miId,
          "username": userName,
        },
      );
      final PasswordChangedModel passwordChangedModel =
          PasswordChangedModel.fromJson(response.data);
      if (passwordChangedModel.message!.toLowerCase() == "success") {
        return Future.value(true);
      }

      return Future.error({
        "errorTitle": "Password Change Unsuccessfull",
        "errorMsg": passwordChangedModel.message,
      });
    } on Exception catch (e) {
      logger.e(e.toString());
      return Future.error({
        "errorTitle": "Password Change Unsuccessfull",
        "errorMsg":
            "Currently we are unable to connect to server, try again later",
      });
    }
  }
}
