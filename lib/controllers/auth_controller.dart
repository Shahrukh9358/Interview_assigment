import 'package:get/get.dart';

class AuthController extends GetxController {
  RxString verificationId = "".obs;

  setVerificationId(String id) {
    verificationId.value = id;
  }
}