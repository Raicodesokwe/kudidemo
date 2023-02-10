import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kudidemo/providers/expense_provider.dart';
import 'package:provider/provider.dart';

import '../../utils/utils.dart';

class FilterDate extends StatefulWidget {
  final ExpenseProvider notifier;
  const FilterDate({Key? key, required this.notifier}) : super(key: key);

  @override
  State<FilterDate> createState() => _FilterDateState();
}

class _FilterDateState extends State<FilterDate>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  @override
  void initState() {
    // TODO: implement initState
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

  Future<DateTime?> pickDateTime(DateTime initialDate,
      {DateTime? firstDate}) async {
    final date = await showDatePicker(
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            fontFamily: 'grifterbold',
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2088),
    );
    if (date == null) return null;
    final time = Duration(hours: initialDate.hour, minutes: initialDate.minute);
    return date.add(time);
  }

  Future pickFromDateTime() async {
    final date = await pickDateTime(
      widget.notifier.fromDate!,
    );
    if (date == null) return;
    if (date.isAfter(widget.notifier.toDate!)) {
      widget.notifier.toDate = DateTime(date.year, date.month, date.day,
          widget.notifier.toDate!.hour, widget.notifier.toDate!.minute);
    }
    setState(() {
      widget.notifier.fromDate = date;
    });
  }

  Future pickToDateTime() async {
    final date = await pickDateTime(
      widget.notifier.toDate!,
      firstDate: widget.notifier.toDate,
    );
    if (date == null) return;

    setState(() {
      widget.notifier.toDate = date;
    });
  }

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
    return ScaleTransition(
      scale: scaleAnimation,
      child: AlertDialog(
        backgroundColor: Theme.of(context).backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text('Filter by date',
            style:
                Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 25)),
        content: Column(
          children: [
            Text(
              'From',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: decorator.copyWith(
                borderRadius: BorderRadius.circular(15.0),
                color: Theme.of(context).backgroundColor,
              ),
              child: ListTile(
                onTap: () async {
                  await pickFromDateTime();
                },
                title: Text(
                  Utils.toDate(widget.notifier.fromDate!),
                  style: GoogleFonts.prompt(
                      color: Theme.of(context).textTheme.bodyText2!.color,
                      fontSize: 12),
                ),
                trailing: Icon(Icons.arrow_drop_down),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'To',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: decorator.copyWith(
                borderRadius: BorderRadius.circular(15.0),
                color: Theme.of(context).backgroundColor,
              ),
              child: ListTile(
                onTap: () async {
                  await pickToDateTime();
                },
                title: Text(
                  Utils.toDate(widget.notifier.toDate!),
                  style: GoogleFonts.prompt(
                      color: Theme.of(context).textTheme.bodyText2!.color,
                      fontSize: 12),
                ),
                trailing: Icon(Icons.arrow_drop_down),
              ),
            ),
            SizedBox(
              height: 20,
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
                    widget.notifier.filtered = true;
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    child: Center(
                      child: Text(
                        'Confirm',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: Colors.white),
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
          mainAxisSize: MainAxisSize.min,
        ),
      ),
    );
  }
}
