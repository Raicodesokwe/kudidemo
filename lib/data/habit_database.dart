import 'package:hive/hive.dart';

import '../utils/date_time.dart';

final _myBox = Hive.box("Habit_Database");

class HabitDatabase {
  List habits = [];
  //habits list is empty
  Map<DateTime, int> heatMapDataSet = {};
  //heatMapDataSet is empty
  // var dateTimeObject = DateTime.now();
  void createDefaultData() {
    habits = [
      // ["Run", false],
      // ["Fart", false]
    ];
    //in createDefaultData, an empty habits list is initialized
    _myBox.put("START_DATE", todaysDateFormatted());
    //we add start date item to mybox through put with a key of START_DATE and a value of todaysDateFormatted() that gives us today's date
    //thus every time we call createDefaultData, we add today's date to mybox
  }

//we load the data if it already exists
  void loadData() {
    if (_myBox.get(todaysDateFormatted()) == null) {
      //if it's a new day since today's date is null,we get the current habit list from the database
      habits = _myBox.get("CURRENT_HABIT_LIST");
      //we get the values of key CURRENT_HABIT_LIST and store them in the habits list variable
      for (int i = 0; i < habits.length; i++) {
        //for every habit from this CURRENT_HABIT_LIST the completed property turns to false if it's a new day thus todaysdateformatted is null
        habits[i][6] = false;
      }
    } else {
      //if it's not a new day thus todaydateformatted is not null, we then get the already existing habit list
      habits = _myBox.get(todaysDateFormatted());
    }
  }

//update database
  void updateDatabase() {
    //update today's habit list entry
    _myBox.put(todaysDateFormatted(), habits);
    //update universal habit list incase there is a change eg incase there is a new habit or a habit is edited or deleted
    _myBox.put("CURRENT_HABIT_LIST", habits);
    //calculate habit complete percentages for each day
    calculateHabitPercentages();
    //load the heat map
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
