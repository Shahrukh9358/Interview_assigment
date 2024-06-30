import 'dart:math';

import 'package:agora_uikit/agora_uikit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AgoraUIKit extends StatefulWidget {
  const AgoraUIKit({ super.key });

  @override
  State<AgoraUIKit> createState() => _AgoraUIKitState();
}

class _AgoraUIKitState extends State<AgoraUIKit> {

  String appId = '0a22be79067c46fa8d594544539496f2';
  String channelName = 'sample_channel';
  bool isAgoraInitialized = false;
  late AgoraClient client;

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  int generateRandomSixDigitNumber() {
    Random random = Random();
    int min = 100000;
    int max = 999999;
    return min + random.nextInt(max - min + 1);
  }

  void initAgora() async {

    // create token
    Dio _dio = Dio();
    int uid = generateRandomSixDigitNumber();
    Response _response = await _dio.get('https://agora-server-assignment-8d2b39ac0e71.herokuapp.com/rtc-uid-token/$uid');

    client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: appId,
        channelName: channelName,
        tempToken: _response.data["token"],
        uid: uid,
      ),
    );
    await client.initialize();

    setState(() {
      isAgoraInitialized = true;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isAgoraInitialized ? SafeArea(
        child: Stack(
          children: [
            AgoraVideoViewer(
              client: client,
            ),
            AgoraVideoButtons(
              client: client,
            ),
          ],
        ),
      ) : const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
