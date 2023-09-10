import 'package:flutter/material.dart';

import '../data/images.dart';

class Button2Widget extends StatelessWidget {
  const Button2Widget({
    Key? key,
    required this.text,
    required this.callback,
  }) : super(key: key);

  final String text;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final buttonWidth = screenWidth * 0.3;
    final buttonHeight = screenHeight * 0.08;

    return InkWell(
      onTap: callback,
      child: Container(
        width: buttonWidth,
        height: buttonHeight,
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11),
          image: const DecorationImage(
            image: AssetImage(button2Bg),
            fit: BoxFit.contain,
          ),
        ),
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
