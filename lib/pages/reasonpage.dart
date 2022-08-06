import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kudidemo/pages/journal_page.dart';
import 'package:kudidemo/widgets/back_arrow.dart';
import 'package:kudidemo/widgets/next_button.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import '../widgets/nextneon_button.dart';
import '../widgets/reason_icon.dart';

class ReasonPage extends StatelessWidget {
  ReasonPage({Key? key}) : super(key: key);
  String? time;
  DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
    if (now.hour >= 4 && now.hour < 12) {
      time = 'morning';
    } else if (now.hour >= 12 && now.hour < 15) {
      time = 'afternoon';
    } else if (now.hour >= 15 && now.hour < 19) {
      time = 'evening';
    } else {
      time = 'night';
    }
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            BackArrow(decorator: decorator, themeData: themeData),
            SizedBox(
              height: size.height * 0.05,
            ),
            Text(
              'What\'s making you feel',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'happy this ${time}?',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Text(
              'select up to 10 activities',
              style: TextStyle(
                  color: themeData ? Colors.black54 : Colors.white54,
                  fontSize: 13),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            SizedBox(
              height: size.height * 0.4,
              width: double.infinity,
              child: PageView(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReasonIcon(
                            themeData: themeData,
                            icon: FontAwesomeIcons.briefcase,
                            reason: 'work',
                          ),
                          ReasonIcon(
                            themeData: themeData,
                            icon: FontAwesomeIcons.house,
                            reason: 'family',
                          ),
                          ReasonIcon(
                            themeData: themeData,
                            icon: FontAwesomeIcons.person,
                            reason: 'friends',
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReasonIcon(
                            themeData: themeData,
                            icon: FontAwesomeIcons.school,
                            reason: 'school',
                          ),
                          ReasonIcon(
                            themeData: themeData,
                            icon: FontAwesomeIcons.heart,
                            reason: 'relationship',
                          ),
                          ReasonIcon(
                            themeData: themeData,
                            icon: FontAwesomeIcons.plane,
                            reason: 'travelling',
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReasonIcon(
                            themeData: themeData,
                            icon: FontAwesomeIcons.bowlFood,
                            reason: 'food',
                          ),
                          ReasonIcon(
                            themeData: themeData,
                            icon: Icons.sports_gymnastics,
                            reason: 'gym',
                          ),
                          ReasonIcon(
                            themeData: themeData,
                            icon: FontAwesomeIcons.heartPulse,
                            reason: 'health',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReasonIcon(
                            themeData: themeData,
                            icon: FontAwesomeIcons.award,
                            reason: 'hobbies',
                          ),
                          ReasonIcon(
                            themeData: themeData,
                            icon: FontAwesomeIcons.gamepad,
                            reason: 'gaming',
                          ),
                          ReasonIcon(
                            themeData: themeData,
                            icon: FontAwesomeIcons.cloudRain,
                            reason: 'weather',
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReasonIcon(
                            themeData: themeData,
                            icon: FontAwesomeIcons.bed,
                            reason: 'sleep',
                          ),
                          ReasonIcon(
                            themeData: themeData,
                            icon: FontAwesomeIcons.shop,
                            reason: 'shopping',
                          ),
                          ReasonIcon(
                            themeData: themeData,
                            icon: FontAwesomeIcons.music,
                            reason: 'music',
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReasonIcon(
                            themeData: themeData,
                            icon: FontAwesomeIcons.moneyBill,
                            reason: 'money',
                          ),
                          ReasonIcon(
                            themeData: themeData,
                            icon: FontAwesomeIcons.heart,
                            reason: 'sex',
                          ),
                          ReasonIcon(
                            themeData: themeData,
                            icon: FontAwesomeIcons.couch,
                            reason: 'relaxing',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            GestureDetector(
              onTap: (() => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => JournalPage()))),
              child: NextBtn(
                size: size,
                themeData: themeData,
              ),
            )
          ],
        ),
      ),
    );
  }
}
