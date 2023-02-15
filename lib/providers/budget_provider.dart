import 'package:flutter/cupertino.dart';
import 'package:kudidemo/models/budget_model.dart';

class BudgetProvider with ChangeNotifier {
  List<BudgetModel> _budgetItems = [];
  List<BudgetModel> get budgetItems {
    return [..._budgetItems];
  }

  void addBudgetItems(BudgetModel budgetItem) {
    _budgetItems.add(budgetItem);
    notifyListeners();
  }
}
