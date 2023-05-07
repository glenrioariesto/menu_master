import 'package:flutter/material.dart';
import 'package:menu_master/provider/cart.dart';
import 'package:menu_master/shared/constants.dart';
import 'package:provider/provider.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});
  static const nameRoute = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
        appBar: AppBar(
            title: Text('Cart'),
            backgroundColor: ColorPalette.primaryColor,
            centerTitle: true),
        body: Column(
          children: [
            Card(
              margin: EdgeInsets.all(10),
              child: Container(
                padding: EdgeInsets.all(15),
                child: Text('Total : ${cart.total}'),
              ),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: ListTile(
                    title: Text(cart.items[index].title),
                    subtitle: Text("Quantity : ${cart.items[index].qtycart}"),
                    trailing: Text(
                        "${cart.items[index].qtycart * int.parse(cart.items[index].price)} "),
                  ),
                );
              },
            ))
          ],
        ));
  }
}
