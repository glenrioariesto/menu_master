import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:menu_master/shared/constants.dart';
import 'package:menu_master/view/profile/displayprofile.dart';
import 'package:menu_master/view/profile/picprofile.dart';
import 'package:menu_master/view/profile/editprofile.dart';

class body extends StatelessWidget {
  const body({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [picprofile(), editprofile(), displayprofile()],
    );
  }
}
