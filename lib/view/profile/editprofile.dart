import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:menu_master/shared/constants.dart';
import 'package:menu_master/view/profile/editprofile_update.dart';

class editprofile extends StatelessWidget {
  const editprofile({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Text(
          "Mamed Kudasi",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text("AFAFGaming123@gmail.com"),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
            width: 200,
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(ColorPalette.primaryColor)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => editprofile_update()));
                },
                child: Text(
                  "Edit Profile",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ))),
        const SizedBox(
          height: 25,
        )
      ],
    );
  }
}
