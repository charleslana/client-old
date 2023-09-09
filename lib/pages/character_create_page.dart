import 'package:flutter/material.dart';

import '../data/images.dart';

class CharacterCreatePage extends StatefulWidget {
  const CharacterCreatePage({super.key});

  @override
  State<CharacterCreatePage> createState() => _CharacterCreatePageState();
}

class _CharacterCreatePageState extends State<CharacterCreatePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(characterCreateBg),
              alignment: Alignment.bottomCenter,
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.all(20),
        ),
      ),
    );
  }
}
