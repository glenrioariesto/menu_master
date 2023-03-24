import 'package:flutter/material.dart';
import 'package:menu_master/shared/constants.dart';
import 'package:menu_master/view/profile/bodyprofile.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});
  static const nameRoute = '/profile';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.primaryColor,
        title: const Text("Profile"),
      ),
      body: const Body(),
    );
  }
}
