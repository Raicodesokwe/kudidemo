import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kudidemo/models/habits_model.dart';

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
  void addHabitDetails(HabitsModel habit) {
    dailyGoal = habit.dailyGoal;
    reminder = habit.reminder;
  }
}
