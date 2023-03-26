import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthLogin {
  static Future<bool> login(String email, String password) async {
    bool isLogin = false;

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (kDebugMode) {
        print('Login Success');
      }
      isLogin = true;
    } catch (e) {
      isLogin = false;
    }
    return isLogin;
  }

  static Future<String> infoError(String email, String password) async {
    String msg = '';

    try {
      FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      if (e is FirebaseException) {
        msg = e.message.toString();
      } else {
        msg = 'An Errorerror occurred: ${e.toString()}';
      }
    }
    return msg;
  }
}
