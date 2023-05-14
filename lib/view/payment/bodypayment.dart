import 'package:flutter/material.dart';
import 'package:menu_master/provider/payment.dart';
import 'package:provider/provider.dart';

class bodypayment extends StatelessWidget {
  const bodypayment({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ewallet = Provider.of<Payment>(context);
    final List<Map<String, dynamic>> paymentList = [
      // {
      //   'namaPayment': 'ShopeePay',
      //   'imageUrl': [
      //     'https://1.bp.blogspot.com/-n_jPjNl97nw/YIJ78WnloPI/AAAAAAAACks/xPjLQ2YpcXwyPf64C708UExQOrJitxHSgCNcBGAsYHQ/w1200-h630-p-k-no-nu/ShopeePay.png',
      //     'https://static.vecteezy.com/system/resources/previews/013/433/620/original/qris-application-icon-design-on-white-background-free-vector.jpg'
      //   ],
      // },
      // {
      //   'namaPayment': 'Virtual Account',
      //   'imageUrl': [
      //     'https://cdn.freebiesupply.com/logos/thumbs/2x/bca-bank-central-asia-logo.png',
      //     'https://cdn.freebiesupply.com/logos/thumbs/2x/bank-mandiri-logo.png'
      //   ],
      // },
      {
        'namaPayment': 'GoPay',
        'imageUrl': [
          'https://gopay.co.id/icon.png',
          'https://static.vecteezy.com/system/resources/previews/013/433/620/original/qris-application-icon-design-on-white-background-free-vector.jpg'
        ],
      },
      {
        'namaPayment': 'QRIS',
        'imageUrl': [
          'https://static.vecteezy.com/system/resources/previews/013/433/620/original/qris-application-icon-design-on-white-background-free-vector.jpg'
        ],
      },
    ];
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.fromLTRB(12, 60, 12, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                    onTap: () {
                      if (paymentList[index]["namaPayment"] == 'GoPay') {
                        print(paymentList[index]['namaPayment']);
                        print(1);
                      } else if (paymentList[index]["namaPayment"] == 'QRIS') {
                        print(paymentList[index]['namaPayment']);
                      }
                    },
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (var imageUrl in paymentList[index]["imageUrl"])
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.09,
                              width: MediaQuery.of(context).size.width * 0.1,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                border: Border.all(color: Colors.black26),
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
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 16),
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
    );
  }
}
