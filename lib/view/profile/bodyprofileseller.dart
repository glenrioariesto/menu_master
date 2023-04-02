import 'package:flutter/material.dart';
import 'package:menu_master/view/profile/seller/displayprofileseller.dart';
import 'package:menu_master/view/profile/seller/picprofileseller.dart';
import 'package:menu_master/view/profile/seller/editprofileseller.dart';

class Body extends StatelessWidget {
  const Body({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [Picprofile(), Editprofile(), Displayprofile()],
      ),
    );
  }
}
