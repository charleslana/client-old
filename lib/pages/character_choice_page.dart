import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/images.dart';

class CharacterChoicePage extends ConsumerStatefulWidget {
  const CharacterChoicePage({super.key});

  @override
  ConsumerState<CharacterChoicePage> createState() =>
      _CharacterChoicePageState();
}

class _CharacterChoicePageState extends ConsumerState<CharacterChoicePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(characterChoiceBg),
              alignment: Alignment.bottomCenter,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
