import 'package:flutter/material.dart';
import 'package:menu_master/shared/constants.dart';
import 'package:menu_master/view/profile/editprofile_update.dart';

class Editprofile extends StatelessWidget {
  const Editprofile({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        const Text(
          "Mamed Kudasi",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const Text("AFAFGaming123@gmail.com"),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
            width: 200,
            child: ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(ColorPalette.primaryColor)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Editprofileupdate()));
                },
                child: const Text(
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
