import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/akunmodel.dart';

class AkunProvider with ChangeNotifier {
  final List<AkunModel> _allakun = [];

  List<AkunModel> get allAkun => _allakun;

  String urlmenumaster =
      "https://menu-master-9c309-default-rtdb.firebaseio.com";

  AkunModel selectById(String id) {
    return _allakun.firstWhere((element) => element.id == id,
        orElse: () => null as AkunModel);
  }

  Future<void> addDataAkun(
      String username, String status, String userId) async {
    try {
      var url = Uri.parse("$urlmenumaster/akun/$userId.json");
      var response = await http.put(
        url,
        body: json.encode({
          "username": username,
          "status": status,
          "address": "",
          "imageUrl": ''
        }),
      );
      if (response.statusCode == 200) {
        _allakun.add(
          AkunModel(
              id: userId,
              username: username,
              status: status,
              address: '',
              imageUrl: ''),
        );
        notifyListeners();
      } else {
        throw Exception('Failed to add data');
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> getDataById(String userId) async {
    var url = Uri.parse('$urlmenumaster/akun.json');
    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = json.decode(response.body) as Map<String, dynamic>;

        _allakun.clear();
        data.forEach((key, value) {
          if (userId == key) {
            _allakun.add(
              AkunModel(
                id: key,
                username: value['username'],
                status: value['status'],
                address: value['address'],
                imageUrl: value['imageUrl'],
              ),
            );
          }
        });
        notifyListeners();
      }
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<void> getDataAkun() async {
    var url = Uri.parse("$urlmenumaster/akun.json");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as Map<String, dynamic>;
      _allakun.clear();
      data.forEach((key, value) {
        _allakun.add(
          AkunModel(
            username: value['username'],
            status: value['status'],
            id: data["name"],
            address: value['address'],
            imageUrl: value['imageUrl'],
          ),
        );
      });
      notifyListeners();
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<void> updateDataAkun(
      String address, String username, String userId) async {
    var url = Uri.parse(
      '$urlmenumaster/akun/$userId.json',
    );

    getDataById(userId);
    AkunModel akun = selectById(userId);
    String image = akun.imageUrl;
    String adr = akun.address;
    String usernm = akun.username;

    if (address != '') {
      adr = address;
    } else if (username != '') {
      usernm = username;
    }

    var response = await http.put(
      url,
      body: json.encode({
        "username": usernm,
        "status": akun.status,
        "address": adr,
        "imageUrl": image
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update data');
    }
  }
}
