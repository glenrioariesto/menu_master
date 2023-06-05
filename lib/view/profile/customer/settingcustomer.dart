import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import '../../../model/setting.dart';
import '../../../shared/constants.dart';

import '../../../model/akunmodel.dart';

import '../../../provider/auth.dart';
import '../../../provider/products.dart';
import '../../../provider/akunprovider.dart';
import '../../../widgets/widgets_massagesnackbar.dart';
import '../../../view/homeseller.dart';

class SettingCustomer extends StatefulWidget {
  const SettingCustomer({super.key});

  @override
  State<SettingCustomer> createState() => _SettingCustomerState();
}

class _SettingCustomerState extends State<SettingCustomer> {
  bool isOnOff = true;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0)).then((value) {
      var setting = Provider.of<ThemeNotifier>(context, listen: false);

      if (setting.currentTheme == ThemeType.dark) {
        isOnOff = false;
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var setting = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: ColorPalette.primaryColor,
          title: const Text(
            "Setting",
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Mode ",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            ElevatedButton(
              autofocus: true,
              onPressed: () {
                if (isOnOff == true) {
                  isOnOff = false;
                  setting.setTheme(ThemeType.dark);
                } else {
                  isOnOff = true;
                  setting.setTheme(ThemeType.light);
                }
                setState(() {});
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(isOnOff
                    ? ColorPalette.primaryColor
                    : ColorPalette.secondaryColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              child: const Text('ON', style: TextStyle(color: Colors.black)),
            ),
            ElevatedButton(
              autofocus: true,
              onPressed: () {
                if (isOnOff == false) {
                  isOnOff = true;
                  setting.setTheme(ThemeType.light);
                } else {
                  isOnOff = false;
                  setting.setTheme(ThemeType.dark);
                }
                setState(() {});
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(isOnOff
                    ? ColorPalette.secondaryColor
                    : ColorPalette.primaryColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              child: const Text('OFF', style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}
