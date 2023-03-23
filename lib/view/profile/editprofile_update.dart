import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:menu_master/shared/constants.dart';
import 'package:menu_master/view/profile/picprofile.dart';

class editprofile_update extends StatelessWidget {
  editprofile_update({super.key});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _changeUsernameTC = TextEditingController();
  final TextEditingController _changeEmailTC = TextEditingController();
  final TextEditingController _changePasswordTC = TextEditingController();
  final TextEditingController _changeAlamatTC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: ColorPalette.primaryColor,
          title: Text(
            "Edit Profil",
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            picprofile(),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _changeUsernameTC,
                      decoration: const InputDecoration(
                          labelText: 'Input New Username',
                          errorStyle:
                              TextStyle(color: ColorPalette.textColorMM)),
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
                      decoration: const InputDecoration(
                          labelText: 'Input New Email',
                          errorStyle:
                              TextStyle(color: ColorPalette.textColorMM)),
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
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'New Address',
                        errorStyle: TextStyle(color: ColorPalette.textColorMM),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your new adress';
                        }
                        return null;
                      },
                      onSaved: (value) {},
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
