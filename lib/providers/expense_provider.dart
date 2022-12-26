import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:kudidemo/models/expense_item.dart';

import '../models/expense_model.dart';

class ExpenseProvider extends ChangeNotifier {
  DateTime? date = DateTime.now();
  void addExpenseDetails(ExpenseItem expense) {
    date = expense.date;
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
