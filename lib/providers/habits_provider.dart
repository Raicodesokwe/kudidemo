import 'dart:collection';
import 'package:hive/hive.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:kudidemo/models/routine_model.dart';
import 'package:kudidemo/models/week_model.dart';
import 'package:kudidemo/utils/date_time.dart';

class HabitsProvider with ChangeNotifier {
  // List _habits = [];
  // List get habits {
  //   return [..._habits];
  // }

  int dailyGoal = 1;
  bool repeat = true;
  String editName = '';
  DateTime reminder = DateTime.now();
  String routine = 'Anytime';
  bool complete = false;
  List days = [];
  DateTime today = DateTime.now();

  void selectRoutine(int routineIndex) {
    routine = routineList[routineIndex].routine;
    notifyListeners();
  }

  void decreaseCount() {
    dailyGoal -= 1;
    notifyListeners();
  }

  void addCount() {
    dailyGoal += 1;
    notifyListeners();
  }

  void switchRepeat() {
    repeat = !repeat;
    notifyListeners();
  }

  void selectDay(int dayIndex) {
    weekDays[dayIndex].daySelected = true;
    notifyListeners();
  }

  void reset() {
    reminder = DateTime.now();
    repeat = true;
    dailyGoal = 1;
    routine = 'Anytime';
    days = [];
    editName = '';
    notifyListeners();
  }

  // Map<DateTime, int> heatMapDataSet = {};
  // final _myBox = Hive.box("Habit_Database");
  // void createDefaultData() {
  //   _habits = [];
  //   _myBox.put("START_DATE", todaysDateFormatted());
  //   notifyListeners();
  // }

  // void loadData() {
  //   if (_myBox.get(todaysDateFormatted()) == null) {
  //     _habits = _myBox.get("CURRENT_HABIT_LIST");
  //     for (int i = 0; i < habits.length; i++) {
  //       habits[i][6] = false;
  //     }
  //   } else {
  //     _habits = _myBox.get(todaysDateFormatted());
  //   }
  //   notifyListeners();
  // }

  // void updateDatabase() {
  //   _myBox.put(todaysDateFormatted(), habits);
  //   _myBox.put("CURRENT_HABIT_LIST", habits);
  //   calculateHabitPercentages();
  //   loadHeatMap();
  //   notifyListeners();
  // }

  // void calculateHabitPercentages() {
  //   int countCompleted = 0;
  //   for (int i = 0; i < habits.length; i++) {
  //     if (habits[i][6] == true) {
  //       countCompleted++;
  //     }
  //   }
  //   String percent = habits.isEmpty
  //       ? "0.0"
  //       : (countCompleted / habits.length).toStringAsFixed(1);

  //   _myBox.put("PERCENTAGE_SUMMARY_${todaysDateFormatted()}", percent);
  //   notifyListeners();
  // }

  // void loadHeatMap() {
  //   DateTime startDate = createDateTimeObject(_myBox.get("START_DATE"));
  //   int daysInBetween = DateTime.now().difference(startDate).inDays;
  //   for (int i = 0; i < daysInBetween + 1; i++) {
  //     String yyyymmdd =
  //         convertDateTimeToString(startDate.add(Duration(days: i)));

  //     double strengthAsPercent =
  //         double.parse(_myBox.get("PERCENTAGE_SUMMARY_$yyyymmdd") ?? "0.0");

  //     int year = startDate.add(Duration(days: i)).year;
  //     int month = startDate.add(Duration(days: i)).month;
  //     int day = startDate.add(Duration(days: i)).day;

  //     final percentForEachDay = <DateTime, int>{
  //       DateTime(year, month, day): (10 * strengthAsPercent).toInt()
  //     };
  //     heatMapDataSet.addEntries(percentForEachDay.entries);
  //     print(heatMapDataSet);
  //   }
  //   notifyListeners();
  // }
}
