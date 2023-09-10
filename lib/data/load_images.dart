import 'package:client/data/images.dart';
import 'package:flutter/material.dart';

Future<void> loadImages(BuildContext context) async {
  await Future.wait([
    precacheImage(const AssetImage(landingBg), context),
    precacheImage(const AssetImage(loginBg), context),
    precacheImage(const AssetImage(loadingBg), context),
    precacheImage(const AssetImage(characterChoiceBg), context),
    precacheImage(const AssetImage(characterCreateBg), context),
    precacheImage(const AssetImage(button1Bg), context),
    precacheImage(const AssetImage(selectCharacterBg), context),
    precacheImage(const AssetImage(plusWhiteIcon), context),
    precacheImage(const AssetImage(button2Bg), context),
    precacheImage(const AssetImage(button3Bg), context),
    precacheImage(const AssetImage(selectCharacterCreateBg), context),
    precacheImage(const AssetImage(character1Bg), context),
    precacheImage(const AssetImage(character2Bg), context),
    precacheImage(const AssetImage(character3Bg), context),
    precacheImage(const AssetImage(character4Bg), context),
    precacheImage(const AssetImage(character5Bg), context),
    precacheImage(const AssetImage(character6Bg), context),
    precacheImage(const AssetImage(character7Bg), context),
    precacheImage(const AssetImage(character8Bg), context),
    precacheImage(const AssetImage(character9Bg), context),
    precacheImage(const AssetImage(levelIcon), context),
    precacheImage(const AssetImage(class1), context),
    precacheImage(const AssetImage(class2), context),
    precacheImage(const AssetImage(class3), context),
    precacheImage(const AssetImage(class4), context),
    precacheImage(const AssetImage(class5), context),
    precacheImage(const AssetImage(class6), context),
    precacheImage(const AssetImage(class7), context),
    precacheImage(const AssetImage(class8), context),
    precacheImage(const AssetImage(class9), context),
  ]);
}
