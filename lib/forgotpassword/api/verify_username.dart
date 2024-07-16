import 'package:canteen_management/constants/api_url.dart';
import 'package:canteen_management/controller/global_utility.dart';
import 'package:canteen_management/forgotpassword/model/verify_user_model.dart';
import 'package:canteen_management/main.dart';
import 'package:dio/dio.dart';


class VerifyUserNameApi {
  VerifyUserNameApi.init();
  static final VerifyUserNameApi instance = VerifyUserNameApi.init();

  Future<VerifyUserNameModel> verifyUserName({
    required int miId,
    required String userName,
    required String base,
  }) async {
    final String apiURL = base + URLS.verifyUser;
    final  dio = Dio();
    try {
      final Response response = await dio.post(
        apiURL,
        options: Options(headers: getSession()),
        data: {
          "username": userName,
        },
      );
      final VerifyUserNameModel verifyUserNameModel =
          VerifyUserNameModel.fromJson(response.data);

      if (response.statusCode != 200) {
        return Future.error({
          {
            "errorTitle": "Request not fullfill successfully",
            "errorMsg":
                "Currently server is not fullfilling the request successfully, try again after some time.",
          }
        });
      }

      if (verifyUserNameModel.userNameVerifyStatus!.toLowerCase() == "fail") {
        return Future.error({
          "errorTitle": "UserName not Verified",
          "errorMsg":
              "No account associated with this particular username,check and try again",
        });
      }

      return Future.value(verifyUserNameModel);
    } on Exception catch (e) {
      logger.e(e.toString());
      return Future.error({
        "errorTitle": "Server not reachable",
        "errorMsg":
            "We are unable to connect to server right now or server is returing error, try again after some time.",
      });
    }
  }
}
