import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:kudidemo/models/week_model.dart';
import 'package:kudidemo/widgets/date_circle.dart';
import 'package:provider/provider.dart';

import '../providers/habits_provider.dart';
import '../utils/utils.dart';

class RepeatOverlay extends StatefulWidget {
  DateTime selectedTime;
  RepeatOverlay({Key? key, required this.selectedTime}) : super(key: key);

  @override
  State<RepeatOverlay> createState() => _RepeatOverlayState();
}

class _RepeatOverlayState extends State<RepeatOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  bool alldays = true;
  bool monSelected = false;
  bool tueSelected = false;

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

  // _selectTime() async {
  //   final timeOfDay = await showTimePicker(
  //       builder: (BuildContext context, Widget? child) {
  //         return Theme(
  //           data: ThemeData(fontFamily: 'grifterbold'),
  //           child: child!,
  //         );
  //       },
  //       context: context,
  //       initialTime: TimeOfDay.fromDateTime(widget.selectedTime));
  //   if (timeOfDay == null) return null;

  //   final date = DateTime(widget.selectedTime.year, widget.selectedTime.month,
  //       widget.selectedTime.day);
  //   final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);
  //   return date.add(time);
  // }
  Future<DateTime?> pickDateTime(DateTime initialDate,
      {DateTime? firstDate}) async {
    final timeOfDay = await showTimePicker(
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData(fontFamily: 'grifterbold'),
            child: child!,
          );
        },
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate));
    if (timeOfDay == null) return null;
    final date = DateTime(initialDate.year, initialDate.month, initialDate.day);
    final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);
    return date.add(time);
  }

  Future pickToDateTime() async {
    final date = await pickDateTime(
      widget.selectedTime,
      firstDate: widget.selectedTime,
    );
    if (date == null) return;

    setState(() => widget.selectedTime = date);
  }

  @override
  Widget build(BuildContext context) {
    // if (monSelected && tueSelected) {
    //   alldays = true;
    // }
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
    // final habit = HabitsModel(reminder: widget.selectedTime);

    // Provider.of<HabitsProvider>(context).addHabitDetails(habit);

    return ScaleTransition(
      scale: scaleAnimation,
      child: Consumer<HabitsProvider>(builder: (context, notifier, child) {
        // final habit =
        //     HabitsModel(repeat: notifier.repeat, reminder: widget.selectedTime);

        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Theme.of(context).backgroundColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Repeat everyday',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontSize: 16),
              ),
              GestureDetector(
                onTap: () {
                  notifier.switchRepeat();
                },
                child: Checkbox(
                    value: notifier.repeat,
                    checkColor: Colors.white,
                    activeColor: Colors.green,
                    side: MaterialStateBorderSide.resolveWith(
                      (states) => BorderSide(
                          width: 2.0, color: const Color(0xFF32D74B)),
                    ),
                    onChanged: (bool? value) {
                      setState(() {
                        notifier.repeat = value!;
                      });
                    }),
              )
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Row(
              //   children: [
              //     GestureDetector(
              //       onTap: () {
              //         setState(() {
              //           monSelected = !monSelected;
              //         });
              //       },
              //       child: Container(
              //         height: 50,
              //         width: 50,
              //         child: Center(
              //           child: Text(
              //             'Mon',
              //             style: TextStyle(
              //                 fontSize: 12,
              //                 fontFamily: Theme.of(context)
              //                     .textTheme
              //                     .bodyText2!
              //                     .fontFamily,
              //                 color:
              //                     Theme.of(context).textTheme.bodyText2!.color),
              //           ),
              //         ),
              //         decoration: decorator.copyWith(
              //             shape: BoxShape.circle,
              //             color: alldays || monSelected
              //                 ? Colors.green
              //                 : Theme.of(context).backgroundColor),
              //       ),
              //     ),
              //     SizedBox(
              //       width: 5,
              //     ),
              //     GestureDetector(
              //       onTap: () {
              //         setState(() {
              //           tueSelected = !tueSelected;
              //         });
              //       },
              //       child: Container(
              //         height: 50,
              //         width: 50,
              //         child: Center(
              //           child: Text(
              //             'Tue',
              //             style: TextStyle(
              //                 fontSize: 12,
              //                 fontFamily: Theme.of(context)
              //                     .textTheme
              //                     .bodyText2!
              //                     .fontFamily,
              //                 color:
              //                     Theme.of(context).textTheme.bodyText2!.color),
              //           ),
              //         ),
              //         decoration: decorator.copyWith(
              //             shape: BoxShape.circle,
              //             color: alldays || tueSelected
              //                 ? Colors.green
              //                 : Theme.of(context).backgroundColor),
              //       ),
              //     ),
              //   ],
              // ),

              Wrap(
                spacing: 5,
                runSpacing: 15,
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                direction: Axis.horizontal,
                runAlignment: WrapAlignment.start,
                verticalDirection: VerticalDirection.down,
                clipBehavior: Clip.none,
                children: List.generate(weekDays.length, (index) {
                  final dayName = weekDays[index];

                  return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Container(
                        height: 50,
                        width: 50,
                        child: Center(
                          child: Text(
                            dayName.day,
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .fontFamily,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .color),
                          ),
                        ),
                        decoration: decorator.copyWith(
                            shape: BoxShape.circle,
                            color: notifier.repeat
                                ? Colors.green
                                : Theme.of(context).backgroundColor),
                      ));
                }),
              ),
              SizedBox(
                height: 20,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Reminder',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 16),
                  ),
                  Text(
                    '(Optional)',
                    style: GoogleFonts.prompt(
                        fontSize: 10,
                        color: Theme.of(context).textTheme.bodyText2!.color),
                  ),
                  Text(
                    Utils.toTime(widget.selectedTime),
                    style: GoogleFonts.prompt(
                        fontSize: 10,
                        color: Theme.of(context).textTheme.bodyText2!.color),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  // _selectTime();
                  pickToDateTime();
                },
                child: Container(
                  width: size.width * 0.6,
                  height: 50,
                  child: Center(
                    child: Text(
                      'Add reminder',
                      style: GoogleFonts.prompt(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).textTheme.bodyText2!.color),
                    ),
                  ),
                  decoration: decorator.copyWith(
                      borderRadius: BorderRadius.circular(15),
                      color: Theme.of(context).backgroundColor),
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
                      // notifier.addHabitDetails(habit);
                      notifier.reminder = widget.selectedTime;
                      print('de time de ${notifier.reminder}');
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      child: Center(
                        child: Text(
                          'Confirm',
                          style: GoogleFonts.prompt(color: Colors.white),
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
        );
      }),
    );
  }
}
