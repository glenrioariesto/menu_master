import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Payment with ChangeNotifier {
  final List<Map<String, dynamic>> _wallet = [];
  List<Map<String, dynamic>> get wallet => _wallet;

  String baseurlmidtrans = "https://api.sandbox.midtrans.com/v2/charge";
  String baseurlfirebase =
      "https://menu-master-9c309-default-rtdb.firebaseio.com";

  Map<String, dynamic> selectById(String orderid) {
    return _wallet.firstWhere((element) => element['order_id'] == orderid,
        orElse: () => null as Map<String, dynamic>);
  }

  Future<Map<String, dynamic>> createTransactiongGopay(String title, int qty,
      String orderid, String price, String userid, String productid) async {
    var urlmidtrans = Uri.parse(baseurlmidtrans);
    var urlfirebase = Uri.parse("$baseurlfirebase/payment/$userid.json");
    int pricemidtrans = int.parse(price);
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization':
          'Basic ${base64Encode(utf8.encode('SB-Mid-server-tUvjOpGgOAPZpMeqpAuJM8ns:'))}'
    };
    print("masuk");
    try {
      final response = await http.post(
        urlmidtrans,
        headers: headers,
        body: json.encode(
            // {
            //   "payment_type": "gopay",
            //   "transaction_details": {"gross_amount": 20000, "order_id": orderid},
            //   "gopay": {
            //     "enable_callback": true,
            //     "callback_url": "https://gopay.co.id/icon.png"
            //   },
            //   "item_details": [
            //     {
            //       "id": productid,
            //       "price": "20000",
            //       "quantity": qty,
            //       "name": title
            //     },
            //   ],
            // },
            {
              "payment_type": "gopay",
              "transaction_details": {
                "gross_amount": pricemidtrans,
                "order_id": orderid
              },
              "gopay": {
                "enable_callback": true,
                "callback_url": "https://gopay.co.id/icon.png"
              },
              "item_details": [
                {
                  "id": productid,
                  "price": pricemidtrans,
                  "quantity": 1,
                  "name": title
                },
              ]
            }),
      );
      final responseBody = jsonDecode(response.body);
      // print(responseBody);

      return responseBody;
    } catch (e) {
      print("Error occurred: $e");
      return {}; // or you can throw the error again to be handled by the caller
    }
  }

  Future<Map<String, dynamic>> getTransactionStatus(orderid) async {
    final url =
        Uri.parse('https://api.sandbox.midtrans.com/v2/$orderid/status');

    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Basic SB-Mid-server-tUvjOpGgOAPZpMeqpAuJM8ns:'
    };
    final response = await http.get(url, headers: headers);
    try {
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        print(data);
        return data;
      } else {
        throw "ssd";
      }
    } catch (e) {
      print("Error occurred: $e");
      return {}; // or you can throw the error again to be handled by the caller
    }
  }

  Future<void> getHistoryPayment() async {
    var url = Uri.parse("$baseurlmidtrans/product.json");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var product = json.decode(response.body) as Map<String, dynamic>;
      _wallet.clear();
      product.forEach((key, value) {
        _wallet.add(product);
      });
      notifyListeners();
    }
  }
}
