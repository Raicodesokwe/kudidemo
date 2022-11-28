import 'package:flutter/cupertino.dart';
import 'package:kudidemo/models/billable_model.dart';

class BillableProvider with ChangeNotifier {
  List<BillableModel> _bills = [];
  List<BillableModel> get bills {
    return [..._bills];
  }

  void addBills(BillableModel bill) {
    _bills.add(bill);
    notifyListeners();
  }
}
