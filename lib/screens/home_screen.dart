import 'package:famdoc_user/screens/welcome_screen.dart';
import 'package:famdoc_user/user_screen_helper/drawerScreen.dart';
import 'package:famdoc_user/user_screen_helper/home_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'home-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerScreen(),
          HomeContent(),
        ],
      ),
    );
  }
}
