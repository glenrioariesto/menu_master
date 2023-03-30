import 'package:flutter/material.dart';

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
  final TextEditingController _usernameTextController = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmpassword = TextEditingController();

  Future<String> _authUserSignup(String email, String password) {
    return Future.delayed(const Duration(microseconds: 2250)).then((_) async {
      try {
        await Provider.of<Auth>(context, listen: false).signup(email, password);
      } catch (err) {
        return "An Errorerror occurred: ${err.toString()}";
      }
      return 'Register Success';
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
            controller: _usernameTextController,
            decoration: const InputDecoration(
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  autofocus: true,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _authUserSignup(_email.text, _password.text)
                          .then((value) {
                        if (value == 'Login Success') {
                          Navigator.pushNamed(context, Login.nameRoute);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: ColorPalette.primaryColor,
                            elevation: 0,
                            behavior: SnackBarBehavior.floating,
                            content: MassageSnackBar(msgError: value),
                          ));
                        }
                      });

                      // FirebaseAuth.instance
                      //     .createUserWithEmailAndPassword(
                      //         email: _email.text,
                      //         password: _password.text)
                      //     .then((value) {
                      //   if (kDebugMode) {
                      //     print('Create Account');
                      //   }
                      //   Navigator.pushNamed(context, Login.nameRoute);
                      // }).onError((error, stackTrace) {
                      //   if (kDebugMode) {
                      //     print('register error ${error.toString()}');
                      //   }
                      // });
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
