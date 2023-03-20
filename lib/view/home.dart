import 'package:flutter/material.dart';
import 'package:menu_master/shared/constants.dart';
import 'package:menu_master/widgets/widgets_drawerhome.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  static const nameRoute = '/home';
  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
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
            SizedBox()
          ],
        ),
        titleTextStyle: const TextStyle(
          fontSize: 30,
          fontFamily: 'Climate Crisis',
        ),
      ),
      endDrawer: const DrawerHome(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Home Page',
            ),
          ],
        ),
      ),
    );
  }
}
