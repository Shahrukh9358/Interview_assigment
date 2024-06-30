import 'dart:developer';

import 'package:agora_uikit/agora_uikit.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  TextEditingController _phoneNumberController = TextEditingController();
  AuthController _authController = Get.find<AuthController>();
  String _countryCode = '91';


  verifyPhone() async {
    log('+$_countryCode ${_phoneNumberController.text.trim()}');
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+$_countryCode ${_phoneNumberController.text.trim()}',
      verificationCompleted: (PhoneAuthCredential credential) {
        log(credential.accessToken.toString(), name: "verificationCompleted");
      },
      verificationFailed: (FirebaseAuthException e) {
        log(e.message.toString(), name: "verificationFailed");
        Get.showSnackbar(
          GetSnackBar(
            backgroundColor: Colors.red,
            message: e.message.toString(),
          )
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        _authController.setVerificationId(verificationId);
        Get.toNamed('/verify_otp');
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        log(verificationId.toString(), name: "codeAutoRetrievalTimeout");
      },
    );
  }

  @override
  void initState() {
    super.initState();

    [Permission.microphone, Permission.camera].request();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFCB2B93),
              Color(0xFF9546C4),
              Color(0xFF5E61F4),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              20, MediaQuery.of(context).size.height * 0.1, 20, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                // margin: EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  "assets/images/real.png",
                  height: 240,
                  width: 240,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 30,),
              TextFormField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white), // Set border color for enabled state
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white), // Set border color for focused state
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: GestureDetector(
                    onTap: () {
                      showCountryPicker(
                        context: context,
                        showPhoneCode: true,
                        onSelect: (Country country) {
                          setState(() {
                            _countryCode = country.countryCode;
                          });
                        },
                      );
                    },
                    child: Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('+$_countryCode'), // This should be the selected country code
                          const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: 240,
                      height: 50,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: const BorderSide(color: Colors.black),
                        ),
                        onPressed: verifyPhone,
                        child: const Text(
                          "Verify Phone",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
}
