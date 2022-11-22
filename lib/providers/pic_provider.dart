import 'package:flutter/material.dart';
import 'package:kudidemo/models/pic_model.dart';

class PicProvider with ChangeNotifier {
  String? pic = 'nose.svg';
  void changePic(int index) {
    pic = picList[index].pic;
    notifyListeners();
  }
}
