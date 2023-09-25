import 'dart:convert';

import 'item.dart';

class UserCharacterItem {
  UserCharacterItem({
    required this.id,
    this.equipped,
    required this.item,
    this.quantity,
    this.enhancement,
  });

  factory UserCharacterItem.fromMap(Map<String, dynamic> map) {
    return UserCharacterItem(
      id: map['id'] as int,
      equipped: map['equipped'] != null ? map['equipped'] as bool : null,
      item: Item.fromMap(map['item'] as Map<String, dynamic>),
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      enhancement:
          map['enhancement'] != null ? map['enhancement'] as int : null,
    );
  }

  factory UserCharacterItem.fromJson(String source) =>
      UserCharacterItem.fromMap(json.decode(source) as Map<String, dynamic>);
  final int id;
  final bool? equipped;
  final Item item;
  final int? quantity;
  final int? enhancement;

  static List<UserCharacterItem> listFromJson(List<dynamic> list) =>
      List<UserCharacterItem>.from(
          // ignore: unnecessary_lambdas
          list.map((dynamic e) => UserCharacterItem.fromMap(e)));

  UserCharacterItem copyWith({
    int? id,
    bool? equipped,
    Item? item,
    int? quantity,
    int? enhancement,
  }) {
    return UserCharacterItem(
      id: id ?? this.id,
      equipped: equipped ?? this.equipped,
      item: item ?? this.item,
      quantity: quantity ?? this.quantity,
      enhancement: enhancement ?? this.enhancement,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'equipped': equipped,
      'item': item.toMap(),
      'quantity': quantity,
      'enhancement': enhancement,
    };
  }

  String toJson() => json.encode(toMap());
}
