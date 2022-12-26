import 'package:hive/hive.dart';

import '../utils/date_time.dart';

final _myBox = Hive.box("Habit_Database");

class HabitDatabase {
  List habits = [];
  Map<DateTime, int> heatMapDataSet = {};
  // var dateTimeObject = DateTime.now();
  void createDefaultData() {
    habits = [
      // ["Run", false],
      // ["Fart", false]
    ];
    _myBox.put("START_DATE", todaysDateFormatted());
  }

  void loadData() {
    if (_myBox.get(todaysDateFormatted()) == null) {
      habits = _myBox.get("CURRENT_HABIT_LIST");
      for (int i = 0; i < habits.length; i++) {
        habits[i][6] = false;
      }
    } else {
      habits = _myBox.get(todaysDateFormatted());
    }
  }

  void updateDatabase() {
    _myBox.put(todaysDateFormatted(), habits);
    _myBox.put("CURRENT_HABIT_LIST", habits);
    calculateHabitPercentages();
    loadHeatMap();
  }

  void calculateHabitPercentages() {
    int countCompleted = 0;
    for (int i = 0; i < habits.length; i++) {
      if (habits[i][6] == true) {
        countCompleted++;
      }
    }
    String percent = habits.isEmpty
        ? "0.0"
        : (countCompleted / habits.length).toStringAsFixed(1);

    _myBox.put("PERCENTAGE_SUMMARY_${todaysDateFormatted()}", percent);
  }

  void loadHeatMap() {
    DateTime startDate = createDateTimeObject(_myBox.get("START_DATE"));
    int daysInBetween = DateTime.now().difference(startDate).inDays;
    for (int i = 0; i < daysInBetween + 1; i++) {
      String yyyymmdd =
          convertDateTimeToString(startDate.add(Duration(days: i)));

      double strengthAsPercent =
          double.parse(_myBox.get("PERCENTAGE_SUMMARY_$yyyymmdd") ?? "0.0");

      int year = startDate.add(Duration(days: i)).year;
      int month = startDate.add(Duration(days: i)).month;
      int day = startDate.add(Duration(days: i)).day;

      final percentForEachDay = <DateTime, int>{
        DateTime(year, month, day): (10 * strengthAsPercent).toInt()
      };
      heatMapDataSet.addEntries(percentForEachDay.entries);
      print(heatMapDataSet);
    }
  }
}
