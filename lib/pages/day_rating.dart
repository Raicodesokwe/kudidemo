import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import '../widgets/back_arrow.dart';

class DayRating extends StatefulWidget {
  const DayRating({Key? key}) : super(key: key);

  @override
  State<DayRating> createState() => _DayRatingState();
}

class _DayRatingState extends State<DayRating> {
  double _currentValue = 0;
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
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            BackArrow(decorator: decorator, themeData: themeData),
            SizedBox(
              height: size.height * 0.05,
            ),
            Text(
              'How was your day today?',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            _currentValue >= 0 && _currentValue < 3
                ? Image.asset(
                    'assets/images/sademoji.png',
                    color: themeData ? Colors.black : Colors.white,
                  )
                : _currentValue >= 3 && _currentValue < 6
                    ? Image.asset(
                        'assets/images/second.png',
                        color: themeData ? Colors.black : Colors.white,
                      )
                    : Image.asset(
                        'assets/images/happyemoji.png',
                        color: themeData ? Colors.black : Colors.white,
                      ),
            SizedBox(
              height: size.height * 0.15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 40,
                width: double.infinity,
                decoration: decorator.copyWith(
                  borderRadius: BorderRadius.circular(30),
                  color: themeData ? Colors.grey[300] : Colors.grey[900],
                ),
                child: Center(
                  child: Slider(
                      inactiveColor: Colors.greenAccent.shade100,
                      thumbColor: Colors.greenAccent,
                      activeColor: Colors.greenAccent,
                      max: 10,
                      min: 0,
                      value: _currentValue,
                      onChanged: (value) {
                        setState(() {
                          _currentValue = value;
                        });
                      }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
