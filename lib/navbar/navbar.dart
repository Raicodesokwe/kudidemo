import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kudidemo/pages/stats_page.dart';

import 'package:kudidemo/pages/walletpage.dart';

import 'bouncetabbar.dart';
import '../pages/homepage.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageTransitionSwitcher(
        duration: Duration(seconds: 1),
        transitionBuilder: (child, animation, secondaryAnimation) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: IndexedStack(
          key: ValueKey<int>(_currentIndex),
          index: _currentIndex,
          children: [
            HomePage(),
            StatsPage(),
            WalletPage(),
          ],
        ),
      ),
      bottomNavigationBar: BounceTabBar(
        initialIndex: 0,
        onTabChanged: (index) {
          print(index);
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Colors.black87,
        items: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/homepage.png",
                scale: 20,
                color: Colors.white,
              ),
              Text(
                'home',
                style: GoogleFonts.prompt(fontSize: 12),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                FontAwesomeIcons.chartLine,
                size: 28,
                color: Colors.white,
              ),
              Text(
                'stats',
                style: GoogleFonts.prompt(fontSize: 12),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/funds.png",
                scale: 20,
                color: Colors.white,
              ),
              Text(
                'finances',
                style: GoogleFonts.prompt(fontSize: 12),
              )
            ],
          ),
        ],
      ),
    );
  }
}
