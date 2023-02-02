import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kudidemo/models/expense_item.dart';
import 'package:kudidemo/utils/utils.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../providers/expense_provider.dart';

class ViewDetails extends StatelessWidget {
  final ExpenseItem expenseItem;
  const ViewDetails({Key? key, required this.expenseItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    NumberFormat numberFormat = NumberFormat.decimalPattern();
    final amount = numberFormat.format(expenseItem.amount);
    final expenseProvider =
        Provider.of<ExpenseProvider>(context, listen: false);
    final currency = expenseProvider.currency;
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            expenseItem.image!.path == ''
                ? Container(
                    height: size.height * 0.3,
                    width: double.infinity,
                    color: Colors.greenAccent,
                    child: Lottie.asset(expenseItem.status == 'income'
                        ? 'assets/images/income.json'
                        : 'assets/images/expense.json'),
                  )
                : Container(
                    height: size.height * 0.3,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(expenseItem.image!))),
                  ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                expenseItem.category!,
                style: TextStyle(fontSize: 35),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    'Status: ',
                    style: GoogleFonts.prompt(fontSize: 17),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: expenseItem.status == 'expense'
                              ? Colors.redAccent.withOpacity(0.3)
                              : Colors.lightGreenAccent.withOpacity(0.3)),
                      child: Text(expenseItem.status!))
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    'Amount: ',
                    style: GoogleFonts.prompt(fontSize: 17),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(currency),
                  Text(amount)
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    'Date: ',
                    style: GoogleFonts.prompt(fontSize: 17),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(Utils.toDate(expenseItem.date!)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
