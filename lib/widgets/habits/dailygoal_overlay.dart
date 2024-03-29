import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:kudidemo/providers/habits_provider.dart';
import 'package:provider/provider.dart';

class DailyGoalOverlay extends StatefulWidget {
  DailyGoalOverlay({
    Key? key,
  }) : super(key: key);

  @override
  State<DailyGoalOverlay> createState() => _DailyGoalOverlayState();
}

class _DailyGoalOverlayState extends State<DailyGoalOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  int? count;
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
        Provider.of<HabitsProvider>(context, listen: false).addCount();
      });
    }

    void reduceCount() {
      if (count! > 1) {
        setState(() {
          Provider.of<HabitsProvider>(context, listen: false).decreaseCount();
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
          'Daily goal',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 18),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('How many times a day does your habit happen?',
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
                  onTap: () => addCount(),
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
                Consumer<HabitsProvider>(builder: (context, notifier, child) {
                  count = notifier.dailyGoal;
                  return Text(
                    notifier.dailyGoal.toString(),
                    style: TextStyle(
                        fontSize: 25,
                        color: Theme.of(context).textTheme.bodyText2!.color),
                  );
                }),
                SizedBox(
                  width: 15,
                ),
                GestureDetector(
                  onTap: () => reduceCount(),
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
