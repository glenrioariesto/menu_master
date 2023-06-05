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
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final auth = Provider.of<Auth>(context, listen: false);
    final akunProv = Provider.of<AkunProvider>(context, listen: false);

    await akunProv.getDataById(auth.userId.toString());
    AkunModel akun = akunProv.selectById(auth.userId.toString());

    final productProv = Provider.of<Products>(context, listen: false);

    if (akun.status == "Customer") {
      await productProv.getAllProduct();
    } else if (akun.status == "Seller") {
      await productProv.getAllProductById(auth.userId!);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final productProv = Provider.of<Products>(context);
    final allproduct = productProv.allProduct;
    final auth = Provider.of<Auth>(context, listen: false);
    final akunProv = Provider.of<AkunProvider>(context, listen: false);

    akunProv.getDataById(auth.userId.toString());
    AkunModel akun = akunProv.selectById(auth.userId.toString());

    final cart = Provider.of<Cart>(context, listen: false);

    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return allproduct.isEmpty
        ? Container(
            margin: EdgeInsets.fromLTRB(25, 150, 25, 0),
            child: Text(
              "empty products",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        : GridView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: allproduct.length,
            itemBuilder: (ctx, i) => ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: GridTile(
                footer: GridTileBar(
                  backgroundColor: Colors.black87,
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
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
          );
  }
}
