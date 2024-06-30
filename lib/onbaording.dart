import 'package:assignment_project/screens/auth/index.dart';
import 'package:assignment_project/screens/login_with_email/email.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Container(
                height: 240,
                width: 240,
                color: Colors.orange,
                child: Image.asset("assets/images/real2.png", fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 50),
            SizedBox(
              height: 50,
              width: 350,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.white),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: const BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                onPressed: () {
                  Get.to(const AuthenticationScreen());
                },
                child: const Text(
                  "Create Account",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // OR Divider
            const Row(
              children: [
                Expanded(
                  child: Divider(
                    color: Colors.white,
                    height: 1.5,
                  ),
                ),
                Text(
                  "OR",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Divider(
                    color: Colors.white,
                    height: 1.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: 350,
              child: TextButton(
                style: ButtonStyle(
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: const BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                onPressed: () {
                  Get.to(const EmailPasswordScreen());
                },
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 50),
            const Text(
              "Continue as guest",
              style: TextStyle(fontSize: 15, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
