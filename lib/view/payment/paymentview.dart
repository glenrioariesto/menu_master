import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menu_master/provider/auth.dart';
import 'package:provider/provider.dart';

import '../../model/payment/paymentmodel.dart';
import '../../provider/payment.dart';
import '../../shared/constants.dart';
import '../../model/product.dart';
import '../../view/homecustomer.dart';
import '../../view/payment/statuspayment.dart';
import '../../view/payment/methodgopay.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({
    super.key,
  });
  static const nameRoute = '/payment';

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  late Transaction transaction = Transaction(
      statusCode: '',
      statusMessage: '',
      transactionId: '',
      orderId: '',
      merchantId: '',
      grossAmount: '',
      currency: '',
      paymentType: '',
      transactionTime: DateTime.now(),
      transactionStatus: '',
      fraudStatus: '',
      actions: [],
      expiryTime: DateTime.now());
  late String paymentmethod = 'listpayment';
  late int _remainingTime;
  late Product arguments = Product(
      id: '', title: '', description: '', price: '', address: '', imageUrl: '');
  bool _isDisposed = false;

  late Timer? _timer;
  String orderid = "Order" + DateTime.now().millisecondsSinceEpoch.toString();

  Future<Map<String, dynamic>> _cekTransactionStatus(String Orderid) {
    return Future.delayed(const Duration(microseconds: 2250)).then(
      (_) async {
        try {
          Payment wallet = Provider.of<Payment>(context, listen: false);

          var status = await wallet.getTransactionStatus(Orderid);
          return status;
        } catch (e) {
          print("An Error occurred: ${e}");
          return {};
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _remainingTime = 86400;

    if (mounted) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
        if (mounted) {
          updateTimer();
          final auth = Provider.of<Auth>(context, listen: false);
          arguments.idcustomer = auth.userId.toString();

          await _cekTransactionStatus(orderid).then((value) {
            if (value != '') {
              transaction.transactionStatus = value['transaction_status'];
            }
          });
        } else {
          _timer?.cancel();
        }
        if (_remainingTime == 0 || transaction.transactionStatus != '') {
          if (transaction.transactionStatus == 'settlement') {
            Future.delayed(Duration(seconds: 0), () {
              if (mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StatusPayment(
                      transaction: transaction,
                      product: arguments,
                      run_url: false,
                    ),
                  ),
                );
                _timer?.cancel();
              } else {
                _timer?.cancel();
              }
            });
          } else if (_remainingTime == 0) {
            Future.delayed(Duration(seconds: 0), () {
              if (mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StatusPayment(
                      transaction: transaction,
                      product: arguments,
                      run_url: false,
                    ),
                  ),
                );
                _timer?.cancel();
              } else {
                _timer?.cancel();
              }
            });
          }
        } else {
          _timer?.cancel();
        }
      });
    }
  }

  @override
  void dispose() {
    _isDisposed = true;

    if (_timer != null && _timer!.isActive) {
      _timer?.cancel();
    }

    super.dispose();
  }

  void updateTimer() {
    if (!_isDisposed) {
      setState(() {
        _remainingTime--;
      });
      if (_remainingTime == 0) {
        _timer?.cancel();
      }
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
    arguments = ModalRoute.of(context)?.settings.arguments as Product;
    var total = int.parse(arguments.price) * arguments.qtycart;
    final wallet = Provider.of<Payment>(context, listen: false);

    final List<Map<String, dynamic>> paymentList = [
      {
        'namaPayment': 'Virtual Account',
        'imageUrl': [
          {
            "name": "BCA",
            "url":
                'https://cdn.freebiesupply.com/logos/thumbs/2x/bca-bank-central-asia-logo.png',
          },
          {
            "name": "MANDIRI",
            "url":
                'https://cdn.freebiesupply.com/logos/thumbs/2x/bank-mandiri-logo.png'
          }
        ],
      },
      {
        'namaPayment': 'GoPay',
        'imageUrl': [
          {
            "name": "Gopay",
            "url": 'https://gopay.co.id/icon.png',
          },
          {
            "name": "QRIS",
            "url":
                'https://static.vecteezy.com/system/resources/previews/013/433/620/original/qris-application-icon-design-on-white-background-free-vector.jpg'
          }
        ],
      },
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
                    ? methodgopay(
                        transaction: transaction,
                        arguments: arguments,
                        timer: _timer)
                    : paymentmethod == 'Virtual Account'
                        ? Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.all(8),
                            padding: EdgeInsets.fromLTRB(12, 50, 12, 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.arrow_back, size: 40),
                                  onPressed: () {
                                    paymentmethod = '';
                                  },
                                ),
                                SizedBox(height: 20),
                                Text(
                                  paymentList[0]["namaPayment"],
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Expanded(
                                    child: ListView.builder(
                                  itemCount: paymentList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ListTile(
                                          onTap: () async {
                                            if (paymentList[0]['imageUrl']
                                                    [index]['name'] ==
                                                "BCA") {
                                              await wallet
                                                  .createTransactiongVABCA(
                                                      arguments.title,
                                                      arguments.qtycart,
                                                      orderid,
                                                      arguments.price,
                                                      arguments.idcustomer,
                                                      arguments.id)
                                                  .then((value) async {
                                                print(value['va_numbers'][0]
                                                    ['va_number']);
                                                if (mounted) {
                                                  setState(() {
                                                    transaction =
                                                        Transaction.fromJsonVA(
                                                            value);
                                                  });
                                                } else {
                                                  _timer?.cancel();
                                                }
                                                paymentmethod = "BCA";

                                                _remainingTime = 86400;
                                              });
                                            } else if (paymentList[0]
                                                        ['imageUrl'][index]
                                                    ['name'] ==
                                                "MANDIRI") {
                                              await wallet
                                                  .createTransactiongVAMandiri(
                                                      arguments.title,
                                                      arguments.qtycart,
                                                      orderid,
                                                      arguments.price,
                                                      arguments.idcustomer,
                                                      arguments.id)
                                                  .then((value) async {
                                                if (mounted) {
                                                  setState(() {
                                                    transaction =
                                                        Transaction.fromJsonVA(
                                                            value);
                                                  });
                                                } else {
                                                  _timer?.cancel();
                                                }
                                                paymentmethod = "MANDIRI";

                                                _remainingTime = 86400;
                                              });
                                            }
                                          },
                                          leading: Image.network(
                                            paymentList[0]['imageUrl'][index]
                                                ['url'],
                                            height: 100,
                                            width: 100,
                                          ),
                                          trailing:
                                              Icon(Icons.arrow_forward_ios),
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
                          )
                        : paymentmethod == 'BCA'
                            ? Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.all(8),
                                padding: EdgeInsets.fromLTRB(12, 60, 12, 20),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "BCA",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Image.network(
                                            paymentList[0]['imageUrl'][0]
                                                ['url'],
                                            height: 50,
                                            width: 50,
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Center(
                                        child: Text(
                                            'Complete payment from BCA to the virtual account number below.',
                                            style: TextStyle(fontSize: 18)),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'Virtual Account Number',
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              '${transaction.vaNumbers.toString()}',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Clipboard.setData(ClipboardData(
                                                  text: transaction.vaNumbers
                                                      .toString()));
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                    content: Text(
                                                        'Text copied to clipboard')),
                                              );
                                            },
                                            child: Icon(Icons.content_copy),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 250,
                                      ),
                                      Center(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      StatusPayment(
                                                          transaction:
                                                              transaction,
                                                          product: arguments,
                                                          run_url: false),
                                                ));
                                            _timer?.cancel();
                                          },
                                          child: Text('Back to merchant',
                                              style: TextStyle(
                                                  color: Colors.black)),
                                          style: ElevatedButton.styleFrom(
                                              textStyle: TextStyle(
                                                  fontSize:
                                                      18), // ubah ukuran teks
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
                                ))
                            : paymentmethod == 'MANDIRI'
                                ? Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.all(8),
                                    padding:
                                        EdgeInsets.fromLTRB(12, 60, 12, 20),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "MANDIRI",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Image.network(
                                                paymentList[0]['imageUrl'][1]
                                                    ['url'],
                                                height: 100,
                                                width: 100,
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Center(
                                            child: Text(
                                                'Complete payment from Mandiri to the virtual account number below.',
                                                style: TextStyle(fontSize: 18)),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            'Company code',
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                          Text(
                                            '\t\t70012',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            'Virtual Account Number',
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  '\t\t${transaction.vaNumbers.toString()}',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Clipboard.setData(
                                                      ClipboardData(
                                                          text: transaction
                                                              .vaNumbers
                                                              .toString()));
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                        content: Text(
                                                            'Text copied to clipboard')),
                                                  );
                                                },
                                                child: Icon(Icons.content_copy),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 150,
                                          ),
                                          Center(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          StatusPayment(
                                                              transaction:
                                                                  transaction,
                                                              product:
                                                                  arguments,
                                                              run_url: false),
                                                    ));
                                                _timer?.cancel();
                                              },
                                              child: Text('Back to merchant',
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                              style: ElevatedButton.styleFrom(
                                                  textStyle: TextStyle(
                                                      fontSize:
                                                          18), // ubah ukuran teks
                                                  minimumSize: Size(300,
                                                      70), // ubah ukuran minimum tombol
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 10),
                                                  backgroundColor: ColorPalette
                                                      .secondaryColor),
                                            ),
                                          )
                                        ],
                                      ),
                                    ))
                                : Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.all(8),
                                    padding:
                                        EdgeInsets.fromLTRB(12, 60, 12, 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Select payment method",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        Expanded(
                                            child: ListView.builder(
                                          itemCount: paymentList.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  paymentList[index]
                                                      ["namaPayment"],
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                ListTile(
                                                  onTap: () async {
                                                    if (paymentList[index]
                                                            ["namaPayment"] ==
                                                        'GoPay') {
                                                      await wallet
                                                          .createTransactiongGopay(
                                                              arguments.title,
                                                              arguments.qtycart,
                                                              orderid,
                                                              arguments.price,
                                                              arguments
                                                                  .idcustomer,
                                                              arguments.id)
                                                          .then((value) async {
                                                        if (mounted) {
                                                          setState(() {
                                                            transaction =
                                                                Transaction
                                                                    .fromJsonGOPAY(
                                                                        value);
                                                          });
                                                        } else {
                                                          _timer?.cancel();
                                                        }

                                                        paymentmethod =
                                                            paymentList[index]
                                                                ["namaPayment"];
                                                        print("ini Link qris " +
                                                            transaction
                                                                    .actions![0]
                                                                ['url']);
                                                        _remainingTime = 900;
                                                      });
                                                    } else if (paymentList[
                                                                index]
                                                            ["namaPayment"] ==
                                                        'Virtual Account') {
                                                      if (mounted) {
                                                        setState(() {
                                                          paymentmethod =
                                                              paymentList[index]
                                                                  [
                                                                  "namaPayment"];
                                                        });
                                                      } else {
                                                        _timer?.cancel();
                                                      }
                                                      print(paymentList[index]
                                                          ['namaPayment']);
                                                    }
                                                  },
                                                  leading: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      for (var imageUrl
                                                          in paymentList[index]
                                                              ["imageUrl"])
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 8.0),
                                                          child: Container(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.09,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.1,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(Radius
                                                                          .circular(
                                                                              8)),
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .black26),
                                                            ),
                                                            child:
                                                                Image.network(
                                                              imageUrl['url'],
                                                              height: 50,
                                                              width: 50,
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                  trailing: Icon(
                                                      Icons.arrow_forward_ios),
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 10,
                                                          horizontal: 16),
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
