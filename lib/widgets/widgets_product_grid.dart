import 'package:flutter/material.dart';
import 'package:menu_master/shared/constants.dart';
import 'package:provider/provider.dart';

import '../provider/products.dart';
import '../view/product/product_detail.dart';

class ProductGrid extends StatefulWidget {
  const ProductGrid({super.key});

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  void initState() {
    super.initState();
    Provider.of<Products>(context, listen: false).getAllProduct();
  }

  @override
  Widget build(BuildContext context) {
    final productProv = Provider.of<Products>(context);
    final allproduct = productProv.allProduct;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: allproduct.length,
      itemBuilder: (ctx, i) => ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: IconButton(
              icon: const Icon(Icons.favorite_border_outlined),
              color: ColorPalette.secondaryColor,
              onPressed: () {},
            ),
            title: Text(
              allproduct[i].title,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {},
              color: ColorPalette.secondaryColor,
            ),
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                ProductDetailView.nameRoute,
                arguments: allproduct[i].id,
              );
            },
            child: Image.network(
              allproduct[i].imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      // ProductItem(
      //   allproduct[i].id,
      //   allproduct[i].title,
      //   allproduct[i].imageUrl,
      // )

      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
