import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kudidemo/utils/utils.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class FunkyOverlay extends StatefulWidget {
  DateTime? fromDate;
  DateTime? toDateString;
  FunkyOverlay({Key? key, required this.fromDate, required this.toDateString});
  @override
  State<StatefulWidget> createState() => FunkyOverlayState();
}

class FunkyOverlayState extends State<FunkyOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  final _overlayForm = GlobalKey<FormState>();
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
    final themeData = Provider.of<ThemeProvider>(context).darkTheme;
    final BoxDecoration decorator = BoxDecoration(
      boxShadow: themeData
          ? [
              BoxShadow(
                  color: Colors.grey.shade500,
                  offset: Offset(4, 4),
                  blurRadius: 15,
                  spreadRadius: 1),
              BoxShadow(
                spreadRadius: 1,
                color: Colors.white,
                offset: Offset(-4, -4),
                blurRadius: 15,
              )
            ]
          : [
              BoxShadow(
                  color: Colors.black,
                  offset: Offset(5, 5),
                  blurRadius: 15,
                  spreadRadius: 5),
              BoxShadow(
                spreadRadius: 1,
                color: Colors.grey.shade800,
                offset: Offset(-4, -4),
                blurRadius: 15,
              )
            ],
    );
    Size size = MediaQuery.of(context).size;
    Future<DateTime?> pickDateTime(DateTime initialDate,
        {required bool pickDate, DateTime? firstDate}) async {
      if (pickDate) {
        final date = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: firstDate ?? DateTime.now(),
          lastDate: DateTime(2088),
        );
        if (date == null) return null;
        final time =
            Duration(hours: initialDate.hour, minutes: initialDate.minute);
        return date.add(time);
      } else {
        final timeOfDay = await showTimePicker(
            context: context, initialTime: TimeOfDay.fromDateTime(initialDate));
        if (timeOfDay == null) return null;
        final date =
            DateTime(initialDate.year, initialDate.month, initialDate.day);
        final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);
        return date.add(time);
      }
    }

    Future pickFromDateTime({required bool pickDate}) async {
      final date = await pickDateTime(widget.fromDate!, pickDate: pickDate);
      if (date == null) return;
      if (date.isAfter(widget.toDateString!)) {
        widget.toDateString = DateTime(date.year, date.month, date.day,
            widget.toDateString!.hour, widget.toDateString!.minute);
      }
      setState(() => widget.fromDate = date);
    }

    Future pickToDateTime({required bool pickDate}) async {
      final date = await pickDateTime(
        widget.toDateString!,
        pickDate: pickDate,
        firstDate: pickDate ? widget.fromDate : null,
      );
      if (date == null) return;

      setState(() => widget.toDateString = date);
    }

    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
            child: Container(
              decoration: ShapeDecoration(
                  color: themeData ? Colors.grey[300] : Colors.grey[900],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _overlayForm,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'From',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: decorator.copyWith(
                                borderRadius: BorderRadius.circular(15.0),
                                color: themeData
                                    ? Colors.grey[300]
                                    : Colors.grey[900],
                              ),
                              child: ListTile(
                                onTap: () => pickFromDateTime(pickDate: true),
                                title: Text(
                                  Utils.toDate(widget.fromDate!),
                                  style: TextStyle(fontSize: 12),
                                ),
                                trailing: Icon(Icons.arrow_drop_down),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              onTap: () => pickFromDateTime(pickDate: false),
                              title: Text(
                                Utils.toTime(widget.fromDate!),
                                style: TextStyle(fontSize: 10),
                              ),
                              trailing: Icon(Icons.arrow_drop_down),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        'To',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: decorator.copyWith(
                                borderRadius: BorderRadius.circular(15.0),
                                color: themeData
                                    ? Colors.grey[300]
                                    : Colors.grey[900],
                              ),
                              child: ListTile(
                                onTap: () => pickToDateTime(pickDate: true),
                                title: Text(
                                  Utils.toDate(widget.toDateString!),
                                  style: TextStyle(fontSize: 12),
                                ),
                                trailing: Icon(Icons.arrow_drop_down),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              onTap: () => pickToDateTime(pickDate: true),
                              title: Text(
                                Utils.toTime(widget.toDateString!),
                                style: TextStyle(fontSize: 10),
                              ),
                              trailing: Icon(Icons.arrow_drop_down),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: (() {
                              Navigator.of(context).pop({
                                "from": widget.fromDate,
                                "to": widget.toDateString
                              });
                            }),
                            child: Container(
                              child: Center(
                                child: Text('Cancel'),
                              ),
                              height: 50,
                              width: 120,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Color.fromARGB(255, 212, 212, 212)),
                            ),
                          ),
                          Container(
                            child: Center(
                              child: Text(
                                'Confirm',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            height: 50,
                            width: 120,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: Color.fromARGB(255, 12, 99, 212)),
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
      ),
    );
  }
}
