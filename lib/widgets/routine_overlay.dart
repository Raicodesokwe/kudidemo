import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kudidemo/models/routine_model.dart';
import 'package:kudidemo/providers/habits_provider.dart';
import 'package:provider/provider.dart';

import '../models/habits_model.dart';

class RoutineOverlay extends StatefulWidget {
  final String routine;
  const RoutineOverlay({Key? key, required this.routine}) : super(key: key);

  @override
  State<RoutineOverlay> createState() => _RoutineOverlayState();
}

class _RoutineOverlayState extends State<RoutineOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
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
    final routineProvider = Provider.of<HabitsProvider>(context);
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
    final habit = HabitsModel(routine: widget.routine);
    return ScaleTransition(
      scale: scaleAnimation,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          'Routine',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 16),
        ),
        content: Wrap(
          spacing: 5,
          runSpacing: 15,
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.start,
          direction: Axis.horizontal,
          runAlignment: WrapAlignment.start,
          verticalDirection: VerticalDirection.down,
          clipBehavior: Clip.none,
          children: List.generate(routineList.length, (index) {
            final routineName = routineList[index];
            return GestureDetector(
              onTap: () {
                routineProvider.selectRoutine(index);

                print('hii ni ${routineProvider.routine}');
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                    height: 40,
                    width: 70,
                    child: Center(
                      child: Text(
                        routineName.routine,
                        style: GoogleFonts.prompt(
                            color: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .color!
                                .withOpacity(0.5),
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    decoration: decorator.copyWith(
                        color: routineProvider.routine == routineName.routine
                            ? Colors.green
                            : Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(30))),
              ),
            );
          }),
        ),
      ),
    );
  }
}
