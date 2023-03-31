import 'package:flutter/material.dart';
import 'package:menu_master/shared/constants.dart';
import 'package:menu_master/view/profile/profile.dart';

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
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Profile()));
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
