import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart.dart';
import '../shared/constants.dart';
import '../view/payment/paymentview.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});
  static const nameRoute = '/cart';

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
        appBar: AppBar(
            title: const Text('Cart'),
            backgroundColor: ColorPalette.primaryColor,
            centerTitle: true),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                          padding: EdgeInsets.all(2),
                          margin:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    height: 60,
                                    child: Image.network(
                                      cart.items[index].imageUrl,
                                      fit: BoxFit.cover,
                                    )),
                                Container(
                                  height: 80,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        cart.items[index].title,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "Quantity : ${cart.items[index].qtycart}",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.topRight,
                                      height: 60,
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      child: Text(
                                        "Rp. ${cart.items[index].qtycart * int.parse(cart.items[index].price)} ",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            cart.deletecart(
                                                cart.items[index].idcustomer,
                                                cart.items[index].idcart);
                                          },
                                          child: Text(
                                            "Cancel",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          style: const ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      ColorPalette.otherColor)),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pushReplacementNamed(
                                              PaymentView.nameRoute,
                                              arguments: cart.items[index],
                                            );
                                            print(DateTime.now());
                                          },
                                          child: Text(
                                            "Buy",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          style: const ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      ColorPalette
                                                          .secondaryColor)),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )),
                      Divider(
                        color: Colors.grey[400],
                        thickness: 1,
                        indent: 16,
                        endIndent: 16,
                      ),
                    ],
                  );
                },
              ),
            ),
            Card(
              margin: EdgeInsets.all(10),
              child: Container(
                padding: EdgeInsets.all(15),
                child: Text('Total : ${cart.total}'),
              ),
            ),
          ],
        ));
  }
}
