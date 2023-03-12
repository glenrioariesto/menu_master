import 'package:flutter/material.dart';
import 'package:menu_master/shared/constants.dart';
import 'package:menu_master/widgets/widgets_regisform.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  static const nameRoute = '/register';

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.primaryColor,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Image.asset(
                'assets/images/logoMenuMaster.png',
                height: 250,
                width: 250,
                fit: BoxFit.cover,
              ),
              const Text(
                'Register',
                style: TextStyle(fontSize: 24, color: ColorPalette.textColorMM),
              ),
              const SizedBox(
                height: 15,
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: RegisterForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
