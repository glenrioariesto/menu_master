import 'package:flutter/material.dart';
import 'package:menu_master/view/profile/customer/displayprofilecustomer.dart';
import 'package:menu_master/view/profile/customer/picprofilecustomer.dart';
import 'package:menu_master/view/profile/customer/editprofilecustomer.dart';

class Body extends StatelessWidget {
  const Body({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [Picprofile(), Editprofile(), Displayprofile()],
    );
  }
}
