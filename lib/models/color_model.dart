import 'package:flutter/material.dart';

class ColorModel {
  final Color? color;
  ColorModel({required this.color});
}

List<ColorModel> colorList = [
  ColorModel(color: Colors.green.shade200),
  ColorModel(color: Colors.pink.shade200),
  ColorModel(color: Colors.purple.shade200),
  ColorModel(color: Colors.blue.shade200),
  ColorModel(color: Colors.orange.shade200),
  ColorModel(color: Colors.red.shade200)
];
