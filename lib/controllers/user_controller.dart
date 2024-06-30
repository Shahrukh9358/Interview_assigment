import 'package:get/get.dart';

class UserController extends GetxController {
  RxString uid = "".obs;

  setUserId(String id) {
    uid.value = id;
  }
}