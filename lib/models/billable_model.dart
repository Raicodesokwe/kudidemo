import 'package:hive/hive.dart';

// part 'billable_model.g.dart';

@HiveType(typeId: 1)
class BillableModel extends HiveObject {
  @HiveField(0)
  final String? name;
  @HiveField(1)
  final double? amount;
  final List? days;
  BillableModel({this.name, this.amount, this.days});
}
