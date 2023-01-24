import 'dart:io';

class ExpenseItem {
  final String? currency;
  final String? category;
  final double? amount;
  final DateTime? date;
  final String? notes;
  final String? status;
  final File? image;
  ExpenseItem(
      {this.currency,
      this.category,
      this.status,
      this.amount,
      this.date,
      this.notes,
      this.image});
}
