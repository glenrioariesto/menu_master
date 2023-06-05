import 'package:flutter/material.dart';
import 'package:menu_master/provider/cart.dart';
import 'package:menu_master/shared/constants.dart';
import 'package:provider/provider.dart';

import '../../../../model/akunmodel.dart';
import '../../../../provider/akunprovider.dart';
import '../../../../provider/auth.dart';
import '../../../../provider/products.dart';

class ManagementDeleteProduct extends StatefulWidget {
  const ManagementDeleteProduct({super.key});

  @override
  State<ManagementDeleteProduct> createState() =>
      _ManagementDeleteProductState();
}

class _ManagementDeleteProductState extends State<ManagementDeleteProduct> {
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

    await productProv.getAllProductById(auth.userId!);

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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.primaryColor,
        title: const Text(
          "Delete Product",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : allproduct.isEmpty
              ? Center(
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
                        backgroundColor: Colors.red[700],
                        title: Text(
                          allproduct[i].title,
                          textAlign: TextAlign.center,
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete,
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text('The product was successfully removed'),
                              duration: Duration(milliseconds: 500),
                            ));

                            final product =
                                productProv.selectById(allproduct[i].id);

                            productProv.deleteProduct(product.id);
                          },
                          color: Colors.white,
                        ),
                      ),
                      child: Image.network(
                        allproduct[i].imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                ),
    );
  }
}
