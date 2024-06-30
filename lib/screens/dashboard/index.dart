import 'package:assignment_project/screens/dashboard/chat/index.dart';
import 'package:assignment_project/screens/dashboard/profile/index.dart';
import 'package:assignment_project/screens/dashboard/video_call/index.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int pageIndex = 0;
  List<Widget> _screens = [
    VideoCallScreen(),
    ChatScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: (index) => setState(() {
          pageIndex = index;
        }),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home
            ),
            label: "Home"
          ),
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.chat
              ),
            label: "Chats"
          ),
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.person
              ),
            label: "Profile"
          ),
        ],
      ),
      body: _screens[pageIndex]
    );
  }
}
