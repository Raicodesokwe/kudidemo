import 'package:hive/hive.dart';

// part 'billable_model.g.dart';

class BillableModel {
  final DateTime? start;
  final DateTime? end;
  final double? amount;
  BillableModel({this.start, this.end, this.amount});
}
