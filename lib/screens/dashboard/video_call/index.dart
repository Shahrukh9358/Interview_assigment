import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            height: 170,
            width: 370,
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(30),
             color: Colors.deepPurple,
           ),
            child: Text("Install the App: Ensure both users have the same app installed on their devices",
              style: TextStyle(fontSize: 20,color: Colors.white),
            ),
          ),
          SizedBox(height: 30,),
          TextButton(
            child: Text(
              "Start Video Call",
              style: TextStyle(color: Colors
                  .white), // Text color to contrast with black background
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.black, // Background color
              fixedSize: Size(150, 50), // Width and height
            ),
            onPressed: () {
              Get.toNamed("/agora_ui_kit_screen");
            },
          ),
        ],
      )
    );
  }
}