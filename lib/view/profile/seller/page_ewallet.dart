import 'package:flutter/material.dart';
import 'package:menu_master/provider/payment.dart';
import 'package:provider/provider.dart';

import '../../../shared/constants.dart';

class EwalletView extends StatefulWidget {
  const EwalletView({super.key});

  @override
  State<EwalletView> createState() => _EwalletViewState();
}

class _EwalletViewState extends State<EwalletView> {
  @override
  Widget build(BuildContext context) {
    final Payment payment = Provider.of<Payment>(context);
    payment.getHistoryPayment();

    return Scaffold(
      appBar: AppBar(
          backgroundColor: ColorPalette.primaryColor,
          title: const Text(
            "seller balance",
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
      body: Container(
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
            borderRadius: BorderRadius.all(Radius.circular(12))),
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
                Text('Balance',
                    style: TextStyle(
                      color: Colors.blue[900],
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Rp. " + 0.toString(),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                      color: Color.fromARGB(255, 187, 179, 179), fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
