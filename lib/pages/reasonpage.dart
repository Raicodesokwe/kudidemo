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
            BackArrow(
              decorator: decorator,
            ),
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
              style: TextStyle(color: Colors.black54, fontSize: 13),
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
                            icon: FontAwesomeIcons.briefcase,
                            reason: 'work',
                          ),
                          ReasonIcon(
                            icon: FontAwesomeIcons.house,
                            reason: 'family',
                          ),
                          ReasonIcon(
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
                            icon: FontAwesomeIcons.school,
                            reason: 'school',
                          ),
                          ReasonIcon(
                            icon: FontAwesomeIcons.heart,
                            reason: 'relationship',
                          ),
                          ReasonIcon(
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
                            icon: FontAwesomeIcons.bowlFood,
                            reason: 'food',
                          ),
                          ReasonIcon(
                            icon: Icons.sports_gymnastics,
                            reason: 'gym',
                          ),
                          ReasonIcon(
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
                            icon: FontAwesomeIcons.award,
                            reason: 'hobbies',
                          ),
                          ReasonIcon(
                            icon: FontAwesomeIcons.gamepad,
                            reason: 'gaming',
                          ),
                          ReasonIcon(
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
                            icon: FontAwesomeIcons.bed,
                            reason: 'sleep',
                          ),
                          ReasonIcon(
                            icon: FontAwesomeIcons.shop,
                            reason: 'shopping',
                          ),
                          ReasonIcon(
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
                            icon: FontAwesomeIcons.moneyBill,
                            reason: 'money',
                          ),
                          ReasonIcon(
                            icon: FontAwesomeIcons.heart,
                            reason: 'sex',
                          ),
                          ReasonIcon(
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
                label: 'Next',
              ),
            )
          ],
        ),
      ),
    );
  }
}
