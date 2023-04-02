import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/akunmodel.dart';

class AkunProvider with ChangeNotifier {
  final List<AkunModel> _allakun = [];

  List<AkunModel> get allAkun => _allakun;

  Future<void> addDataAkun(
      String username, String status, String userId) async {
    try {
      var url = Uri.parse(
          'https://menu-master-9c309-default-rtdb.firebaseio.com/akun.json');
      var response = await http.post(
        url,
        body: json.encode({
          "username": username,
          "status": status,
          "userId": userId,
          "alamat": "",
          "imageUrl": ''
        }),
      );
      if (response.statusCode == 200) {
        _allakun.add(
          AkunModel(
              username: username,
              status: status,
              id: userId,
              alamat: '',
              imageUrl: ''),
        );
        notifyListeners();
      } else {
        throw Exception('Failed to add data');
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> getDataAkun() async {
    var url = Uri.parse(
      'https://menu-master-9c309-default-rtdb.firebaseio.com/akun.json',
    );
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as Map<String, dynamic>;
      _allakun.clear();
      data.forEach((key, value) {
        _allakun.add(
          AkunModel(
            username: value['username'],
            status: value['status'],
            id: value['userId'],
            alamat: value['alamat'],
            imageUrl: value['imageUrl'],
          ),
        );
      });
      notifyListeners();
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<void> updateDataAkun(AkunModel akun) async {
    var url = Uri.parse(
      'https://menu-master-9c309-default-rtdb.firebaseio.com/akun/${akun.id}.json',
    );
    var response = await http.put(
      url,
      body: json.encode({
        'username': akun.username,
        'status': akun.status,
        'userId': akun.id,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update data');
    }
  }
}
