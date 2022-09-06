import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kudidemo/utils/utils.dart';
import 'package:kudidemo/widgets/oval_container.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class DateOverlay extends StatefulWidget {
  DateTime? fromDate;
  DateTime? toDateString;
  DateOverlay({Key? key, required this.fromDate, required this.toDateString});
  @override
  State<StatefulWidget> createState() => DateOverlayState();
}

class DateOverlayState extends State<DateOverlay>
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
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

    return Platform.isIOS
        ? ScaleTransition(
            scale: scaleAnimation,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: CupertinoAlertDialog(
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'From',
                      style: GoogleFonts.prompt(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => pickFromDateTime(pickDate: true),
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: decorator.copyWith(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Theme.of(context).backgroundColor,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  Utils.toDate(widget.fromDate!),
                                  style:
                                      GoogleFonts.prompt(color: Colors.black),
                                ),
                                Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => pickFromDateTime(pickDate: false),
                          child: Row(
                            children: [
                              Text(
                                Utils.toTime(widget.fromDate!),
                                style: GoogleFonts.prompt(color: Colors.black),
                              ),
                              Icon(Icons.arrow_drop_down)
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'To',
                      style: GoogleFonts.prompt(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => pickToDateTime(pickDate: true),
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: decorator.copyWith(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Theme.of(context).backgroundColor,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  Utils.toDate(widget.toDateString!),
                                  style:
                                      GoogleFonts.prompt(color: Colors.black),
                                ),
                                Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => pickFromDateTime(pickDate: false),
                          child: Row(
                            children: [
                              Text(
                                Utils.toTime(widget.toDateString!),
                                style: GoogleFonts.prompt(color: Colors.black),
                              ),
                              Icon(Icons.arrow_drop_down)
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Remind',
                      style: GoogleFonts.prompt(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            padding: const EdgeInsets.all(15),
                            child: Center(
                              child: Text(
                                '5 mins',
                                style: GoogleFonts.prompt(
                                    color: Colors.black45,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            decoration: decorator.copyWith(
                                color: Theme.of(context).backgroundColor,
                                borderRadius: BorderRadius.circular(30))),
                        Container(
                            padding: const EdgeInsets.all(15),
                            child: Center(
                              child: Text(
                                '10 mins',
                                style: GoogleFonts.prompt(
                                    color: Colors.black45,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            decoration: decorator.copyWith(
                                color: Theme.of(context).backgroundColor,
                                borderRadius: BorderRadius.circular(30))),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            padding: const EdgeInsets.all(15),
                            child: Center(
                              child: Text(
                                '15 mins',
                                style: GoogleFonts.prompt(
                                    color: Colors.black45,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            decoration: decorator.copyWith(
                                color: Theme.of(context).backgroundColor,
                                borderRadius: BorderRadius.circular(30))),
                        SizedBox(
                          width: 15,
                        ),
                        Container(
                            padding: const EdgeInsets.all(15),
                            child: Center(
                              child: Text(
                                '20 mins',
                                style: GoogleFonts.prompt(
                                    color: Colors.black45,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            decoration: decorator.copyWith(
                                color: Theme.of(context).backgroundColor,
                                borderRadius: BorderRadius.circular(30))),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Repeat',
                      style: GoogleFonts.prompt(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            padding: const EdgeInsets.all(15),
                            child: Center(
                              child: Text(
                                'None',
                                style: GoogleFonts.prompt(
                                    color: Colors.black45,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            decoration: decorator.copyWith(
                                color: Theme.of(context).backgroundColor,
                                borderRadius: BorderRadius.circular(30))),
                        Container(
                            padding: const EdgeInsets.all(15),
                            child: Center(
                              child: Text(
                                'Daily',
                                style: GoogleFonts.prompt(
                                    color: Colors.black45,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            decoration: decorator.copyWith(
                                color: Theme.of(context).backgroundColor,
                                borderRadius: BorderRadius.circular(30))),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            padding: const EdgeInsets.all(15),
                            child: Center(
                              child: Text(
                                'Weekly',
                                style: GoogleFonts.prompt(
                                    color: Colors.black45,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            decoration: decorator.copyWith(
                                color: Theme.of(context).backgroundColor,
                                borderRadius: BorderRadius.circular(30))),
                        SizedBox(
                          width: 15,
                        ),
                        Container(
                            padding: const EdgeInsets.all(15),
                            child: Center(
                              child: Text(
                                'Monthly',
                                style: GoogleFonts.prompt(
                                    color: Colors.black45,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            decoration: decorator.copyWith(
                                color: Theme.of(context).backgroundColor,
                                borderRadius: BorderRadius.circular(30))),
                      ],
                    ),
                  ],
                ),
                actions: [
                  CupertinoDialogAction(
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.prompt(color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                  CupertinoDialogAction(
                    child: Text(
                      'Confirm',
                      style: GoogleFonts.prompt(color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(
                          {"from": widget.fromDate, "to": widget.toDateString});
                    },
                  )
                ],
              ),
            ),
          )
        : Center(
            child: Material(
              color: Colors.transparent,
              child: ScaleTransition(
                scale: scaleAnimation,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                    color: Theme.of(context).backgroundColor,
                                  ),
                                  child: ListTile(
                                    onTap: () =>
                                        pickFromDateTime(pickDate: true),
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
                                  onTap: () =>
                                      pickFromDateTime(pickDate: false),
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
                                    color: Theme.of(context).backgroundColor,
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
                                  onTap: () => pickToDateTime(pickDate: false),
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
                            height: size.height * 0.03,
                          ),
                          Text(
                            'Remind',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              OvalContainer(text: '5 mins'),
                              OvalContainer(text: '10 mins'),
                              OvalContainer(text: '15 mins'),
                              OvalContainer(text: '20 mins')
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text(
                            'Repeat',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              OvalContainer(text: 'None'),
                              OvalContainer(text: 'Daily'),
                              OvalContainer(text: 'Weekly'),
                              OvalContainer(text: 'Monthly')
                            ],
                          ),
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
                                  child: Text('Cancel')),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop({
                                    "from": widget.fromDate,
                                    "to": widget.toDateString
                                  });
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
