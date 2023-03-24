import 'package:flutter/material.dart';
import 'package:menu_master/view/profile/displayprofile.dart';
import 'package:menu_master/view/profile/picprofile.dart';
import 'package:menu_master/view/profile/editprofile.dart';

class Body extends StatelessWidget {
  const Body({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [Picprofile(), Editprofile(), Displayprofile()],
    );
  }
}
