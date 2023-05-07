import 'package:flutter/material.dart';
import 'package:menu_master/provider/cart.dart';
import 'package:menu_master/shared/constants.dart';
import 'package:provider/provider.dart';

import '../model/akunmodel.dart';
import '../provider/akunprovider.dart';
import '../provider/auth.dart';
import '../provider/products.dart';
import '../view/product/product_detail.dart';

class ProductGrid extends StatefulWidget {
  const ProductGrid({super.key});

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  @override
  void initState() {
    super.initState();
    Provider.of<Products>(context, listen: false).getAllProduct();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    final akunProv = Provider.of<AkunProvider>(context, listen: false);

    akunProv.getDataById(auth.userId.toString());
    AkunModel akun = akunProv.selectById(auth.userId.toString());

    final productProv = Provider.of<Products>(context);
    final allproduct = productProv.allProduct;

    final cart = Provider.of<Cart>(context, listen: false);
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: allproduct.length,
      itemBuilder: (ctx, i) => ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            // leading: IconButton(
            //   icon: const Icon(Icons.favorite_border_outlined),
            //   color: ColorPalette.secondaryColor,
            //   onPressed: () {},
            // ),
            title: Text(
              allproduct[i].title,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Successfully Added Product to Cart'),
                  duration: Duration(milliseconds: 500),
                ));

                final product = productProv.selectById(allproduct[i].id);

                cart.addCart(akun.id, product);
              },
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
