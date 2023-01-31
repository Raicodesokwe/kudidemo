import 'dart:io';

class ExpenseItem {
  final String? category;
  final double? amount;
  final DateTime? date;
  final String? notes;
  final String? status;
  final File? image;
  ExpenseItem(
      {this.category,
      this.status,
      this.amount,
      this.date,
      this.notes,
      this.image});
}
