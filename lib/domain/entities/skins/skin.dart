import 'package:flutter/material.dart';

class Skin {
  final String name;
  final int color;
  final String image;
  final Alignment alignment;

  Skin({required this.name, required this.color, required this.image, this.alignment = Alignment.center});
}
