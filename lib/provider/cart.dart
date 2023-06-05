import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:menu_master/model/product.dart';
import 'package:http/http.dart' as http;

class Cart with ChangeNotifier {
  final List<Product> _items = [];

  List<Product> get items => _items;
  String baseurl = "https://menu-master-9c309-default-rtdb.firebaseio.com";
  int get count {
    return _items.length;
  }

  Product selectById(String id) {
    return _items.firstWhere((element) => element.id == id,
        orElse: () => Product(
            id: '',
            title: '',
            description: '',
            price: '',
            address: '',
            imageUrl: ''));
  }

  int get total {
    var total = 0;
    for (var element in _items) {
      total += element.qtycart * int.parse(element.price);
    }
    return total;
  }

  Future<void> addCart(String idUser, Product product) async {
    bool isProductInList(String idproduct) {
      // print('pengecekan idproduct');
      // print(_items);
      // print('done check product');
      return _items.any((product) => product.id == idproduct);
    }

    var urladd = Uri.parse("$baseurl/cart/$idUser.json");

    if (isProductInList(product.id) == true) {
      Product cart = selectById(product.id);
      String idcart = cart.idcart;
      var urlupdate = Uri.parse("$baseurl/cart/$idUser/$idcart.json");
      // ketika sudah ada product id
      // print(urlupdate);
      try {
        await http
            .put(urlupdate,
                body: json.encode({
                  "productid": product.id,
                  "title": product.title,
                  "description": product.description,
                  "price": product.price,
                  "qty": cart.qtycart + 1,
                  "address": product.address,
                  "imageUrl": product.imageUrl
                }))
            .then((response) {
          // print(response.body);
          if (response.statusCode == 200) {
            // print('masuk response');
            final index =
                _items.indexWhere((element) => element.id == product.id);
            // print(index);
            if (index >= 0) {
              // Jika produk sudah ada di dalam cart, maka tambahkan qtycart
              _items[index].qtycart += 1;
            }

            notifyListeners();
          } else {
            throw Exception('Failed to update data');
          }
        });
      } catch (e) {
        rethrow;
      }
    } else {
      //menambahkan product id baru

      try {
        await http
            .post(urladd,
                body: json.encode({
                  "productid": product.id,
                  "title": product.title,
                  "description": product.description,
                  "price": product.price,
                  "qty": 1,
                  "address": product.address,
                  "imageUrl": product.imageUrl,
                }))
            .then((response) {
          // print(response.body);
          if (response.statusCode == 200) {
            var id = json.decode(response.body);
            _items.add(Product(
              id: product.id,
              idcart: id["name"],
              title: product.title,
              description: product.description,
              qtycart: 1,
              price: product.price,
              address: product.address,
              imageUrl: product.imageUrl,
            ));

            notifyListeners();
            print('success add data');
          } else {
            throw Exception('Failed to add data');
          }
        });
      } catch (e) {
        rethrow;
      }
    }
  }

  Future<void> getAllCart(idUser) async {
    var url = Uri.parse("$baseurl/cart/$idUser.json");
    if (idUser != '') {
      var response = await http.get(url);
      // print('berhasil masuk getcart');
      if (response.statusCode == 200) {
        String responseBody = response.body;
        if (responseBody != 'null') {
          // print("berhasil cek responbody");

          var product = json.decode(response.body) as Map<String, dynamic>;

          _items.clear();

          product.forEach((key, value) {
            // print("get");
            // print(key);
            _items.add(Product(
              idcart: key,
              idcustomer: idUser,
              id: value["productid"],
              title: value["title"],
              description: value["description"],
              qtycart: value["qty"],
              price: value["price"],
              address: value["address"],
              imageUrl: value["imageUrl"],
            ));
          });
          print('success get data cart');
          // print(_items);
          notifyListeners();
        } else {
          print("Response body is null");
          _items.clear();
        }
      }
    }
  }

  Future<void> deletecart(String idUser, String idCart) async {
    var url = Uri.parse("$baseurl/cart/$idUser/$idCart.json");

    try {
      await http.delete(url).then((response) {
        if (response.statusCode == 200) {
          _items.removeWhere((item) => item.idcart == idCart);
          notifyListeners();
          print('success delete cart');
        } else {
          throw Exception('Failed to delete data');
        }
      });
    } catch (e) {
      rethrow;
    }
  }
}
