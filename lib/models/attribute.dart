import 'dart:convert';

import '../enums/attribute_enum.dart';

class Attribute {
  Attribute({
    required this.attribute,
    required this.point,
  });

  factory Attribute.fromMap(Map<String, dynamic> map) {
    return Attribute(
      attribute: AttributeEnum.values.byName(map['attribute']),
      point: map['point'] as int,
    );
  }

  factory Attribute.fromJson(String source) =>
      Attribute.fromMap(json.decode(source) as Map<String, dynamic>);

  final AttributeEnum attribute;
  final int point;

  Attribute copyWith({
    AttributeEnum? attribute,
    int? point,
  }) {
    return Attribute(
      attribute: attribute ?? this.attribute,
      point: point ?? this.point,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'attribute': attribute.name,
      'point': point,
    };
  }

  String toJson() => json.encode(toMap());
}
