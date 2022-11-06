import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kudidemo/models/color_model.dart';

class ColorProvider with ChangeNotifier {
  Color? selectedColor = Colors.green.shade200;
  void selectColor(int chosenColor) {
    selectedColor = colorList[chosenColor].color;
    notifyListeners();
  }
}
