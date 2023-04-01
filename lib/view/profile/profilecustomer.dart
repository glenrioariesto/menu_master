import 'package:flutter/material.dart';
import 'package:menu_master/shared/constants.dart';
import 'package:menu_master/view/profile/bodyprofilecustomer.dart';

class Profilecustomer extends StatelessWidget {
  const Profilecustomer({super.key});
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
