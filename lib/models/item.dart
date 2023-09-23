import 'dart:convert';

import '../enums/item_consumable_type_enum.dart';
import '../enums/item_equipment_type_enum.dart';
import '../enums/item_type_enum.dart';
import '../enums/rarity_enum.dart';

class Item {
  Item({
    required this.id,
    required this.name,
    this.description,
    required this.rarity,
    required this.type,
    this.equipmentType,
    this.consumableType,
  });

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'] as int,
      name: map['name'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
      rarity: RarityEnum.values.byName(map['rarity']),
      type: ItemTypeEnum.values.byName(map['type']),
      equipmentType: map['equipmentType'] != null
          ? ItemEquipmentTypeEnum.values.byName(map['equipmentType'])
          : null,
      consumableType: map['consumableType'] != null
          ? ItemConsumableTypeEnum.values.byName(map['consumableType'])
          : null,
    );
  }

  factory Item.fromJson(String source) =>
      Item.fromMap(json.decode(source) as Map<String, dynamic>);

  final int id;
  final String name;
  final String? description;
  final RarityEnum rarity;
  final ItemTypeEnum type;
  final ItemEquipmentTypeEnum? equipmentType;
  final ItemConsumableTypeEnum? consumableType;

  Item copyWith({
    int? id,
    String? name,
    String? description,
    RarityEnum? rarity,
    ItemTypeEnum? type,
    ItemEquipmentTypeEnum? equipmentType,
    ItemConsumableTypeEnum? consumableType,
  }) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      rarity: rarity ?? this.rarity,
      type: type ?? this.type,
      equipmentType: equipmentType ?? this.equipmentType,
      consumableType: consumableType ?? this.consumableType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'rarity': rarity.name,
      'type': type.name,
      'equipmentType': equipmentType?.name,
      'consumableType': consumableType?.name,
    };
  }

  String toJson() => json.encode(toMap());
}
