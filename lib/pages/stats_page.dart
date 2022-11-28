import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kudidemo/models/stats_model.dart';
import 'package:kudidemo/pages/task_stats.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
            child: Text(
              'Your stats',
              style: GoogleFonts.prompt(
                  fontWeight: FontWeight.w500,
                  fontSize: 23,
                  color: Theme.of(context).textTheme.bodyText2!.color!),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: Wrap(
            spacing: 25,
            runSpacing: 15,
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            direction: Axis.horizontal,
            runAlignment: WrapAlignment.start,
            verticalDirection: VerticalDirection.down,
            clipBehavior: Clip.none,
            children: List.generate(
                statsList.length,
                (index) => GestureDetector(
                      onTap: () {
                        statsList[index].name == 'Task'
                            ? Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => TaskStats()))
                            : null;
                      },
                      child: Container(
                        width: size.width * 0.4,
                        height: size.height * 0.2,
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/${statsList[index].image!}',
                              scale: 6,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              statsList[index].name!,
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                        decoration: decorator.copyWith(
                            border: Border.all(
                                width: 4,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .color!),
                            color: statsList[index].color,
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    )),
          ),
        ));
  }
}
