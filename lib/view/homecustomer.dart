import 'package:flutter/material.dart';
import 'package:menu_master/shared/constants.dart';
import 'package:menu_master/view/profile/profilecustomer.dart';

import 'package:provider/provider.dart';
import '../model/akunmodel.dart';
import '../provider/akunprovider.dart';
import '../provider/auth.dart';
import '../provider/cart.dart';
import '../widgets/widgets_product_grid.dart';

class HomeCustomer extends StatefulWidget {
  const HomeCustomer({super.key, required this.title});

  static const nameRoute = '/homecustomer';
  final String title;

  @override
  State<HomeCustomer> createState() => _HomeCustomerState();
}

class _HomeCustomerState extends State<HomeCustomer> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    final akunProv = Provider.of<AkunProvider>(context, listen: false);

    akunProv.getDataById(auth.userId.toString());
    AkunModel akun = akunProv.selectById(auth.userId.toString());

    Provider.of<Cart>(context, listen: false).getAllCart(akun.id);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorPalette.primaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/logoMenuMaster.png',
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: const TextStyle(color: ColorPalette.textColorMM),
            ),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  auth.tempData();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Profilecustomer()));
                },
                icon: const Icon(Icons.person_2_outlined),
                label: const Text("Profile"),
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(ColorPalette.primaryColor)),
              ),
            )
          ],
        ),
        titleTextStyle: const TextStyle(
          fontSize: 30,
          fontFamily: 'Climate Crisis',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: ColorPalette.backgroundColor,
              height: 200,
              width: double.infinity,
              child: Text("carousel image", textAlign: TextAlign.center),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              child: ProductGrid(),
            ),
          ],
        ),
      ),
    );
  }
}
