import 'package:flutter/material.dart';

import '../widgets/widgets_massagesnackbar.dart';
import '../shared/constants.dart';

import 'package:provider/provider.dart';
import '../provider/auth.dart';
import '../provider/akunprovider.dart';

import '../view/register.dart';
import '../view/homecustomer.dart';
import '../view/homeseller.dart';

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
        print(err);
        return "An Errorerror occurred: ${err.toString()}";
      }
      return 'Login Success';
    });
  }

  @override
  Widget build(BuildContext context) {
    final akunProv = Provider.of<AkunProvider>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your Email';
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
                          auth.tempData();
                          // print(value);
                          if (value == 'Login Success') {
                            const CircularProgressIndicator();
                            akunProv.getDataById(auth.userId!).then((value) {
                              var status = akunProv.allAkun;
                              for (int i = 0; i < status.length; i++) {
                                final akun = status[i];
                                if (akun.status == "Customer") {
                                  return Navigator.pushNamed(
                                      context, HomeCustomer.nameRoute);
                                } else {
                                  return Navigator.pushNamed(
                                      context, HomeSeller.nameRoute);
                                }
                              }
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: ColorPalette.primaryColor,
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                content: MassageSnackBar(
                                    msgError: value, msg: "Oh Snapss!!!"),
                              ),
                            );
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
