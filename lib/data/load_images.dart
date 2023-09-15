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
    precacheImage(const AssetImage(character1Portrait), context),
    precacheImage(const AssetImage(character2Portrait), context),
    precacheImage(const AssetImage(character3Portrait), context),
    precacheImage(const AssetImage(character4Portrait), context),
    precacheImage(const AssetImage(character5Portrait), context),
    precacheImage(const AssetImage(character6Portrait), context),
    precacheImage(const AssetImage(character7Portrait), context),
    precacheImage(const AssetImage(character8Portrait), context),
    precacheImage(const AssetImage(character9Portrait), context),
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
    precacheImage(const AssetImage(bagIcon), context),
    precacheImage(const AssetImage(button4Bg), context),
    precacheImage(const AssetImage(button5Bg), context),
    precacheImage(const AssetImage(levelIcon2), context),
    precacheImage(const AssetImage(menuIcon), context),
    precacheImage(const AssetImage(pvpIcon), context),
    precacheImage(const AssetImage(questIcon), context),
    precacheImage(const AssetImage(rankIcon), context),
    precacheImage(const AssetImage(worldIcon), context),
    precacheImage(const AssetImage(goldIcon), context),
    precacheImage(const AssetImage(diamondIcon), context),
  ]);
}
