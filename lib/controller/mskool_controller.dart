import 'package:get/get.dart';

import '../model/institution_data_model.dart';
import '../model/login_success_model.dart';

class MskoolController extends GetxController {
  Rx<InstitutionalCodeModel>? universalInsCodeModel;

  Rx<LoginSuccessModel>? loginSuccessModel;

  void updateUniversalInsCodeModel(InstitutionalCodeModel newValue) {
    universalInsCodeModel = Rx<InstitutionalCodeModel>(newValue);
  }

  void updateLoginSuccessModel(LoginSuccessModel newValue) {
    loginSuccessModel = Rx<LoginSuccessModel>(newValue);
  }
}
