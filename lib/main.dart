import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../provider/auth.dart';
import '../provider/product.dart';

import '../view/profile/profile.dart';
import '../view/login.dart';
import '../view/register.dart';
import '../view/home.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Product(),
        ),
      ],
      builder: (context, child) => Consumer<Auth>(
        builder: (context, auth, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Menu Master',
          initialRoute: Login.nameRoute,
          onGenerateInitialRoutes: (set) {
            if (auth.isAuth) {
              print(set);
              print(auth.isAuth);
              return [
                MaterialPageRoute(
                    builder: (context) => Home(title: 'Menu Master'),
                    settings: RouteSettings(name: Home.nameRoute))
              ];
            }
            return [
              MaterialPageRoute(
                  builder: (context) => Login(title: "Login Menu Master"),
                  settings: RouteSettings(name: Login.nameRoute))
            ];
          },
          routes: {
            Home.nameRoute: (context) => Home(title: 'Menu Master'),
            Profile.nameRoute: (context) => const Profile(),
            Login.nameRoute: (context) => Login(title: 'Login Menu Master'),
            Register.nameRoute: (context) => const Register(),
          },
        ),
      ),
    );
  }
}
