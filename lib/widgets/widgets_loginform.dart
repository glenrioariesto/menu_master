import 'package:flutter/material.dart';

import '../widgets/widgets_massagesnackbar.dart';
import '../shared/constants.dart';

import 'package:provider/provider.dart';
import '../provider/auth.dart';

import '../view/register.dart';
import '../view/home.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  Future<String> _authUserLogin(String email, String password) {
    return Future.delayed(const Duration(microseconds: 2250)).then((_) async {
      try {
        await Provider.of<Auth>(context, listen: false).login(email, password);
      } catch (err) {
        return "An Errorerror occurred: ${err.toString()}";
      }
      return 'Login Success';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _email,
              decoration: const InputDecoration(
                  labelText: 'Email',
                  errorStyle: TextStyle(color: ColorPalette.textColorMM)),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your Email';
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
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        _authUserLogin(_email.text, _password.text)
                            .then((value) {
                          Provider.of<Auth>(context, listen: false).tempData();
                          // print(value);
                          if (value == 'Login Success') {
                            Navigator.pushNamed(context, Home.nameRoute);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: ColorPalette.primaryColor,
                              elevation: 0,
                              behavior: SnackBarBehavior.floating,
                              content: MassageSnackBar(msgError: value),
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
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Register.nameRoute);
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
                      'Register',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
