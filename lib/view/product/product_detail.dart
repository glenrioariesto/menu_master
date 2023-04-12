import 'package:flutter/material.dart';
import 'package:menu_master/shared/constants.dart';
import 'package:provider/provider.dart';

import '../../provider/products.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        backgroundColor: ColorPalette.primaryColor,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(
                border: Border.all(width: 8.0, color: ColorPalette.otherColor),
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
                  "\$${product.price}",
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
        ],
      ),
    );
  }
}
