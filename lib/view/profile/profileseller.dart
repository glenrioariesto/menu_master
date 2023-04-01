import 'package:flutter/material.dart';
import 'package:menu_master/shared/constants.dart';
import 'package:menu_master/view/profile/bodyprofileseller.dart';

class Profileseller extends StatelessWidget {
  const Profileseller({super.key});
  static const nameRoute = '/profileseller';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.primaryColor,
        title: const Text("Profile seller"),
      ),
      body: const Body(),
    );
  }
}
