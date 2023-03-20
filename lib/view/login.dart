import 'package:flutter/material.dart';
import 'package:menu_master/shared/constants.dart';
import 'package:menu_master/widgets/widgets_loginform.dart';

class Login extends StatefulWidget {
  const Login({super.key, required this.title});

  static const nameRoute = '/login';
  final String title;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.primaryColor,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              Image.asset(
                'assets/images/logoMenuMaster.png',
                height: 250,
                width: 250,
                fit: BoxFit.cover,
              ),
              const Text(
                'Menu Master',
                style: TextStyle(fontSize: 24, color: ColorPalette.textColorMM),
              ),
              const SizedBox(
                height: 15,
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: LoginForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
