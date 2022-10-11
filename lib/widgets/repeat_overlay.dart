import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kudidemo/widgets/date_circle.dart';

class RepeatOverlay extends StatefulWidget {
  const RepeatOverlay({Key? key}) : super(key: key);

  @override
  State<RepeatOverlay> createState() => _RepeatOverlayState();
}

class _RepeatOverlayState extends State<RepeatOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  bool alldays = true;
  bool mondaySelected = true;
  bool tuesdaySelected = true;
  bool wednesdaySelected = true;
  bool thursdaySelected = true;
  bool fridaySelected = true;
  bool saturdaySelected = true;
  bool sundaySelected = true;

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
    return ScaleTransition(
      scale: scaleAnimation,
      child: AlertDialog(
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
                  setState(() {
                    alldays = !alldays;
                  });
                },
                child: Checkbox(
                    value: alldays,
                    checkColor: Colors.white,
                    activeColor: Colors.green,
                    side: MaterialStateBorderSide.resolveWith(
                      (states) => BorderSide(
                          width: 2.0, color: const Color(0xFF32D74B)),
                    ),
                    onChanged: (bool? value) {
                      setState(() {
                        alldays = value!;
                      });
                    }),
              )
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          mondaySelected = !mondaySelected;
                        });
                      },
                      child: DateCircle(
                          day: 'Mon',
                          alldays: alldays,
                          dayselected: mondaySelected)),
                  SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          tuesdaySelected = !tuesdaySelected;
                        });
                      },
                      child: DateCircle(
                          day: 'Tue',
                          alldays: alldays,
                          dayselected: tuesdaySelected)),
                  SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        wednesdaySelected = !wednesdaySelected;
                      });
                    },
                    child: DateCircle(
                        day: 'Wed',
                        alldays: alldays,
                        dayselected: wednesdaySelected),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        thursdaySelected = !thursdaySelected;
                      });
                    },
                    child: DateCircle(
                        day: 'Thu',
                        alldays: alldays,
                        dayselected: thursdaySelected),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        fridaySelected = !fridaySelected;
                      });
                    },
                    child: DateCircle(
                        day: 'Fri',
                        alldays: alldays,
                        dayselected: fridaySelected),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        saturdaySelected = !saturdaySelected;
                      });
                    },
                    child: DateCircle(
                        day: 'Sat',
                        alldays: alldays,
                        dayselected: saturdaySelected),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        sundaySelected = !sundaySelected;
                      });
                    },
                    child: DateCircle(
                        day: 'Sun',
                        alldays: alldays,
                        dayselected: sundaySelected),
                  )
                ],
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
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
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
              )
            ],
          )),
    );
  }
}
