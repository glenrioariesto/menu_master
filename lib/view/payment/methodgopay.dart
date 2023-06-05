import 'dart:async';

import 'package:flutter/material.dart';

import '../../model/payment/paymentmodel.dart';
import '../../model/product.dart';
import '../../shared/constants.dart';
import '../../view/payment/statuspayment.dart';

class methodgopay extends StatelessWidget {
  const methodgopay({
    super.key,
    required this.transaction,
    required this.arguments,
    required Timer? timer,
  }) : _timer = timer;

  final Transaction transaction;
  final Product arguments;
  final Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.fromLTRB(12, 60, 12, 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Gopay",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Image.network(
                  'https://gopay.co.id/icon.png',
                  height: 50,
                  width: 50,
                )
              ],
            ),
            SizedBox(height: 15),
            Center(
              child: Image.network(
                transaction.actions![0]['url'],
                height: 300,
                width: 300,
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StatusPayment(
                            transaction: transaction,
                            product: arguments,
                            run_url: true),
                      ));
                  _timer?.cancel();
                },
                child:
                    Text('Pay via App', style: TextStyle(color: Colors.black)),
                style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(fontSize: 18), // ubah ukuran teks
                    minimumSize: Size(300, 70), // ubah ukuran minimum tombol
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    backgroundColor: Colors.blue[600]),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StatusPayment(
                            transaction: transaction,
                            product: arguments,
                            run_url: false),
                      ));
                  _timer?.cancel();
                },
                child: Text('Back to merchant',
                    style: TextStyle(color: Colors.black)),
                style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(fontSize: 18), // ubah ukuran teks
                    minimumSize: Size(300, 70), // ubah ukuran minimum tombol
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    backgroundColor: ColorPalette.secondaryColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
