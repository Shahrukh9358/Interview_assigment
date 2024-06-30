import 'dart:async';

import 'package:assignment_project/controllers/auth_controller.dart';
import 'package:assignment_project/controllers/user_controller.dart';
import 'package:get/get.dart';

Future<void> replaceAllControllers() async {
  await Get.deleteAll(force: true);

  return;
}

class AppBindings extends Bindings {
  @override
  Future<void> dependencies() async {
    Get.put<AuthController>(
      AuthController(),
      permanent: true,
    );

    Get.put<UserController>(
      UserController(),
      permanent: true,
    );
  }
}