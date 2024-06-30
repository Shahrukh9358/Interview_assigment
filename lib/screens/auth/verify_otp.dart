import 'dart:developer';

import 'package:assignment_project/controllers/auth_controller.dart';
import 'package:assignment_project/controllers/user_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:get/get.dart';

import '../../constants.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final TextEditingController pinController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FocusNode focusNode = FocusNode();

  AuthController _authController = Get.find<AuthController>();
  UserController _userController = Get.find<UserController>();

  verifyCode() async {
    log(_authController.verificationId.value.toString());
    log(pinController.text.toString());
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: _authController.verificationId.value, smsCode: pinController.text);
    UserCredential _userCredentials = await auth.signInWithCredential(credential);

    Get.showSnackbar(
      const GetSnackBar(
        message: "Verified Successfully",
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      )
    );

    // update userid in UserController...
    _userController.setUserId(_userCredentials.user!.uid);

    // check if user already exists in our databsae....
    QuerySnapshot _snapshot = await db.collection(AppConstants.userCollection).where("uid", isEqualTo: _userCredentials.user!.uid).get();
    if(_snapshot.docs.isNotEmpty) {
      // get to dashboard....

      Get.offNamedUntil('/dashboard', (Route<dynamic> route) => false);
    } else {
      Get.toNamed('/ask_user_details');
    }
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 48,
      height: 48,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Pinput(
                controller: pinController,
                focusNode: focusNode,
                length: 6,
                defaultPinTheme: defaultPinTheme,
                separatorBuilder: (index) => const SizedBox(width: 8),
                hapticFeedbackType: HapticFeedbackType.lightImpact,
                onCompleted: (pin) {
                  debugPrint('onCompleted: $pin');
                },
                onChanged: (value) {
                  debugPrint('onChanged: $value');
                },
                cursor: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 9),
                      width: 22,
                      height: 1,
                      color: focusedBorderColor,
                    ),
                  ],
                ),
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: focusedBorderColor),
                  ),
                ),
                submittedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    color: fillColor,
                    borderRadius: BorderRadius.circular(19),
                    border: Border.all(color: focusedBorderColor),
                  ),
                ),
                errorPinTheme: defaultPinTheme.copyBorderWith(
                  border: Border.all(color: Colors.redAccent),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child:  TextButton(
                  onPressed: () {
                    focusNode.unfocus();

                    verifyCode();
                  },
                  child: const Text('Validate'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
