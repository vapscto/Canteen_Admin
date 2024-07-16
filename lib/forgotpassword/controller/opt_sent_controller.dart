import 'package:get/get.dart';

class OtpSentStatusController extends GetxController {
  RxBool isOtpSent = RxBool(false);
  void updateOptSent(bool isSent) {
    isOtpSent.value = isSent;
  }

  RxBool disableResendBtn = RxBool(true);

  void updateDisableResendBtn(bool va) {
    disableResendBtn.value = va;
  }

  RxString otp = RxString("000000");

  void updateOtp(String newOtp) {
    otp.value = newOtp;
  }

  RxInt remainingTime = RxInt(59);
  void updateRemainingTime(int v) {
    remainingTime.value = v;
  }
}
