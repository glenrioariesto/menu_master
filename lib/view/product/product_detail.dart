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
            child: Image.network(
              "${product.imageUrl}",
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 30),
          Text(
            "${product.title}",
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15),
          Text(
            "\$${product.price}",
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          SizedBox(height: 15),
          Text(
            "${product.description}",
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}
