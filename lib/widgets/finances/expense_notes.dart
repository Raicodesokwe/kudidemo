import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kudidemo/models/expense_item.dart';
import 'package:kudidemo/widgets/text_field.dart';
import 'package:provider/provider.dart';

import '../../providers/expense_provider.dart';

class ExpenseNotes extends StatefulWidget {
  const ExpenseNotes({Key? key}) : super(key: key);

  @override
  State<ExpenseNotes> createState() => _ExpenseNotesState();
}

class _ExpenseNotesState extends State<ExpenseNotes>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  TextEditingController notesController = TextEditingController();
  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final expense = ExpenseItem(notes: notesController.text);
    final expenseProvider = Provider.of<ExpenseProvider>(context);
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
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
            child: Container(
              decoration: ShapeDecoration(
                  color: Theme.of(context).backgroundColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextField(
                        controller: notesController,
                        emptytext: 'Additional notes',
                        hintText: 'Additional notes'),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancel',
                                style: GoogleFonts.prompt(
                                    color: Color.fromARGB(255, 12, 99, 212),
                                    fontWeight: FontWeight.w600))),
                        GestureDetector(
                          onTap: () {
                            expenseProvider.addExpenseNotes(expense);
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            child: Center(
                              child: Text(
                                'Confirm',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            height: 50,
                            width: 120,
                            decoration: decorator.copyWith(
                                borderRadius: BorderRadius.circular(7),
                                color: Color.fromARGB(255, 12, 99, 212)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
