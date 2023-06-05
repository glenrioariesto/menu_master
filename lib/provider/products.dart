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
        orElse: () => Product(
            id: '',
            title: '',
            description: '',
            price: '',
            address: '',
            imageUrl: ''));
  }

  Future<void> addProduct(
      title, description, int qty, price, address, imageUrl, sellerId) async {
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

  Future<void> deleteProduct(String idproduct) async {
    var url = Uri.parse("$baseurl/product/$idproduct.json");

    try {
      await http.delete(url).then((response) {
        print(response);

        if (response.statusCode == 200) {
          _allproduct.removeWhere((item) => item.id == idproduct);
          notifyListeners();
          print('success delete product');
        } else {
          throw Exception('Failed to delete product');
        }
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateProduct(Product products, String title, String description,
      int qty, String price, String imageUrl) async {
    var id = products.id;
    var url = Uri.parse("$baseurl/product/$id.json");
    print("masuk update");
    try {
      await http
          .put(
        url,
        body: json.encode(
          {
            "address": products.address,
            "description": description,
            "imageUrl": imageUrl,
            "price": price,
            "qty": qty,
            "sellerId": products.idseller,
            "title": title,
          },
        ),
      )
          .then((response) {
        print(response.body);
        if (response.statusCode == 200) {
          // print('masuk response');
          final index = _allproduct.indexWhere((element) => element.id == id);
          // print(index);
          if (index >= 0) {
            // Jika produk sudah ada di dalam cart, maka tambahkan qtycart
            _allproduct[index].address = products.address;
            _allproduct[index].description = description;
            _allproduct[index].imageUrl = imageUrl;
            _allproduct[index].price = price;
            _allproduct[index].qtyseller = qty;
            _allproduct[index].idseller = products.idseller;
            _allproduct[index].title = title;
          }

          notifyListeners();
        } else {
          throw Exception('Failed to update data');
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
      // print(response.body);
      product.forEach((key, value) {
        _allproduct.add(Product(
            id: key,
            idseller: value["sellerId"],
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

  Future<void> getAllProductById(String id) async {
    var url = Uri.parse("$baseurl/product.json");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var product = json.decode(response.body) as Map<String, dynamic>;
      _allproduct.clear();
      // print(response.body);
      product.forEach((key, value) {
        if (value["sellerId"] == id) {
          _allproduct.add(Product(
              id: key,
              idseller: value["sellerId"],
              title: value["title"],
              description: value["description"],
              qtyseller: value["qty"],
              price: value["price"],
              address: value["address"],
              imageUrl: value["imageUrl"]));
        }
      });
      notifyListeners();
    }
  }

  Future<void> itemPaidoff(Product cart) async {
    var productId = cart.id;
    var url = Uri.parse("$baseurl/product/$productId.json");

    Product product = selectById(cart.id);

    try {
      var response = await http.put(url,
          body: json.encode({
            "sellerId": product.idseller,
            "title": cart.title,
            "description": cart.description,
            "qty": product.qtyseller - cart.qtycart,
            "price": cart.price,
            "address": cart.address,
            "imageUrl": cart.imageUrl,
          }));
      print(response.body);
      //     .then((response) {
      if (response.statusCode == 200) {
        print('success buy');
        // notifyListeners();
      } else {
        throw Exception('Failed to update data');
      }
      // });
    } catch (e) {
      rethrow;
    }
  }
}
