import 'package:flutter/material.dart';
import 'package:menu_master/model/product.dart';
import 'package:menu_master/provider/payment.dart';
import 'package:provider/provider.dart';

import '../../../provider/products.dart';
import '../../../shared/constants.dart';

class EwalletView extends StatefulWidget {
  const EwalletView({super.key});

  @override
  State<EwalletView> createState() => _EwalletViewState();
}

class _EwalletViewState extends State<EwalletView> {
  bool isDataLoaded = false;
  num total = 0;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    final Payment payment = Provider.of<Payment>(context, listen: false);
    final Products product = Provider.of<Products>(context, listen: false);
    setState(() {
      isDataLoaded = false;
    });

    if (!isDataLoaded) {
      List<Future> futures = [];

      for (var p in product.allProduct) {
        String productId = p.id; // Mengambil ID produk
        futures.add(payment.getHistoryPayment(productId));
      }

      await Future.wait(futures); // Tunggu semua pemanggilan API selesai

      for (var i = 0; i < payment.wallet.length; i++) {
        String orderId = payment.wallet[i]['order_id'];
        await payment.getTransactionStatus(orderId).then((value) {
          if (value['transaction_status'] == "settlement") {
            setState(() {
              total +=
                  num.parse(value['gross_amount']); // Convert to numeric type
            });
          }
        });
      }

      setState(() {
        isDataLoaded = true;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.primaryColor,
        title: const Text(
          "seller balance",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: isDataLoaded
          ? Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              height: 110,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Menu Master",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        'Balance',
                        style: TextStyle(
                          color: Colors.blue[900],
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Rp. " + total.toString() + "0",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Income",
                        style: TextStyle(
                          color: Color.fromARGB(255, 187, 179, 179),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
