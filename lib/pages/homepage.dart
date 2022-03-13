import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:kudidemo/theme/changethemebtn.dart';
import 'package:kudidemo/theme/theme.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          primary: false,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 150,
              width: 150,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: Image.asset(
                    "assets/pic.jpg",
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          actions: [ChangeThemeButtonWidget()],
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [
            Text(
              'Good morning, Toluwanimi',
              style: GoogleFonts.prompt(fontSize: 17),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/naira.png",
                  scale: 15,
                  color: themeData ? Colors.black : Colors.white,
                ),
                Text('100,000',
                    style: GoogleFonts.openSans(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ))
              ],
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Container(
              height: size.height * 0.07,
              width: size.width * 0.4,
              decoration: decorator.copyWith(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.greenAccent),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Fund wallet',
                    style: GoogleFonts.prompt(color: Colors.black),
                  ),
                  SizedBox(
                    width: size.width * 0.02,
                  ),
                  Image.asset(
                    "assets/withdraw.png",
                    scale: 20,
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(
                    width: size.width * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 30),
                    child: Container(
                      height: size.height * 0.1,
                      width: size.width * 0.7,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/promotion.png",
                              scale: 20,
                              color: themeData ? Colors.black : Colors.white,
                            ),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                            Text(
                                'Dear customer, please note that the price \n for DSTV compact has been increased from \n N6,800 to N7,000',
                                style: GoogleFonts.prompt(
                                  fontSize: 10,
                                ))
                          ],
                        ),
                      ),
                      decoration: decorator.copyWith(
                          color:
                              themeData ? Colors.grey[300] : Colors.grey[900],
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.02,
                  ),
                  Container(
                    height: size.height * 0.1,
                    width: size.width * 0.7,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/alert.png",
                            scale: 20,
                            color: themeData ? Colors.black : Colors.white,
                          ),
                          SizedBox(
                            width: size.width * 0.03,
                          ),
                          Text(
                              'Dear customer, please note that the price \n for DSTV compact has been increased from \n N6,800 to N7,000',
                              style: GoogleFonts.prompt(
                                fontSize: 10,
                              ))
                        ],
                      ),
                    ),
                    decoration: decorator.copyWith(
                        color: themeData ? Colors.grey[300] : Colors.grey[900],
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  SizedBox(
                    width: size.width * 0.02,
                  ),
                ],
              ),
            ),
            Container(
              width: size.width * 0.85,
              height: size.height * 0.2,
              decoration: decorator.copyWith(
                  color: themeData ? Colors.grey[300] : Colors.grey[900],
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                children: [
                  Text(
                    'What do you want to do?',
                    style: GoogleFonts.prompt(),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: size.height * 0.12,
                          width: size.width * 0.25,
                          child: Column(
                            children: [
                              SizedBox(
                                height: size.height * 0.005,
                              ),
                              Container(
                                height: 30,
                                width: 30,
                                child: Image.asset(
                                  "assets/transfer.png",
                                  scale: 20,
                                  color:
                                      themeData ? Colors.black : Colors.white,
                                ),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.blue),
                              ),
                              SizedBox(
                                height: size.height * 0.005,
                              ),
                              Text(
                                'Transfer \n money',
                                style: GoogleFonts.prompt(),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                              color: Colors.lightBlueAccent.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                        Container(
                          height: size.height * 0.12,
                          width: size.width * 0.25,
                          child: Column(
                            children: [
                              SizedBox(
                                height: size.height * 0.005,
                              ),
                              Container(
                                height: 30,
                                width: 30,
                                child: Image.asset(
                                  "assets/phone.png",
                                  scale: 20,
                                  color:
                                      themeData ? Colors.black : Colors.white,
                                ),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.blue),
                              ),
                              SizedBox(
                                height: size.height * 0.005,
                              ),
                              Text(
                                'Airtime and \n data topup',
                                style: GoogleFonts.prompt(),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                              color: Colors.lightBlueAccent.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                        Container(
                          height: size.height * 0.12,
                          width: size.width * 0.25,
                          child: Column(
                            children: [
                              SizedBox(
                                height: size.height * 0.005,
                              ),
                              Container(
                                height: 30,
                                width: 30,
                                child: Image.asset(
                                  "assets/money.png",
                                  scale: 20,
                                  color:
                                      themeData ? Colors.black : Colors.white,
                                ),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.blue),
                              ),
                              SizedBox(
                                height: size.height * 0.005,
                              ),
                              Text(
                                'Withdraw \n money',
                                style: GoogleFonts.prompt(),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                              color: Colors.lightBlueAccent.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            Container(
              width: size.width * 0.85,
              height: size.height * 0.2,
              child: Column(
                children: [
                  Text(
                    'Bills',
                    style: GoogleFonts.prompt(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(
                      color: themeData ? Colors.black54 : Colors.white54,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: size.height * 0.12,
                          width: size.width * 0.25,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/faucet.png",
                                scale: 20,
                                color: themeData ? Colors.black : Colors.white,
                              ),
                              Text(
                                'Water bill',
                                style: GoogleFonts.prompt(),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            border: Border.all(
                              width: 4,
                              color: themeData ? Colors.black : Colors.white,
                            ),
                            color: Colors.blue,
                          ),
                        ),
                        Container(
                          height: size.height * 0.12,
                          width: size.width * 0.25,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/invoice.png",
                                scale: 20,
                                color: themeData ? Colors.black : Colors.white,
                              ),
                              Text(
                                'Electricity bill',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.prompt(),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            border: Border.all(
                              width: 4,
                              color: themeData ? Colors.black : Colors.white,
                            ),
                            color: Colors.blue,
                          ),
                        ),
                        Container(
                          height: size.height * 0.12,
                          width: size.width * 0.25,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/rent.png",
                                scale: 20,
                                color: themeData ? Colors.black : Colors.white,
                              ),
                              Text(
                                'Rent bill',
                                style: GoogleFonts.prompt(),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            border: Border.all(
                              width: 4,
                              color: themeData ? Colors.black : Colors.white,
                            ),
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              decoration: decorator.copyWith(
                  color: themeData ? Colors.grey[300] : Colors.grey[900],
                  borderRadius: BorderRadius.circular(10.0)),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.greenAccent,
              boxShadow: [
                BoxShadow(
                    blurRadius: 8,
                    spreadRadius: 6,
                    offset: const Offset(0, 3),
                    color: Colors.black.withOpacity(0.2))
              ],
              shape: BoxShape.rectangle,
            ),
            width: 60,
            height: 60,
            child:  Image.asset(
                                "assets/helpline.png",
                                scale: 20,
                                color:  Colors.black ,
                              ),
          ),
        ),
      ),
    );
  }
}
