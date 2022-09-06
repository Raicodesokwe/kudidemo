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
                  color: Colors.black),
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
                decoration: decorator.copyWith(
                    color: Theme.of(context).backgroundColor),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TabBar(
                      labelColor: Colors.black,
                      labelStyle:
                          GoogleFonts.nunitoSans(fontWeight: FontWeight.w600),
                      indicator: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
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
                        ],
                      ),
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
