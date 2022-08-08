import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class TimerWidget extends StatelessWidget {
  TimerWidget({Key? key}) : super(key: key);
  DateTime now = DateTime.now();
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
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.1,
          ),
          Center(
            child: Container(
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    child: Center(
                        child: Image.asset(
                      'assets/images/tomato.png',
                      scale: 3,
                    )),
                    decoration: BoxDecoration(
                        color: Colors.redAccent.shade100,
                        shape: BoxShape.circle),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pomodoro',
                        style: TextStyle(color: Colors.redAccent, fontSize: 17),
                      ),
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.clock,
                            size: 15,
                            color: themeData ? Colors.black54 : Colors.white54,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Finishing ${DateFormat('Hm').format(now)}',
                            style: TextStyle(
                              color:
                                  themeData ? Colors.black54 : Colors.white54,
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
              padding: const EdgeInsets.all(10),
              width: size.width * 0.6,
              decoration: decorator.copyWith(
                borderRadius: BorderRadius.circular(10),
                color: themeData ? Colors.grey[300] : Colors.grey[900],
              ),
            ),
          )
        ],
      ),
    );
  }
}
