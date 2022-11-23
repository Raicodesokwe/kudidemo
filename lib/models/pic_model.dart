import 'package:flutter/material.dart';

class PicModel {
  final String pic;
  final Color color;
  PicModel({required this.pic, required this.color});
}

List<PicModel> picList = [
  PicModel(pic: 'nose.svg', color: Colors.yellow),
  PicModel(pic: 'halfloaf.svg', color: Color.fromARGB(255, 80, 28, 201)),
  PicModel(pic: 'triangle.svg', color: Colors.orange),
  PicModel(pic: 'nut.svg', color: const Color(0xFF240754)),
  PicModel(pic: 'slice.svg', color: Color.fromARGB(255, 80, 28, 201)),
  PicModel(pic: 'star.svg', color: const Color(0xFF8FF7FE)),
  // PicModel(pic: 'rasta.svg', color: const Color(0xFFEC9AF3)),
  PicModel(pic: 'shock.svg', color: Color.fromARGB(255, 10, 150, 14)),
];
