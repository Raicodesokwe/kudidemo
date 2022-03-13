import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kudidemo/pages/pospage.dart';
import 'package:kudidemo/theme/theme.dart';
import 'package:kudidemo/pages/walletpage.dart';
import 'package:provider/provider.dart';

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
    final themeData = Provider.of<ThemeProvider>(context).darkTheme;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomePage(),
          PosPage(),
          WalletPage(),
        ],
      ),
      bottomNavigationBar: BounceTabBar(
        initialIndex: 0,
        onTabChanged: (index) {
          print(index);
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: themeData ? Colors.black87 : Colors.grey,
        items: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/homepage.png",
                scale: 20,
                color: themeData ? Colors.white : Colors.black,
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
              Image.asset(
                "assets/pos.png",
                scale: 20,
                color: themeData ? Colors.white : Colors.black,
              ),
              Text(
                'pos',
                style: GoogleFonts.prompt(fontSize: 12),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/funds.png",
                scale: 20,
                color: themeData ? Colors.white : Colors.black,
              ),
              Text(
                'wallet',
                style: GoogleFonts.prompt(fontSize: 12),
              )
            ],
          ),
        ],
      ),
    );
  }
}
