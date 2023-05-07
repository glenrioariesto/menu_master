import 'package:flutter/material.dart';
import 'package:menu_master/provider/cart.dart';
import 'package:menu_master/shared/constants.dart';

import 'package:provider/provider.dart';
import 'package:menu_master/provider/auth.dart';

import '../../cartview.dart';
import '../../login.dart';

class Displayprofile extends StatelessWidget {
  const Displayprofile({super.key});
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return Column(children: [
      //display
      Displayprof(
        title: 'Settings',
        icon: Icons.settings,
        onPress: () {},
      ),
      Displayprof(
        title: 'E-Wallet',
        icon: Icons.money,
        onPress: () {},
      ),
      ProfileCart(
        title: "Cart",
        icon: Icons.shopping_bag,
        onPress: () {
          Navigator.pushNamed(context, CartView.nameRoute);
        },
        value: cart.count.toString(),
      ),
      Displayprof(
        title: 'Information',
        icon: Icons.info_rounded,
        onPress: () {},
      ),
      Displayprof(
        title: 'Logout',
        icon: Icons.logout_outlined,
        textColor: ColorPalette.primaryColor,
        onPress: () {
          auth.logout();

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const Login(
                        title: "Menu Master",
                      )));
        },
        endIcon: false,
      )
    ]);
  }
}

class Displayprof extends StatelessWidget {
  const Displayprof({
    super.key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  });

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: ColorPalette.secondaryColor),
        child: Icon(icon),
      ),
      title: Text(title,
          style:
              Theme.of(context).textTheme.bodyLarge?.apply(color: textColor)),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100), color: Colors.grey),
              child: const Icon(Icons.change_circle_outlined))
          : null,
    );
  }
}

class ProfileCart extends StatelessWidget {
  const ProfileCart({
    super.key,
    required this.title,
    required this.icon,
    required this.onPress,
    required this.value,
    this.endIcon = true,
    this.textColor,
  });

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;
  final String value;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Stack(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: ColorPalette.secondaryColor),
            child: Icon(icon),
          ),
          Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorPalette.primaryColor),
                constraints: BoxConstraints(minWidth: 16, minHeight: 16),
                child: Text(
                  value,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
              )),
        ],
      ),
      title: Text(title,
          style:
              Theme.of(context).textTheme.bodyLarge?.apply(color: textColor)),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100), color: Colors.grey),
              child: const Icon(Icons.change_circle_outlined))
          : null,
    );
  }
}
