import 'package:client/data/images.dart';
import 'package:flutter/material.dart';

Future<void> loadImages(BuildContext context) async {
  await Future.wait([
    precacheImage(const AssetImage(landingBg), context),
    precacheImage(const AssetImage(loginBg), context),
    precacheImage(const AssetImage(loadingBg), context),
    precacheImage(const AssetImage(characterChoiceBg), context),
  ]);
}
