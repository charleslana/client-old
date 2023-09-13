import 'dart:convert';

class Group {
  Group({
    required this.id,
    required this.name,
    this.description,
    required this.level,
    required this.experience,
    this.image,
    this.requiredLevel,
    required this.createdAt,
  });

  factory Group.fromMap(Map<String, dynamic> map) {
    return Group(
      id: map['id'] as int,
      name: map['name'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
      level: map['level'] as int,
      experience: map['experience'] as int,
      image: map['image'] != null ? map['image'] as String : null,
      requiredLevel:
          map['requiredLevel'] != null ? map['requiredLevel'] as int : null,
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  factory Group.fromJson(String source) =>
      Group.fromMap(json.decode(source) as Map<String, dynamic>);
  final int id;
  final String name;
  final String? description;
  final int level;
  final int experience;
  final String? image;
  final int? requiredLevel;
  final DateTime createdAt;

  Group copyWith({
    int? id,
    String? name,
    String? description,
    int? level,
    int? experience,
    String? image,
    int? requiredLevel,
    DateTime? createdAt,
  }) {
    return Group(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      level: level ?? this.level,
      experience: experience ?? this.experience,
      image: image ?? this.image,
      requiredLevel: requiredLevel ?? this.requiredLevel,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'level': level,
      'experience': experience,
      'image': image,
      'requiredLevel': requiredLevel,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  String toJson() => json.encode(toMap());
}
