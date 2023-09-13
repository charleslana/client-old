import 'dart:convert';

import '../enums/role_group_enum.dart';
import 'group.dart';

class UserCharacterGroup {
  UserCharacterGroup({
    this.point,
    required this.role,
    required this.group,
  });

  factory UserCharacterGroup.fromMap(Map<String, dynamic> map) {
    return UserCharacterGroup(
      point: map['point'] != null ? map['point'] as int : null,
      role: RoleGroupEnum.values.byName(map['role']),
      group: Group.fromMap(map['group'] as Map<String, dynamic>),
    );
  }

  factory UserCharacterGroup.fromJson(String source) =>
      UserCharacterGroup.fromMap(json.decode(source) as Map<String, dynamic>);

  final int? point;
  final RoleGroupEnum role;
  final Group group;

  UserCharacterGroup copyWith({
    int? point,
    RoleGroupEnum? role,
    Group? group,
  }) {
    return UserCharacterGroup(
      point: point ?? this.point,
      role: role ?? this.role,
      group: group ?? this.group,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'point': point,
      'role': role.name,
      'group': group.toMap(),
    };
  }

  String toJson() => json.encode(toMap());
}
