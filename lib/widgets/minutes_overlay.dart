import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:kudidemo/providers/timer_provider.dart';
import 'package:provider/provider.dart';

class MinutesOverlay extends StatefulWidget {
  MinutesOverlay({
    Key? key,
  }) : super(key: key);

  @override
  State<MinutesOverlay> createState() => _MinutesOverlayState();
}

class _MinutesOverlayState extends State<MinutesOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  int? value;
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
    void addCount() {
      setState(() {
        // widget.minutes += 60;

        Provider.of<TimerProvider>(context, listen: false).increaseTime();
      });
    }

    void reduceCount() {
      if (value! > 1) {
        setState(() {
          // widget.minutes -= 60;

          Provider.of<TimerProvider>(context, listen: false).increaseTime();
        });
      }
    }

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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          'Change time',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 18),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('How many minutes does your task take?',
                style: GoogleFonts.prompt(
                    fontSize: 12,
                    color: Theme.of(context).textTheme.bodyText2!.color)),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    addCount();
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    child: Center(
                      child: Icon(Icons.add),
                    ),
                    decoration: decorator.copyWith(
                        shape: BoxShape.circle,
                        color: Theme.of(context).backgroundColor),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Consumer<TimerProvider>(builder: (context, timerValue, child) {
                  value = timerValue.time;
                  return Text(
                    '${(timerValue.time / 60).toInt()}',
                    style: TextStyle(
                        fontSize: 25,
                        color: Theme.of(context).textTheme.bodyText2!.color),
                  );
                }),
                SizedBox(
                  width: 15,
                ),
                GestureDetector(
                  onTap: () {
                    reduceCount();
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    child: Center(
                      child: Icon(Icons.remove),
                    ),
                    decoration: decorator.copyWith(
                        shape: BoxShape.circle,
                        color: Theme.of(context).backgroundColor),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
