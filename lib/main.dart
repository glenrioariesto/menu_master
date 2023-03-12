import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:menu_master/view/home.dart';
import 'package:menu_master/view/login.dart';
import 'package:menu_master/view/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Menu Master',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: Login.nameRoute,
      routes: {
        Home.nameRoute: (context) => const Home(title: 'Menu Master'),
        Login.nameRoute: (context) => const Login(title: 'Login Menu Master'),
        Register.nameRoute: (context) => const Register(),
      },
    );
  }
}
