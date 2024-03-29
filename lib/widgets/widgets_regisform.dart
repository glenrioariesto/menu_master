import 'package:flutter/material.dart';

import '../shared/constants.dart';
import '../widgets/widgets_massagesnackbar.dart';

import 'package:provider/provider.dart';
import '../provider/auth.dart';
import '../provider/akunprovider.dart';

import '../view/login.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmpassword = TextEditingController();
  String? _selectItems = "Customer";

  Future<String> _authUserSignup(
      String email, String password, String username, String status) {
    return Future.delayed(const Duration(microseconds: 2250)).then((_) async {
      try {
        await Provider.of<Auth>(context, listen: false).signup(
          email,
          password,
          username,
          status,
        );
      } catch (err) {
        return "An Errorerror occurred: ${err.toString()}";
      }
      return "Register Success";
    });
  }

  @override
  Widget build(BuildContext context) {
    final akunProv = Provider.of<AkunProvider>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            style: TextStyle(color: Colors.white),
            controller: _username,
            decoration: const InputDecoration(
                icon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                labelText: 'Username',
                labelStyle: TextStyle(color: Colors.white),
                errorStyle: TextStyle(color: ColorPalette.textColorMM)),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your username';
              }
              return null;
            },
            onSaved: (value) {},
          ),
          TextFormField(
            style: TextStyle(color: Colors.white),
            controller: _email,
            decoration: const InputDecoration(
                icon: Icon(
                  Icons.email,
                  color: Colors.white,
                ),
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.white),
                errorStyle: TextStyle(color: ColorPalette.textColorMM)),
            autofocus: false,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
            onSaved: (value) {},
          ),
          TextFormField(
            style: TextStyle(color: Colors.white),
            controller: _password,
            obscureText: true,
            decoration: const InputDecoration(
                icon: Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.white),
                errorStyle: TextStyle(color: ColorPalette.textColorMM)),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
            onSaved: (value) {},
          ),
          TextFormField(
            style: TextStyle(color: Colors.white),
            controller: _confirmpassword,
            obscureText: true,
            decoration: const InputDecoration(
              icon: Icon(
                Icons.security,
                color: Colors.white,
              ),
              labelText: 'Confirm Password',
              labelStyle: TextStyle(color: Colors.white),
              errorStyle: TextStyle(color: ColorPalette.textColorMM),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your password';
              } else if (_password.text != _confirmpassword.text) {
                return 'Please confirm password ';
              }
              return null;
            },
            onSaved: (value) {},
          ),
          Row(
            children: [
              const Icon(Icons.art_track, color: Colors.white),
              const SizedBox(
                width: 15,
              ),
              DropdownButton(
                style: TextStyle(color: ColorPalette.primaryColor),
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                hint: Text(
                  _selectItems.toString(),
                  style: TextStyle(color: Colors.white),
                ),
                items: const [
                  DropdownMenuItem(
                    value: "Customer",
                    child: Text("Customer"),
                  ),
                  DropdownMenuItem(
                    value: "Seller",
                    child: Text("Seller"),
                  ),
                ],
                onChanged: (newvalue) {
                  setState(() {
                    _selectItems = newvalue.toString();
                  });
                },
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  autofocus: true,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _authUserSignup(_email.text, _password.text,
                              _username.text, _selectItems.toString())
                          .then((value) {
                        auth.tempData();
                        if (value == 'Register Success') {
                          akunProv
                              .addDataAkun(
                                  _username.text,
                                  _selectItems.toString(),
                                  auth.userId.toString())
                              .then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: ColorPalette.primaryColor,
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                content: MassageSnackBar(
                                    msgError: 'Register Success',
                                    msg: "welcome to menu master"),
                              ),
                            );
                          });

                          Navigator.pushNamed(context, Login.nameRoute);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: ColorPalette.primaryColor,
                            elevation: 0,
                            behavior: SnackBarBehavior.floating,
                            content: MassageSnackBar(
                                msgError: value, msg: "Oh Snap!!!"),
                          ));
                        }
                      });
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        ColorPalette.secondaryColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                  child:
                      const Text('Save', style: TextStyle(color: Colors.black)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ElevatedButton(
                  autofocus: true,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        ColorPalette.secondaryColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
