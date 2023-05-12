import 'package:flutter/material.dart';
import 'package:menu_master/shared/constants.dart';
import 'package:provider/provider.dart';

import '../../model/akunmodel.dart';
import '../../provider/akunprovider.dart';
import '../../provider/auth.dart';
import '../../provider/cart.dart';
import '../../provider/products.dart';
import 'package:menu_master/widgets/widgets_badge.dart';

import '../cartview.dart';

class ProductDetailView extends StatefulWidget {
  const ProductDetailView({super.key});
  static const nameRoute = '/product-detail';
  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    final product = Provider.of<Products>(context).selectById(productId);
    final cartProv = Provider.of<Cart>(context, listen: false);

    final auth = Provider.of<Auth>(context, listen: false);
    final akunProv = Provider.of<AkunProvider>(context, listen: false);

    akunProv.getDataById(auth.userId.toString());
    AkunModel akun = akunProv.selectById(auth.userId.toString());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        backgroundColor: ColorPalette.primaryColor,
        actions: [
          BadgeCart(
              child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, CartView.nameRoute);
                  },
                  icon: Icon(Icons.shopping_bag)),
              value: cartProv.count.toString())
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                  border:
                      Border.all(width: 8.0, color: ColorPalette.otherColor),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(18),
                      bottomRight: Radius.circular(18))),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Rp. ${product.price}",
                    style: const TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: ColorPalette.backgroundColor,
              ),
              height: 200,
              width: 450,
              child: Text(
                product.description,
                style: const TextStyle(
                  fontSize: 24,
                ),
                maxLines: 5,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            OutlinedButton(
              onPressed: () async {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Successfully Added Product to Cart'),
                  duration: Duration(milliseconds: 500),
                ));
                await cartProv.addCart(akun.id, product);
                await Navigator.of(context).pushReplacementNamed(
                    ProductDetailView.nameRoute,
                    arguments: product.id);
              },
              child: Text('Add to cart'),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
