import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:kudidemo/models/budget_model.dart';

class BudgetProvider with ChangeNotifier {
  List<BudgetModel> _budgetItems = [];
  List<BudgetModel> get budgetItems {
    return [..._budgetItems];
  }

  final String expenseIncomeHiveBox = 'budget-box';
  Future<void> addBudgetItems(BudgetModel budgetItem) async {
    Box<BudgetModel> box =
        await Hive.openBox<BudgetModel>(expenseIncomeHiveBox);
    await box.put(budgetItem.id, budgetItem);
    _budgetItems = box.values.toList();
    notifyListeners();
  }

  Future<void> getBudgetItems() async {
    Box<BudgetModel> box =
        await Hive.openBox<BudgetModel>(expenseIncomeHiveBox);
    _budgetItems = box.values.toList();
    notifyListeners();
  }

  void reset() {}
}
