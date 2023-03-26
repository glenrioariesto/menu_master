import 'package:flutter/material.dart';
import 'package:menu_master/controller/auth_log.dart';
import 'package:menu_master/shared/constants.dart';
import 'package:menu_master/view/register.dart';
import 'package:menu_master/widgets/widgets_massagesnackbar.dart';

import '../view/home.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  bool isLogin = false;

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
              controller: _usernameTextController,
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
              controller: _passwordTextController,
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
                        await AuthLogin.login(_usernameTextController.text,
                                _passwordTextController.text)
                            .then((value) {
                          isLogin = value;
                          if (isLogin) {
                            Navigator.pushNamed(context, Home.nameRoute);
                          }
                        });
                        if (isLogin != true) {
                          await AuthLogin.infoError(
                                  _usernameTextController.text,
                                  _passwordTextController.text)
                              .then((value) {
                            return ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: ColorPalette.primaryColor,
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                content: MassageSnackBar(msgError: value),
                              ),
                            );
                          });
                        }
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
