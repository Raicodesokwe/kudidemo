import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'finances/expense_box.dart';
import 'finances/income_box.dart';

class NewExpenseIncomeOverlay extends StatefulWidget {
  NewExpenseIncomeOverlay({
    Key? key,
  });
  @override
  State<StatefulWidget> createState() => NewExpenseIncomeOverlayState();
}

class NewExpenseIncomeOverlayState extends State<NewExpenseIncomeOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

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

  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                    Text('Add new'),
                    SizedBox(
                      height: 25,
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            backgroundColor: Theme.of(context).backgroundColor,
                            context: context,
                            builder: (context) {
                              return ExpenseBox(
                                  size: size,
                                  decorator: decorator,
                                  controller: _controller);
                            });
                      },
                      child: Container(
                        height: 50,
                        decoration: decorator.copyWith(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Theme.of(context).backgroundColor),
                        child: Center(
                          child: Text(
                            "Expense",
                            style: GoogleFonts.prompt(
                              fontWeight: FontWeight.w600,
                              color:
                                  Theme.of(context).textTheme.bodyText2!.color,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            backgroundColor: Theme.of(context).backgroundColor,
                            context: context,
                            builder: (context) {
                              return IncomeBox(
                                  size: size,
                                  decorator: decorator,
                                  controller: _controller);
                            });
                      },
                      child: Container(
                        height: 50,
                        decoration: decorator.copyWith(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Theme.of(context).backgroundColor),
                        child: Center(
                          child: Text(
                            "Income",
                            style: GoogleFonts.prompt(
                              fontWeight: FontWeight.w600,
                              color:
                                  Theme.of(context).textTheme.bodyText2!.color,
                            ),
                          ),
                        ),
                      ),
                    ),
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
