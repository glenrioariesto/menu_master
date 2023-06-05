import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menu_master/view/homeseller.dart';
import 'package:menu_master/view/profile/seller/managementseller/page_addproduct.dart';
import 'package:menu_master/view/profile/seller/managementseller/page_deleteproduct.dart';
import 'package:menu_master/view/profile/seller/managementseller/page_updateproduct.dart';

import 'package:provider/provider.dart';
import '../../../../shared/constants.dart';

import '../../../../model/akunmodel.dart';

import '../../../../provider/auth.dart';
import '../../../../provider/products.dart';
import '../../../../provider/akunprovider.dart';
import '../../../../widgets/widgets_massagesnackbar.dart';

class SellerManagement extends StatefulWidget {
  const SellerManagement({super.key});

  @override
  State<SellerManagement> createState() => _SellerManagementState();
}

class _SellerManagementState extends State<SellerManagement> {
  List<Map<String, dynamic>> gridItems = [
    {
      'title': "Add Product",
      'icon': Icons.add,
    },
    {
      'title': "Delete Product",
      'icon': Icons.delete,
    },
    {
      'title': "Update Product",
      'icon': Icons.system_update,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.primaryColor,
        title: const Text(
          "Management Product",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: gridItems.length,
        itemBuilder: (ctx, i) => ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: GridTile(
            footer: GridTileBar(
              title: Text(
                gridItems[i]['title'],
                textAlign: TextAlign.center,
              ),
            ),
            child: GestureDetector(
              onTap: () {
                if (i == 0) {
                  // add Product

                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ManagementAddProduct(),
                  ));
                } else if (i == 1) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ManagementDeleteProduct(),
                  ));

                  // Delete Product
                } else if (i == 2) {
                  // Update Product
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ManagementUpdateProduct(),
                  ));
                }
              },
              child: Container(
                padding: EdgeInsets.all(5),
                color: Colors.red[700],
                child: Icon(
                  gridItems[i]['icon'],
                  size: 50,
                  color: Colors.white,
                ),
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
      ),
    );
  }
}
