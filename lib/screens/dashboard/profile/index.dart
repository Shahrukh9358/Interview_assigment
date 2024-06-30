import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../onbaording.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void signOut() {
    FirebaseAuth.instance.signOut().then((value) {
      print("Signed Out");
      Get.offAll(() => Onboarding()); // This will navigate to the Onboarding screen and remove all previous routes
    }).catchError((error) {
      print("Error signing out: $error");
      // Optionally, you can show an error message to the user
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("Logout"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // Background color
                fixedSize: Size(150, 50), // Width and height
              ),
              onPressed: signOut,
            ),
          ],
        ),
      ),
    );
  }
}
