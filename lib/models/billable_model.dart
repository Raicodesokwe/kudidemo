import 'package:hive/hive.dart';

// part 'billable_model.g.dart';

class BillableModel {
  // @HiveField(0)
  final String? name;
  // @HiveField(1)
  final double? amount;
  final List? days;
  BillableModel({this.name, this.amount, this.days});
}
