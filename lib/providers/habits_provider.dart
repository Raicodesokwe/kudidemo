import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kudidemo/models/expense_model.dart';
import 'package:kudidemo/models/habits_model.dart';
import 'package:kudidemo/models/routine_model.dart';
import 'package:kudidemo/models/week_model.dart';

class HabitsProvider with ChangeNotifier {
  List<HabitsModel> _habits = [];
  List<HabitsModel> get habits {
    return [..._habits];
  }

  Future<void> addHabits(HabitsModel habit) async {
    _habits.add(habit);
    notifyListeners();
  }

  int? dailyGoal = 1;
  TimeOfDay? reminder = TimeOfDay.now();
  String? routine = 'Anytime';
  void addHabitDetails(HabitsModel habit) {
    dailyGoal = habit.dailyGoal;
    reminder = habit.reminder;
    notifyListeners();
  }

  void selectRoutine(int routineIndex) {
    routine = routineList[routineIndex].routine;
    notifyListeners();
  }

  void selectDay(int dayIndex) {
    weekDays[dayIndex].daySelected = true;
    notifyListeners();
  }

  String _searchString = "";
  UnmodifiableListView<ExpenseModel> get expenses => _searchString.isEmpty
      ? UnmodifiableListView(expenseList)
      : UnmodifiableListView(expenseList.where(
          (element) => element.name.toLowerCase().contains(_searchString)));
  void changeSearchString(String searchString) {
    _searchString = searchString;
    print(_searchString);
    notifyListeners();
  }
}
