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
      child: TextButton(
        child: Text("Start Video Call"),
        onPressed: () {
          Get.toNamed("/agora_ui_kit_screen");
        },
      ),
    );
  }
}
