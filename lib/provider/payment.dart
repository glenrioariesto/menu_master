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
    print(userid);
    var urlmidtrans = Uri.parse(baseurlmidtrans);
    var urlfirebase = Uri.parse("$baseurlfirebase/payment/$userid.json");
    int pricemidtrans = int.parse(price);
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization':
          'Basic ${base64Encode(utf8.encode('SB-Mid-server-tUvjOpGgOAPZpMeqpAuJM8ns:'))}'
    };
    // print("masuk");
    try {
      final response = await http.post(
        urlmidtrans,
        headers: headers,
        body: json.encode({
          "payment_type": "gopay",
          "transaction_details": {
            "gross_amount": pricemidtrans * qty,
            "order_id": orderid
          },
          "gopay": {
            "enable_callback": true,
            "callback_url": "https://gopay.co.id/icon.png"
          },
          "item_details": [
            {
              "id": productid,
              "price": pricemidtrans * qty,
              "quantity": 1,
              "name": title
            },
          ]
        }),
      );
      final responseBody = jsonDecode(response.body);
      print(responseBody);

      if (response.statusCode == 200) {
        var response_firbase = await http.post(urlfirebase,
            body: json.encode({
              "productid": productid,
              "order_id": orderid,
              "url_pay": responseBody['actions'][1]['url'],
              "expiry_time": responseBody["expiry_time"],
              "generate-qr-code": responseBody['actions'][0]['url']
            }));

        print(response_firbase.statusCode);
      }

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
      'Authorization':
          'Basic ${base64Encode(utf8.encode('SB-Mid-server-tUvjOpGgOAPZpMeqpAuJM8ns:'))}'
    };
    final response = await http.get(url, headers: headers);
    try {
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        // print(data);
        return data;
      } else {
        throw "get data failed";
      }
    } catch (e) {
      print("Error occurred: $e");
      return {}; // or you can throw the error again to be handled by the caller
    }
  }

  Future<void> getHistoryPayment(String productid) async {
    var url = Uri.parse("$baseurlfirebase/payment.json");
    var response = await http.get(url);
    // print("masuk");
    if (response.statusCode == 200) {
      var product = json.decode(response.body) as Map<String, dynamic>;
      // print(response.body);
      _wallet.clear();
      product.forEach((key, value) {
        // print(key); // Mengambil kunci dari objek (idCustomer)
        // print(value); // Mengambil nilai dari objek (objek)

        // Jika value juga merupakan objek, Anda dapat mengambil kunci di dalamnya dengan cara yang sama
        if (value is Map<String, dynamic>) {
          value.forEach((nestedKey, nestedValue) {
            if (nestedValue['productid'] == productid) {
              // print(
              //     nestedKey); // Mengambil kunci dari objek dalam objek (idpayment)
              // print(
              //     nestedValue); // Mengambil nilai dari objek dalam objek (objek)
              _wallet.add(nestedValue);
            }
          });
        }
      });
      notifyListeners();
    }
  }
  // _wallet.add(product);

  Future<Map<String, dynamic>> createTransactiongVABCA(String title, int qty,
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
    // print("masuk");
    try {
      final response = await http.post(
        urlmidtrans,
        headers: headers,
        body: json.encode({
          "payment_type": "bank_transfer",
          "transaction_details": {
            "gross_amount": pricemidtrans * qty,
            "order_id": orderid
          },
          "item_details": [
            {
              "id": productid,
              "price": pricemidtrans * qty,
              "quantity": 1,
              "name": title
            }
          ],
          "bank_transfer": {"bank": "bca", "va_number": "12345678901"},
        }),
      );
      final responseBody = jsonDecode(response.body);
      print(responseBody);

      if (response.statusCode == 200) {
        var response_firbase = await http.post(urlfirebase,
            body: json.encode({
              "productid": productid,
              "order_id": orderid,
              "url_pay": "",
              "expiry_time": responseBody["expiry_time"],
              "generate-qr-code": ""
            }));

        print(response_firbase.statusCode);
      }

      return responseBody;
    } catch (e) {
      print("Error occurred: $e");
      return {}; // or you can throw the error again to be handled by the caller
    }
  }

  Future<Map<String, dynamic>> createTransactiongVAMandiri(
      String title,
      int qty,
      String orderid,
      String price,
      String userid,
      String productid) async {
    var urlmidtrans = Uri.parse(baseurlmidtrans);
    var urlfirebase = Uri.parse("$baseurlfirebase/payment/$userid.json");
    int pricemidtrans = int.parse(price);
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization':
          'Basic ${base64Encode(utf8.encode('SB-Mid-server-tUvjOpGgOAPZpMeqpAuJM8ns:'))}'
    };
    // print("masuk");
    try {
      final response = await http.post(
        urlmidtrans,
        headers: headers,
        body: json.encode({
          "payment_type": "echannel",
          "transaction_details": {
            "gross_amount": pricemidtrans * qty,
            "order_id": orderid
          },
          "item_details": [
            {
              "id": productid,
              "price": pricemidtrans * qty,
              "quantity": 1,
              "name": title
            }
          ],
          "echannel": {"bill_info1": "Payment For:", "bill_info2": "Food"},
        }),
      );
      final responseBody = jsonDecode(response.body);
      print(responseBody);

      if (response.statusCode == 200) {
        var response_firbase = await http.post(urlfirebase,
            body: json.encode({
              "productid": productid,
              "order_id": orderid,
              "url_pay": "",
              "expiry_time": responseBody["expiry_time"],
              "generate-qr-code": ""
            }));

        print(response_firbase.statusCode);
      }

      return responseBody;
    } catch (e) {
      print("Error occurred: $e");
      return {}; // or you can throw the error again to be handled by the caller
    }
  }

  /*====================================BALANCE========================================== */
}
