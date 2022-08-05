import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kudidemo/theme/seconddecoration.dart';
import 'package:kudidemo/providers/theme_provider.dart';
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
              'Track Finances',
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
                          text: 'Weekly expenses',
                        ),
                        Tab(
                          text: 'Monthly expenses',
                        ),
                      ]),
                ),
              ),
              SizedBox(
                height: size.height * 0.3,
              ),
              Center(
                child: Text('Coming soon...',
                    style: GoogleFonts.prompt(fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
