import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kudidemo/models/expense_item.dart';
import 'package:kudidemo/pages/finances/edit_expense.dart';
import 'package:kudidemo/utils/utils.dart';
import 'package:kudidemo/widgets/button_edit.dart';
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
    final decorator = BoxDecoration(boxShadow: [
      BoxShadow(
          color: Theme.of(context).cardColor,
          offset: Offset(5, 5),
          blurRadius: 15,
          spreadRadius: 5),
      BoxShadow(
        spreadRadius: 1,
        color: Theme.of(context).canvasColor,
        offset: Offset(-5, -5),
        blurRadius: 15,
      )
    ]);
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            expenseItem.image == null
                ? Stack(
                    children: [
                      Container(
                        height: size.height * 0.3,
                        width: double.infinity,
                        color: Colors.greenAccent,
                        child: Lottie.asset(expenseItem.status == 'income'
                            ? 'assets/images/income.json'
                            : 'assets/images/expense.json'),
                      ),
                      Positioned(
                          left: 20,
                          top: 20,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(
                              Icons.arrow_back,
                              size: 35,
                            ),
                          ))
                    ],
                  )
                : Container(
                    height: size.height * 0.3,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: MemoryImage(expenseItem.image!))),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: (() {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditExpensePage(
                                  expenseItem: expenseItem,
                                )));
                      }),
                      child: ButtonEdit(
                          icon: FontAwesomeIcons.penToSquare, label: 'Edit')),
                  GestureDetector(
                    onTap: () {
                      expenseProvider
                          .removeExpense(expenseItem)
                          .then((value) => Navigator.of(context).pop());
                    },
                    child: Container(
                      height: 50,
                      width: size.width * 0.4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.solidTrashCan,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Delete',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                      decoration: decorator.copyWith(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.red),
                    ),
                  )
                ],
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
            SizedBox(
              height: 15,
            ),
            expenseItem.notes != ''
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text(
                          'Notes: ',
                          style: GoogleFonts.prompt(fontSize: 17),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(expenseItem.notes!),
                      ],
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
