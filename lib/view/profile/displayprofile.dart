import 'package:flutter/material.dart';
import 'package:menu_master/shared/constants.dart';

class Displayprofile extends StatelessWidget {
  const Displayprofile({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      //display
      Displayprof(
        title: 'Settings',
        icon: Icons.settings,
        onPress: () {},
      ),
      Displayprof(
        title: 'Saldo',
        icon: Icons.money,
        onPress: () {},
      ),
      Displayprof(
        title: 'User Management',
        icon: Icons.chrome_reader_mode_outlined,
        onPress: () {},
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
        onPress: () {},
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