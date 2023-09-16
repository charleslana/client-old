enum AttributeEnum {
  strength,
  intelligence,
  dexterity,
  undefined,
}

extension AttributeExtension on AttributeEnum {
  String get label {
    switch (this) {
      case AttributeEnum.strength:
        return 'Força';
      case AttributeEnum.intelligence:
        return 'Inteligência';
      case AttributeEnum.dexterity:
        return 'Destreza';
      default:
        return '';
    }
  }
}
