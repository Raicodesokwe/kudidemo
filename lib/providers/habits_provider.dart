import 'package:flutter/cupertino.dart';
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
}
