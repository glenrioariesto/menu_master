import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/akunmodel.dart';

class AkunProvider with ChangeNotifier {
  final List<AkunModel> _allakun = [];

  List<AkunModel> get allAkun => _allakun;

  void addDataAkun(String username, String status, String idToken) async {
    var url = Uri.parse(
        'https://menu-master-9c309-default-rtdb.firebaseio.com/akun.json');
    var response = await http
        .post(
      url,
      body: json.encode({
        "username": username,
        "status": status,
        "idtoken": idToken,
      }),
    )
        .then((response) {
      _allakun.add(
        AkunModel(username: username, status: status, id: idToken),
      );
    });
    //
  }
}
