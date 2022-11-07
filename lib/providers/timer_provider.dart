import 'package:flutter/cupertino.dart';
import 'package:kudidemo/models/timer_model.dart';

class TimerProvider with ChangeNotifier {
  int time = 1500;
  void changTime(TimerModel timeText) {
    time = timeText.time!;
  }
}
