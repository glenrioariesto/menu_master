import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/product.dart';
import '../../model/payment/paymentmodel.dart';
import '../../provider/cart.dart';
import '../../provider/payment.dart';
import '../../provider/products.dart';
import '../../view/homecustomer.dart';

class StatusPayment extends StatefulWidget {
  const StatusPayment(
      {super.key,
      required this.transaction,
      required this.run_url,
      required this.product});
  final Transaction transaction;
  final Product product;
  final bool run_url;

  @override
  State<StatusPayment> createState() => _StatusPaymentState();
}

class _StatusPaymentState extends State<StatusPayment> {
  late Transaction transaction = widget.transaction;
  late Uri url = Uri.parse(transaction.actions![1]['url']);
  late int _remainingTime;
  late Timer _timer;
  late bool run = widget.run_url;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _remainingTime = 10;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      if (mounted) {
        updateTimer();
        await _cekTransactionStatus(transaction.orderId!).then((value) {
          if (value != '') {
            if (_remainingTime != 0) {
              setState(() {
                transaction.transactionStatus = value['transaction_status'];
              });
            } else {
              _timer.cancel();
            }
          }
        });
      } else {
        _timer.cancel();
      }
      // print(transaction.transactionStatus);
      if (transaction.transactionStatus != '') {
        if (transaction.transactionStatus == 'pending' && run == true) {
          Future.delayed(Duration(seconds: 0), () async {
            await _launchUrl();
            _remainingTime = 60;

            run = false;
          });
        } else if (transaction.transactionStatus == 'pending' &&
            widget.run_url == false) {
          Future.delayed(Duration(seconds: _remainingTime), () {
            if (mounted) {
              Navigator.pushReplacementNamed(context, HomeCustomer.nameRoute);
              _timer.cancel();
            }
          });
        } else if (_remainingTime == 0) {
          Future.delayed(Duration(seconds: 0), () {
            if (mounted) {
              Navigator.pushReplacementNamed(context, HomeCustomer.nameRoute);

              _timer.cancel();
            }
          });
        }
      }
    });
  }

  void updateTimer() {
    if (mounted) {
      setState(() {
        _remainingTime--;
      });
      if (_remainingTime == 0) {
        _timer.cancel();
      }
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    if (_timer != null && _timer.isActive) {
      _timer.cancel();
    }
    super.dispose();
  }

  Future<void> _launchUrl() async {
    if (await canLaunchUrl(url)) {
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    }
  }

  Future<Map<String, dynamic>> _cekTransactionStatus(String Orderid) {
    return Future.delayed(const Duration(microseconds: 2250)).then(
      (_) async {
        try {
          Payment wallet = await Provider.of<Payment>(context, listen: false);
          return wallet.getTransactionStatus(Orderid);
        } catch (e) {
          print("An Error occurred: ${e}");
          return {};
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Container(
        margin: EdgeInsets.only(
          top: 150,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                  transaction.transactionStatus == "pending"
                      ? Icons.pending
                      : transaction.transactionStatus == "settlement"
                          ? Icons.check_circle
                          : Icons.timer_off_outlined,
                  color: Colors.grey,
                  size: 100),
              Container(
                margin: EdgeInsets.all(8),
                child: Text(
                  transaction.transactionStatus == "pending"
                      ? "Your transaction is being processed"
                      : transaction.transactionStatus == "settlement"
                          ? 'Payment Successful'
                          : 'expire',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Icon(
                Icons.minimize,
                color: Colors.grey,
                size: 50,
              ),
              Text(
                "Rp.${transaction.grossAmount}",
                style: TextStyle(fontSize: 30),
              ),
              Text(
                transaction.orderId!,
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                padding: EdgeInsets.all(8),
                height: MediaQuery.of(context).size.height * 0.3,
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                        transaction.transactionStatus == "settlement"
                            ? ''
                            : "Redirect back automatically in ${_remainingTime.toString()} seconds",
                        style: TextStyle(fontSize: 25),
                        textAlign: TextAlign.center),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      width: double.infinity, // Lebar button
                      height: MediaQuery.of(context).size.height *
                          0.1, // Tinggi button

                      child: ElevatedButton(
                        onPressed: () {
                          // Aksi ketika button ditekan
                          if (mounted) {
                            if (transaction.transactionStatus == 'settlement') {
                              Provider.of<Products>(context, listen: false)
                                  .itemPaidoff(widget.product);
                              Provider.of<Cart>(context, listen: false)
                                  .deletecart(widget.product.idcustomer,
                                      widget.product.idcart);
                            }
                          }
                          if (mounted) {
                            _timer.cancel();
                            Navigator.pushReplacementNamed(
                                context, HomeCustomer.nameRoute);
                          }
                        },
                        child: Text("Return to merchant's page",
                            style: TextStyle(fontSize: 20)),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.grey[900]),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
