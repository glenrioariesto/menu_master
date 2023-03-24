import 'package:flutter/material.dart';

class Picprofile extends StatelessWidget {
  const Picprofile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(
          bottom: 0, end: 0, start: 0, top: 25),
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        children: const [
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/profile_template.jpg"),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: SizedBox(
                height: 40,
                width: 40,
                child: Icon(
                  size: 40,
                  Icons.add_a_photo,
                )),
          ),
        ],
      ),
    );
  }
}
