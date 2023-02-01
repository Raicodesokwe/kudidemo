import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../pages/finances/expense_page.dart';
import '../../providers/expense_provider.dart';
import 'add_expense_overlay.dart';

class ExpenseBox extends StatelessWidget {
  const ExpenseBox({
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
            Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: size.width * 0.8,
                decoration: decorator.copyWith(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.circular(10.0)),
                child: TextFormField(
                  controller: _controller,
                  onChanged: ((value) {
                    Provider.of<ExpenseProvider>(context, listen: false)
                        .changeSearchString(value);
                  }),
                  validator: (value) => value!.isEmpty ? 'no text' : null,
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.black45,
                  style: GoogleFonts.prompt(
                      color: Theme.of(context).textTheme.bodyText2!.color),
                  decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: GoogleFonts.prompt(),
                      border: InputBorder.none),
                )),
            SizedBox(
              height: 20,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (ctx) {
                        return AddExpenseIncomeOverlay(
                          title: 'expense',
                        );
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
            Consumer<ExpenseProvider>(builder: (context, expenseList, child) {
              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: expenseList.expenses.length,
                itemBuilder: (context, index) {
                  final expenseItem = expenseList.expenses[index];
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
              );
            })
          ],
        ),
      ),
    );
  }
}
