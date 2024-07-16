
import 'package:dio/dio.dart';
import '../constants/api_url.dart';
import '../main.dart';
import '../model/login_success_model.dart';

class AuthenticateUserApi {
  AuthenticateUserApi.init();
  static AuthenticateUserApi instance = AuthenticateUserApi.init();

  Future<LoginSuccessModel> authenticateNow(
      String userName,
      String password,
      int miId,
      String loginBaseUrl,
      String mobiledeviceid,
      ) async {
    final Dio ins = Dio();
    String loginApiUrl = loginBaseUrl + URLS.login;


    logger.d(loginApiUrl);

    logger.d({
      "MI_Id": miId,
      "username": userName,
      "password": password,
      "Logintype": "system",
      "mobiledeviceid": mobiledeviceid,
    });

    Response response = await ins.post(loginApiUrl, data: {
      "MI_Id": miId,
      "username": userName,
      "password": password,
      "Logintype": "Mobile",
      "mobiledeviceid": mobiledeviceid,
    });
    if (response.data['message'] != null) {
      if (response.data['message'] == "expired") {
        return Future.error({
          "errorTitle": "Password Expired",
          "type": "exp",
          "errorMsg":
          "Hello! $userName your password is expired you need to update the password before continuing further",
          "userName": userName,
        });
      }
      return Future.error({
        "errorTitle": response.data['message'],
        "type": "oth",
        "errorMsg": "I think your${response.data['message']}.",
      });
    }
    final LoginSuccessModel loginSuccessModel =
    LoginSuccessModel.fromJson(response.data);
    logger.d(loginSuccessModel.roleId);
    cookieBox!.put("cookie", response.headers.map['set-cookie']![0]);
    await importantIds!.put(URLS.miId, loginSuccessModel.mIID);
    await importantIds!.put(URLS.userId, loginSuccessModel.userId);
    await importantIds!.put(URLS.asmayId, loginSuccessModel.asmaYId);
    await importantIds!.put(URLS.ivrmrtId, 0);
    await importantIds!.put(URLS.amstId, loginSuccessModel.amsTId);
    await logInBox!.put("userName", userName);
    await logInBox!.put("password", password);
    // await logInBox!.put("logBasUrl", loginBaseUrl);
    return Future.value(loginSuccessModel);
  }

}
