import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:menu_master/view/profile/picprofile.dart';
import 'package:menu_master/view/profile/editprofile.dart';
import 'package:menu_master/shared/constants.dart';

class displayprofile extends StatelessWidget {
  const displayprofile({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      //display
      displayprof(
        title: 'Settings',
        icon: Icons.settings,
        onPress: () {},
      ),
      displayprof(
        title: 'Saldo',
        icon: Icons.money,
        onPress: () {},
      ),
      displayprof(
        title: 'User Management',
        icon: Icons.chrome_reader_mode_outlined,
        onPress: () {},
      ),
      displayprof(
        title: 'Information',
        icon: Icons.info_rounded,
        onPress: () {},
      ),
      displayprof(
        title: 'Logout',
        icon: Icons.logout_outlined,
        textColor: ColorPalette.primaryColor,
        onPress: () {},
        endIcon: false,
      )
    ]);
  }
}

class displayprof extends StatelessWidget {
  const displayprof({
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
              Theme.of(context).textTheme.bodyText1?.apply(color: textColor)),
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
