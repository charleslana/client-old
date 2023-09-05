import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/images.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Material(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(loginBg),
              alignment: Alignment.bottomCenter,
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Center(
              child: AnimatedTextKit(
                animatedTexts: [
                  FadeAnimatedText(
                    'Toque na tela para começar',
                    textStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                    fadeInEnd: 0.3,
                    fadeOutBegin: 0.4,
                  ),
                ],
                repeatForever: true,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
