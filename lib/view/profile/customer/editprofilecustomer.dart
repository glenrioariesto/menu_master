import 'package:flutter/material.dart';
import 'package:menu_master/shared/constants.dart';
import 'package:provider/provider.dart';

import '../../../model/akunmodel.dart';
import '../../../provider/akunprovider.dart';
import '../../../provider/auth.dart';
import '../../../view/profile/customer/editprofileupdatecustomer.dart';
import '../../../view/login.dart';

class Editprofile extends StatelessWidget {
  const Editprofile({super.key});
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    final akunProv = Provider.of<AkunProvider>(context, listen: false);

    akunProv.getDataById(auth.userId.toString());

    AkunModel akun = akunProv.selectById(auth.userId.toString());
    if (auth.userId.toString() == '') {
      Navigator.pushReplacementNamed(context, Login.nameRoute);
    }

    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Text(
          akun.username,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text(auth.email.toString()),
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
                  auth.tempData();
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
