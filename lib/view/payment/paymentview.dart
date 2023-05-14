import 'dart:async';

import 'package:flutter/material.dart';
import 'package:menu_master/model/product.dart';
import 'package:menu_master/view/homecustomer.dart';
import 'package:provider/provider.dart';

import '../../model/payment/paymentmodel.dart';
import '../../provider/payment.dart';
import '../../shared/constants.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({
    super.key,
  });
  static const nameRoute = '/payment';

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  late String paymentmethod = '';
  late int _remainingTime;
  late String brcode = 'https://gopay.co.id/icon.png';

  late Timer _timer;
  String orderid = "Order" + DateTime.now().millisecondsSinceEpoch.toString();

  @override
  void initState() {
    super.initState();
    _remainingTime = 86400;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      updateTimer();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void updateTimer() {
    setState(() {
      _remainingTime--;
    });
    if (_remainingTime == 0) {
      _timer.cancel();
    }
  }

  String get timerText {
    int hours = (_remainingTime / 3600).floor();
    int minutes = ((_remainingTime % 3600) / 60).floor();
    int seconds = (_remainingTime % 60).floor();
    String hoursStr = (hours < 10) ? '0$hours' : hours.toString();
    String minutesStr = (minutes < 10) ? '0$minutes' : minutes.toString();
    String secondsStr = (seconds < 10) ? '0$seconds' : seconds.toString();
    return '$hoursStr:$minutesStr:$secondsStr';
  }

  @override
  Widget build(BuildContext context) {
    Transaction transaction;
    final Product arguments =
        ModalRoute.of(context)?.settings.arguments as Product;
    var total = int.parse(arguments.price) * arguments.qtycart;
    final wallet = Provider.of<Payment>(context);
    if (_remainingTime == 0) {
      Navigator.pushReplacementNamed(context, HomeCustomer.nameRoute);
    }
    final List<Map<String, dynamic>> paymentList = [
      // {
      //   'namaPayment': 'ShopeePay',
      //   'imageUrl': [
      //     'https://1.bp.blogspot.com/-n_jPjNl97nw/YIJ78WnloPI/AAAAAAAACks/xPjLQ2YpcXwyPf64C708UExQOrJitxHSgCNcBGAsYHQ/w1200-h630-p-k-no-nu/ShopeePay.png',
      //     'https://static.vecteezy.com/system/resources/previews/013/433/620/original/qris-application-icon-design-on-white-background-free-vector.jpg'
      //   ],
      // },
      {
        'namaPayment': 'Virtual Account',
        'imageUrl': [
          'https://cdn.freebiesupply.com/logos/thumbs/2x/bca-bank-central-asia-logo.png',
          'https://cdn.freebiesupply.com/logos/thumbs/2x/bank-mandiri-logo.png'
        ],
      },
      {
        'namaPayment': 'GoPay',
        'imageUrl': [
          'https://gopay.co.id/icon.png',
          'https://static.vecteezy.com/system/resources/previews/013/433/620/original/qris-application-icon-design-on-white-background-free-vector.jpg'
        ],
      },
      // {
      //   'namaPayment': 'QRIS',
      //   'imageUrl': [
      //     'https://static.vecteezy.com/system/resources/previews/013/433/620/original/qris-application-icon-design-on-white-background-free-vector.jpg'
      //   ],
      // },
    ];
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorPalette.primaryColor,
                ),
                child: Text(
                  "Menu Master",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: paymentmethod == 'GoPay'
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.fromLTRB(12, 60, 12, 20),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                  brcode,
                                  height: 300,
                                  width: 300,
                                ),
                              ),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, HomeCustomer.nameRoute);
                                  },
                                  child: Text('Back to merchant',
                                      style: TextStyle(color: Colors.black)),
                                  style: ElevatedButton.styleFrom(
                                      textStyle: TextStyle(
                                          fontSize: 18), // ubah ukuran teks
                                      minimumSize: Size(300,
                                          70), // ubah ukuran minimum tombol
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      backgroundColor:
                                          ColorPalette.secondaryColor),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.fromLTRB(12, 60, 12, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Select payment method1231",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Expanded(
                                child: ListView.builder(
                              itemCount: paymentList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      paymentList[index]["namaPayment"],
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    ListTile(
                                      onTap: () async {
                                        if (paymentList[index]["namaPayment"] ==
                                            'GoPay') {
                                          await wallet
                                              .createTransactiongGopay(
                                                  arguments.title,
                                                  arguments.qtycart,
                                                  orderid,
                                                  arguments.price,
                                                  arguments.idcustomer,
                                                  arguments.id)
                                              .then((value) async {
                                            transaction =
                                                Transaction.fromJson(value);
                                            brcode =
                                                transaction.actions[0]['url'];
                                            paymentmethod = paymentList[index]
                                                ["namaPayment"];
                                            print("ini Link qris " +
                                                transaction.actions[0]['url']);
                                            _remainingTime = 900;
                                          });
                                        } else if (paymentList[index]
                                                ["namaPayment"] ==
                                            'QRIS') {
                                          setState(() {
                                            paymentmethod = paymentList[index]
                                                ["namaPayment"];
                                          });
                                          print(paymentList[index]
                                              ['namaPayment']);
                                        }
                                      },
                                      leading: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          for (var imageUrl
                                              in paymentList[index]["imageUrl"])
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.09,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.1,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8)),
                                                  border: Border.all(
                                                      color: Colors.black26),
                                                ),
                                                child: Image.network(
                                                  imageUrl,
                                                  height: 50,
                                                  width: 50,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      trailing: Icon(Icons.arrow_forward_ios),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 16),
                                    ),
                                    Divider(
                                      color: Colors.grey[400],
                                      thickness: 1,
                                      indent: 16,
                                      endIndent: 16,
                                    ),
                                  ],
                                );
                              },
                            ))
                          ],
                        ),
                      ),
              ),
            ],
          ),
          Positioned(
            top: 65,
            left: 25,
            right: 25,
            child: Container(
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
              height: 100,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Total",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Choose Within : ",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(timerText,
                          style: TextStyle(
                            color: Colors.blue[900],
                            fontSize: 14,
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
                        "Rp." + total.toString(),
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
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
                        "Order ID #" + orderid.toString(),
                        style: TextStyle(
                            color: Color.fromARGB(255, 187, 179, 179),
                            fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
