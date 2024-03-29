import 'package:flutter/material.dart';
import 'package:menu_master/shared/constants.dart';

class BadgeCart extends StatelessWidget {
  const BadgeCart({
    super.key,
    required this.child,
    required this.value,
    this.color = ColorPalette.secondaryColor,
  });

  final Widget child;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          right: 0,
          top: 7,
          child: Container(
            padding: EdgeInsets.all(2.0),
            // color: Theme.of(context).accentColor,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: color != null ? color : Theme.of(context).accentColor,
            ),
            constraints: BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: Colors.black,
              ),
            ),
          ),
        )
      ],
    );
  }
}
