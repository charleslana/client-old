import '../data/images.dart';

String getCharacterImage(int id) {
  switch (id) {
    case 1:
      return character1Bg;
    case 2:
      return character2Bg;
    case 3:
      return character3Bg;
    case 4:
      return character4Bg;
    case 5:
      return character5Bg;
    case 6:
      return character6Bg;
    case 7:
      return character7Bg;
    case 8:
      return character8Bg;
    case 9:
      return character9Bg;
    default:
      return character1Bg;
  }
}

String getCharacterClassImage(int id) {
  switch (id) {
    case 1:
      return class1;
    case 2:
      return class2;
    case 3:
      return class3;
    case 4:
      return class4;
    case 5:
      return class5;
    case 6:
      return class6;
    case 7:
      return class7;
    case 8:
      return class8;
    case 9:
      return class9;
    default:
      return class1;
  }
}
