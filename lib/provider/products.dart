import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/product.dart';

class Products with ChangeNotifier {
  final List<Product> _allproduct = [];
  List<Product> get allProduct => _allproduct;

  String baseurl = "https://menu-master-9c309-default-rtdb.firebaseio.com";

  Product selectById(String id) {
    return _allproduct.firstWhere((element) => element.id == id,
        orElse: () => null as Product);
  }

  Future<void> addProduct(
      title, description, qty, price, address, imageUrl, sellerId) async {
    var url = Uri.parse("$baseurl/product.json");
    try {
      await http
          .post(
        url,
        body: json.encode(
          {
            "sellerId": sellerId,
            "title": title,
            "description": description,
            "qty": qty,
            "price": price,
            "address": address,
            "imageUrl": imageUrl
          },
        ),
      )
          .then((response) {
        print(response.body);
        if (response.statusCode == 200) {
          var id = json.decode(response.body);
          _allproduct.add(Product(
              idseller: sellerId,
              id: id["name"],
              title: title,
              description: description,
              qtyseller: qty,
              price: price,
              address: address,
              imageUrl: imageUrl));

          notifyListeners();
        } else {
          throw Exception('Failed to add data');
        }
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getAllProduct() async {
    var url = Uri.parse("$baseurl/product.json");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var product = json.decode(response.body) as Map<String, dynamic>;
      _allproduct.clear();
      product.forEach((key, value) {
        _allproduct.add(Product(
            id: key,
            title: value["title"],
            description: value["description"],
            qtyseller: value["qty"],
            price: value["price"],
            address: value["address"],
            imageUrl: value["imageUrl"]));
      });
      notifyListeners();
    }
  }
  // Future<void> getDataAkun() async {
  //   var url = Uri.parse("$urlmenumaster/akun.json");
  //   var response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     var data = json.decode(response.body) as Map<String, dynamic>;
  //     _allakun.clear();
  //     data.forEach((key, value) {
  //       _allakun.add(
  //         AkunModel(
  //           username: value['username'],
  //           status: value['status'],
  //           id: data["name"],
  //           address: value['address'],
  //           imageUrl: value['imageUrl'],
  //         ),
  //       );
  //     });
  //     notifyListeners();
  //   } else {
  //     throw Exception('Failed to fetch data');
  //   }
  // }
}
