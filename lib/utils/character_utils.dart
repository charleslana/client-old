import '../data/images.dart';
import '../enums/gender_enum.dart';

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

String getCharacterPortrait(int id) {
  switch (id) {
    case 1:
      return character1Portrait;
    case 2:
      return character2Portrait;
    case 3:
      return character3Portrait;
    case 4:
      return character4Portrait;
    case 5:
      return character5Portrait;
    case 6:
      return character6Portrait;
    case 7:
      return character7Portrait;
    case 8:
      return character8Portrait;
    case 9:
      return character9Portrait;
    default:
      return character1Portrait;
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

String getGender(GenderEnum gender) {
  switch (gender) {
    case GenderEnum.male:
      return 'Masculino';
    case GenderEnum.female:
      return 'Feminino';
    default:
      return 'Masculino';
  }
}
