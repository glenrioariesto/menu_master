import 'package:flutter/material.dart';
import 'package:menu_master/provider/akunprovider.dart';

import '../shared/constants.dart';
import '../widgets/widgets_massagesnackbar.dart';

import 'package:provider/provider.dart';
import '../provider/auth.dart';

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
      String idtoken = '';
      try {
        await Provider.of<Auth>(context, listen: false)
            .signup(
          email,
          password,
          username,
          status,
        )
            .then((value) {
          idtoken = value;
        });
      } catch (err) {
        print(err);
        return "An Errorerror occurred: ${err.toString()}";
      }
      return idtoken;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _username,
            decoration: const InputDecoration(
                icon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                labelText: 'Username',
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
            controller: _email,
            decoration: const InputDecoration(
                icon: Icon(
                  Icons.email,
                  color: Colors.white,
                ),
                labelText: 'Email',
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
            controller: _password,
            obscureText: true,
            decoration: const InputDecoration(
                icon: Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
                labelText: 'Password',
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
            controller: _confirmpassword,
            obscureText: true,
            decoration: const InputDecoration(
              icon: Icon(
                Icons.security,
                color: Colors.white,
              ),
              labelText: 'Confirm Password',
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
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                hint: Text(_selectItems.toString()),
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
                        if (value != '') {
                          Provider.of<AkunProvider>(context, listen: false)
                              .addDataAkun(
                                  _username.text, _selectItems!, value);
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
                          Navigator.pushNamed(context, Login.nameRoute);
                        } else {
                          print(value);
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
