import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/akunmodel.dart';

class Akun with ChangeNotifier {
  List<AkunModel> _allakun = [];

  List<AkunModel> get allAkun => _allakun;

  static void addDataAkun(String username, String status) async {
    var url = Uri.parse(
        'https://menu-master-9c309-default-rtdb.firebaseio.com/akun.json');
    var response = await http.post(
      url,
      body: json.encode({
        "name": username,
        'status': status,
      }),
    );
    print(response.statusCode);
  }
}
