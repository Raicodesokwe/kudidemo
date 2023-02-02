import 'dart:collection';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:kudidemo/models/expense_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/expense_model.dart';

class ExpenseProvider extends ChangeNotifier {
  DateTime? date = DateTime.now();
  void addExpenseDetails(ExpenseItem expense) {
    date = expense.date;
  }

  final _kCurrency = "currency_preference";
  ExpenseProvider() {
    loadCurrency();
  }
  String currency = '';
  loadCurrency() {
    SharedPreferences.getInstance().then((prefs) {
      currency = prefs.getString(_kCurrency) ?? "\$";
    });
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

  File? imgFile = File('');
  String? expenseNotes = '';
  void addExpenseNotes(ExpenseItem expense) {
    expenseNotes = expense.notes;
    notifyListeners();
  }

  bool inputWidget = false;
  double amount = 0.0;
  List<ExpenseItem> _expenseitems = [];
  List<ExpenseItem> get expenseitems {
    return [..._expenseitems];
  }

  void addExpense(ExpenseItem expense) {
    _expenseitems.add(expense);
  }

  void reset() {
    imgFile = File('');
    amount = 0.0;
    expenseNotes = '';
  }
}
