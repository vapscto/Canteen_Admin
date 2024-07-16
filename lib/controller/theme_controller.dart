import 'package:get/get.dart';

class ThemeController extends GetxController {
  RxBool isLightMode = true.obs;
  RxInt theme = RxInt(0);
}
