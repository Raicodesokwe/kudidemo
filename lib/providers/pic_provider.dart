import 'package:flutter/material.dart';
import 'package:kudidemo/models/pic_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PicProvider with ChangeNotifier {
  final _kPic = "pic_preference";
  final _kColor = "color_preference";
  String? pic = 'nose.svg';
  Color? color = Colors.yellow;
  PicProvider() {
    loadPic();
  }
  loadPic() {
    SharedPreferences.getInstance().then((prefs) {
      String picture = prefs.getString(_kPic) ?? 'nose.svg';
      int selectColor = prefs.getInt(_kColor) ?? Colors.yellow.value;
      pic = picture;
      color = Color(selectColor);
    });
  }

  void changePic(int index) async {
    pic = picList[index].pic;
    color = picList[index].color;
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(_kPic, pic!);
    prefs.setInt(_kColor, color!.value);
    notifyListeners();
  }
}
