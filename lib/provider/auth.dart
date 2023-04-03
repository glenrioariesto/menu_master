import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../provider/akunprovider.dart';

class Auth with ChangeNotifier {
  Timer? _authTimer;
  String? _idToken, userId, email;
  DateTime? _expiryDate;

  String? _tempidToken, tempuserId, _tempemail;
  DateTime? _tempexpiryDate;

  void tempData() {
    _idToken = _tempidToken;
    userId = tempuserId;
    _expiryDate = _tempexpiryDate;
    email = _tempemail;
    // print(token);
    // print(isAuth);
    notifyListeners();
  }

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_idToken != null &&
        _expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now())) {
      return _idToken;
    } else {
      return null;
    }
  }

  Future<void> signup(
      String email, String password, String username, String status) async {
    Uri url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDtPYC8gHOXCqk2fEhvy2i36JuIkQHEvsA");

    try {
      var response = await http.post(
        url,
        body: json.encode(
          {
            "email": email,
            "password": password,
            "returnSecureToken": true,
          },
        ),
      );

      var responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw responseData['error']['message'];
      }

      _tempemail = responseData["email"];
      _tempidToken = responseData["idToken"];
      tempuserId = responseData["localId"];
      _tempexpiryDate = DateTime.now().add(Duration(
        seconds: int.parse(responseData["expiresIn"]),
      ));
      // akunProvider.addDataAkun(username, status, _tempidToken!);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    Uri url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDtPYC8gHOXCqk2fEhvy2i36JuIkQHEvsA");

    try {
      var response = await http.post(
        url,
        body: json.encode(
          {
            "email": email,
            "password": password,
            "returnSecureToken": true,
          },
        ),
      );

      var responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw responseData['error']['message'];
      }

      _tempemail = responseData["email"];
      _tempidToken = responseData["idToken"];
      tempuserId = responseData["localId"];
      _tempexpiryDate = DateTime.now().add(Duration(
        seconds: int.parse(responseData["expiresIn"]),
      ));

      autologout();
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  void logout() {
    _idToken = null;
    userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }

    notifyListeners();
  }

  void autologout() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    final timeToExpiry = _tempexpiryDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }

  Future<void> changeEmail(String email, String password) async {
    Uri url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:update?key=AIzaSyDtPYC8gHOXCqk2fEhvy2i36JuIkQHEvsA");
    try {
      var response = await http.post(
        url,
        body: json.encode(
          {
            "email": email,
            "password": password,
            "returnSecureToken": false,
            "idToken": _idToken,
          },
        ),
      );

      var responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        print(responseData);

        throw responseData['error']['message'];
      }
      _tempemail = responseData["email"];

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
