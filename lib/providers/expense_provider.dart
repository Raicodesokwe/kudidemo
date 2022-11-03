import 'package:flutter/cupertino.dart';
import 'package:kudidemo/models/expense_item.dart';

class ExpenseProvider extends ChangeNotifier {
  DateTime? date = DateTime.now();
  void addExpenseDetails(ExpenseItem expense) {
    date = expense.date;
  }
}
