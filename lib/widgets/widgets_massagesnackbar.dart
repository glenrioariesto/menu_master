import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:menu_master/shared/constants.dart';

class MassageSnackBar extends StatelessWidget {
  const MassageSnackBar({Key? key, required this.msgError, required this.msg})
      : super(key: key);

  final String msgError;
  final String msg;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          height: 90,
          decoration: BoxDecoration(
              color: const Color(0xFFC72C41),
              border: Border.all(color: ColorPalette.secondaryColor),
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Row(
            children: [
              const SizedBox(
                width: 48,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      msg,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      msgError,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(
                20,
              ),
            ),
            child: SvgPicture.asset(
              "assets/icons/bubbles.svg",
              height: 48,
              width: 40,
              color: const Color(0xFF801336),
            ),
          ),
        ),
        Positioned(
          top: -20,
          left: 0,
          child: Stack(
            alignment: Alignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Future.delayed(const Duration(seconds: 0), () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  });
                },
                child: SvgPicture.asset(
                  "assets/icons/fail.svg",
                  height: 40,
                ),
              ),
              Positioned(
                top: 10,
                child: GestureDetector(
                  onTap: () {
                    Future.delayed(const Duration(seconds: 0), () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    });
                  },
                  child: SvgPicture.asset(
                    "assets/icons/close.svg",
                    height: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
