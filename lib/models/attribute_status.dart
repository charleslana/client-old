import 'package:flutter/material.dart';

class AttributeStatus {
  AttributeStatus({
    required this.icon,
    required this.attribute,
    required this.value,
    required this.baseValue,
    required this.attributes,
  });

  final IconData icon;
  final String attribute;
  final int value;
  final int baseValue;
  final List<int> attributes;
}
