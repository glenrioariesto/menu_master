import 'package:flutter/material.dart';
import 'package:menu_master/shared/constants.dart';
import 'package:menu_master/view/profile/seller/page_ewallet.dart';
import 'package:menu_master/view/profile/seller/settingseller.dart';

import 'package:provider/provider.dart';
import '../../../provider/auth.dart';

import '../../profile/seller/managementseller/seller_management.dart';
import '../../../view/login.dart';

class Displayprofile extends StatelessWidget {
  const Displayprofile({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);

    return Column(children: [
      //display
      Displayprof(
        title: 'Settings',
        icon: Icons.settings,
        onPress: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const SettingSeller()));
        },
      ),
      Displayprof(
        title: 'E-Wallet',
        icon: Icons.money,
        onPress: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EwalletView(),
          ));
        },
      ),

      Displayprof(
        title: 'Management Product',
        icon: Icons.chrome_reader_mode_outlined,
        onPress: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const SellerManagement()));
        },
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
