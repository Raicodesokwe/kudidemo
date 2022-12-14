import 'package:hive/hive.dart';

part 'billable_model.g.dart';

@HiveType(typeId: 2)
class BillableModel extends HiveObject {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final DateTime? start;
  @HiveField(2)
  final DateTime? end;
  @HiveField(3)
  final double? amount;
  BillableModel({this.id, this.start, this.end, this.amount});
}
