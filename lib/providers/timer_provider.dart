import 'package:flutter/cupertino.dart';

class TimerProvider with ChangeNotifier {
  var nowTime = DateTime.now();
  bool tina = false;
  int time = 1500;
  void increaseTime() {
    time += 60;
    notifyListeners();
  }

  void decreaseTime() {
    time -= 60;
    notifyListeners();
  }

  void decreaseOneSec() {
    time -= 1;
    notifyListeners();
  }
}
