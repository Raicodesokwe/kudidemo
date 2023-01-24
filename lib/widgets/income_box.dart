import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kudidemo/models/income_model.dart';
import 'package:provider/provider.dart';

import '../pages/expense_page.dart';
import '../providers/expense_provider.dart';
import 'add_expense_overlay.dart';

class IncomeBox extends StatelessWidget {
  const IncomeBox({
    Key? key,
    required this.size,
    required this.decorator,
    required TextEditingController controller,
  })  : _controller = controller,
        super(key: key);

  final Size size;
  final BoxDecoration decorator;
  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.7,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 30,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (ctx) {
                        return AddExpenseOverlay();
                      });
                },
                child: Container(
                  child: Center(
                    child: Text('Add custom'),
                  ),
                  height: 50,
                  width: size.width * 0.4,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 2,
                          color: Theme.of(context).textTheme.bodyText2!.color!),
                      color: Colors.greenAccent),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: incomeCategoryList.length,
              itemBuilder: (context, index) {
                final expenseItem = incomeCategoryList[index];
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ExpensePage(
                                  expenseImage: expenseItem.image,
                                  expenseName: expenseItem.name,
                                  tileColor: expenseItem.color,
                                )));
                      },
                      leading: Container(
                        height: 50,
                        width: 50,
                        child: Image.asset(
                          expenseItem.image,
                          scale: 2,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 2,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .color!),
                            borderRadius: BorderRadius.circular(8),
                            color: expenseItem.color),
                      ),
                      title: Text(
                        expenseItem.name,
                        style: TextStyle(
                            fontFamily: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .fontFamily,
                            color:
                                Theme.of(context).textTheme.bodyText2!.color),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    Divider()
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
