import 'package:flutter/material.dart';

class CustomShaderMask extends StatelessWidget {
  const CustomShaderMask({
    Key? key,
    required this.image,
    this.fit = BoxFit.contain,
  }) : super(key: key);

  final String image;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black,
            Colors.black,
            Colors.black,
            Colors.black.withOpacity(0.8),
            Colors.transparent
          ],
        ).createShader(
          Rect.fromLTRB(
            0,
            0,
            rect.width,
            rect.height,
          ),
        );
      },
      blendMode: BlendMode.dstIn,
      child: Image.asset(
        image,
        fit: fit,
      ),
    );
  }
}
