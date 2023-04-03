import 'package:flutter/material.dart';
import 'package:menu_master/shared/constants.dart';
import 'package:provider/provider.dart';

import '../../../model/akunmodel.dart';

import '../../../provider/akunprovider.dart';
import '../../../provider/auth.dart';

import 'package:menu_master/view/homeseller.dart';
import 'package:menu_master/view/profile/seller/picprofileseller.dart';

class Editprofileupdate extends StatelessWidget {
  Editprofileupdate({super.key});
  final TextEditingController _changeUsernameTC = TextEditingController();
  final TextEditingController _changeEmailTC = TextEditingController();
  final TextEditingController _changePasswordTC = TextEditingController();
  final TextEditingController _changeAlamatTC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    final akunProv = Provider.of<AkunProvider>(context, listen: false);

    akunProv.getDataById(auth.userId.toString());
    AkunModel akun = akunProv.selectById(auth.userId.toString());

    return Scaffold(
      appBar: AppBar(
          backgroundColor: ColorPalette.primaryColor,
          title: const Text(
            "Edit Profil",
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Picprofile(),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _changeUsernameTC,
                      decoration: InputDecoration(
                          hintText: akun.username,
                          labelText: 'Input New Username',
                          errorStyle:
                              const TextStyle(color: ColorPalette.textColorMM)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your new Username';
                        }
                        return null;
                      },
                      onSaved: (value) {},
                    ),
                    TextFormField(
                      controller: _changeEmailTC,
                      decoration: InputDecoration(
                          hintText: auth.email,
                          labelText: 'Input New Email',
                          errorStyle:
                              const TextStyle(color: ColorPalette.textColorMM)),
                      autofocus: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your new Email';
                        }
                        return null;
                      },
                      onSaved: (value) {},
                    ),
                    TextFormField(
                      controller: _changePasswordTC,
                      obscureText: true,
                      decoration: const InputDecoration(
                          labelText: 'New Password',
                          errorStyle:
                              TextStyle(color: ColorPalette.textColorMM)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your New password';
                        }
                        return null;
                      },
                      onSaved: (value) {},
                    ),
                    TextFormField(
                      controller: _changeAlamatTC,
                      decoration: InputDecoration(
                        hintText: akun.address != ''
                            ? akun.address
                            : 'there is no address yet',
                        labelText: 'New Address',
                        errorStyle:
                            const TextStyle(color: ColorPalette.textColorMM),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your new adress';
                        }
                        return null;
                      },
                      onSaved: (value) {},
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        autofocus: true,
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (ctx) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              });
                          auth.changeEmail(
                              _changeEmailTC.text, _changePasswordTC.text);
                          akunProv
                              .updateDataAkun(
                                  _changeAlamatTC.text,
                                  _changeUsernameTC.text,
                                  auth.userId.toString())
                              .then((value) {
                            Navigator.pushReplacementNamed(
                                context, HomeSeller.nameRoute);
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              ColorPalette.secondaryColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                        ),
                        child: const Text('Save',
                            style: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
