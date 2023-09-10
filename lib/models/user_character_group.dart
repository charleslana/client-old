import 'dart:convert';

import '../enums/role_group_enum.dart';

class UserCharacterGroup {
  UserCharacterGroup({
    this.point,
    required this.role,
  });

  factory UserCharacterGroup.fromMap(Map<String, dynamic> map) {
    return UserCharacterGroup(
      point: map['point'] != null ? map['point'] as int : null,
      role: RoleGroupEnum.values.byName(map['role']),
    );
  }

  factory UserCharacterGroup.fromJson(String source) =>
      UserCharacterGroup.fromMap(json.decode(source) as Map<String, dynamic>);

  final int? point;
  final RoleGroupEnum role;

  UserCharacterGroup copyWith({
    int? point,
    RoleGroupEnum? role,
  }) {
    return UserCharacterGroup(
      point: point ?? this.point,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'point': point,
      'role': role.name,
    };
  }

  String toJson() => json.encode(toMap());
}
