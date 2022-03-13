import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kudidemo/theme/seconddecoration.dart';
import 'package:kudidemo/theme/theme.dart';
import 'package:provider/provider.dart';

import '../theme/concavedecoration.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  String selected = 'one';

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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
            child: Text(
              'Wallet Top-up',
              style: GoogleFonts.prompt(
                  fontWeight: FontWeight.w500,
                  fontSize: 23,
                  color: themeData ? Colors.black : Colors.white),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                height: 60,
                decoration: themeData
                    ? SecondDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        depression: 10,
                        colors: [
                            Color.fromRGBO(216, 213, 208, 1),
                            Colors.white
                          ])
                    : ConcaveDecoration(
                        colors: [Colors.black, Colors.grey.shade800],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        depression: 10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TabBar(
                      labelColor: themeData ? Colors.black : Colors.white,
                      labelStyle:
                          GoogleFonts.nunitoSans(fontWeight: FontWeight.w600),
                      indicator: BoxDecoration(
                          color:
                              themeData ? Colors.grey[300] : Colors.grey[900],
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: themeData
                              ? [
                                  BoxShadow(
                                      color: Colors.grey[500]!,
                                      offset: Offset(
                                        4,
                                        4,
                                      ),
                                      blurRadius: 15,
                                      spreadRadius: 1),
                                  BoxShadow(
                                      color: Colors.white,
                                      offset: Offset(
                                        -4,
                                        -4,
                                      ),
                                      blurRadius: 15,
                                      spreadRadius: 1)
                                ]
                              : [
                                  BoxShadow(
                                      color: Colors.black,
                                      //  Colors.grey[500]!,
                                      offset: Offset(
                                        4,
                                        4,
                                      ),
                                      blurRadius: 15,
                                      // spreadRadius: 1
                                      spreadRadius: 5),
                                  BoxShadow(
                                      color: Colors.grey.shade800,
                                      // Colors.white,
                                      offset: Offset(
                                        -4,
                                        -4,
                                      ),
                                      blurRadius: 15,
                                      spreadRadius: 1)
                                ]),
                      tabs: const [
                        Tab(
                          text: 'Bank Transfer',
                        ),
                        Tab(
                          text: 'Card Payment',
                        ),
                      ]),
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Enter Amount',
                        style: GoogleFonts.prompt(fontSize: 18),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/naira.png",
                            scale: 15,
                            color: themeData ? Colors.black : Colors.white,
                          ),
                          selected == 'one'
                              ? Text('500',
                                  style: GoogleFonts.openSans(
                                    fontSize: 35,
                                    fontWeight: FontWeight.w700,
                                  ))
                              : selected == 'two'
                                  ? Text('1000',
                                      style: GoogleFonts.openSans(
                                        fontSize: 35,
                                        fontWeight: FontWeight.w700,
                                      ))
                                  : selected == 'three'
                                      ? Text('2000',
                                          style: GoogleFonts.openSans(
                                            fontSize: 35,
                                            fontWeight: FontWeight.w700,
                                          ))
                                      : selected == 'four'
                                          ? Text('5000',
                                              style: GoogleFonts.openSans(
                                                fontSize: 35,
                                                fontWeight: FontWeight.w700,
                                              ))
                                          : selected == 'five'
                                              ? Text('7500',
                                                  style: GoogleFonts.openSans(
                                                    fontSize: 35,
                                                    fontWeight: FontWeight.w700,
                                                  ))
                                              : Text('7500',
                                                  style: GoogleFonts.openSans(
                                                    fontSize: 35,
                                                    fontWeight: FontWeight.w700,
                                                  ))
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                      height: 70,
                      width: 70,
                      child: Image.asset(
                        "assets/aro.png",
                        scale: 15,
                        color: themeData ? Colors.black : Colors.white,
                      ),
                      decoration: decorator.copyWith(
                          shape: BoxShape.circle, color: Colors.greenAccent))
                ],
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ActionChip(
                    label: Text(
                      'N1000',
                      style: GoogleFonts.openSans(fontSize: 20,color: Colors.black),
                    ),
                    backgroundColor: Colors.greenAccent,
                    onPressed: () {
                      setState(() {
                        selected = 'two';
                      });
                    },
                  ),
                  ActionChip(
                    label: Text(
                      'N2000',
                      style: GoogleFonts.openSans(fontSize: 20,color: Colors.black),
                    ),
                    backgroundColor: Colors.greenAccent,
                    onPressed: () {
                      setState(() {
                        selected = 'three';
                      });
                    },
                  ),
                  ActionChip(
                    label: Text(
                      'N5000',
                      style: GoogleFonts.openSans(fontSize: 20,color: Colors.black),
                    ),
                    backgroundColor: Colors.greenAccent,
                    onPressed: () {
                      setState(() {
                        selected = 'four';
                      });
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
