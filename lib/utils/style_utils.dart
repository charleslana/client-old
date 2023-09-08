import 'package:flutter/material.dart';

final List<Shadow> shadows = [
  const Shadow(
    // bottomLeft
    offset: Offset(-1, -1),
  ),
  const Shadow(
    // bottomRight
    offset: Offset(1, -1),
  ),
  const Shadow(
    // topRight
    offset: Offset(1, 1),
  ),
  const Shadow(
    // topLeft
    offset: Offset(-1, 1),
  ),
];
