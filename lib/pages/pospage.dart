import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kudidemo/theme/theme.dart';
import 'package:provider/provider.dart';

class PosPage extends StatelessWidget {
  const PosPage({Key? key}) : super(key: key);

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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'Get POS',
            style: GoogleFonts.prompt(
                fontWeight: FontWeight.w500,
                fontSize: 23,
                color: themeData ? Colors.black : Colors.white),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.03,
          ),
          Center(
            child: Text('How would you like to get a POS terminal?',
                style: GoogleFonts.prompt(fontSize: 17)),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Container(
            width: size.width * 0.85,
            height: size.height * 0.13,
            decoration: decorator.copyWith(
                color: themeData ? Colors.grey[300] : Colors.grey[900],
                borderRadius: BorderRadius.circular(10.0)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    child: Center(
                      child: Image.asset(
                        "assets/postwo.png",
                        scale: 20,
                        color: themeData ? Colors.white : Colors.black,
                      ),
                    ),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: themeData ? Colors.black : Colors.white),
                  ),
                  SizedBox(
                    width: size.width * 0.07,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Buy POS',
                            style: GoogleFonts.prompt(
                                fontSize: 18, fontWeight: FontWeight.w500)),
                        Spacer(),
                        Text(
                          'Make an outright payment of \n N75,000 and own a POS terminal',
                          style: GoogleFonts.prompt(fontSize: 12),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          Container(
            width: size.width * 0.85,
            height: size.height * 0.13,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    child: Center(
                      child: Stack(clipBehavior: Clip.none, children: [
                        Image.asset(
                          "assets/pos.png",
                          scale: 20,
                          color: themeData ? Colors.white : Colors.black,
                        ),
                        Positioned(
                            bottom: 19,
                            child: Container(
                              height: 15,
                              width: 30,
                              child: Center(
                                  child: Text(
                                'new',
                                style: GoogleFonts.prompt(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              )),
                              decoration: BoxDecoration(
                                  color: Colors.redAccent.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(5)),
                            ))
                      ]),
                    ),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: themeData ? Colors.black : Colors.white),
                  ),
                  SizedBox(
                    width: size.width * 0.07,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('Lease POS',
                                style: GoogleFonts.prompt(
                                    fontSize: 18, fontWeight: FontWeight.w500)),
                            SizedBox(
                              width: size.width * 0.07,
                            ),
                            Container(
                              height: 20,
                              width: 50,
                              child: Center(
                                  child: Text(
                                'new',
                                style: GoogleFonts.prompt(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              )),
                              decoration: BoxDecoration(
                                  color: Colors.redAccent.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(15)),
                            )
                          ],
                        ),
                        Spacer(),
                        Text(
                          'Lease a pos for just N20,000 \n Terms and conditions apply',
                          style: GoogleFonts.prompt(fontSize: 12),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            decoration: decorator.copyWith(
                color: themeData ? Colors.grey[300] : Colors.grey[900],
                borderRadius: BorderRadius.circular(10.0)),
          ),
        ],
      ),
    );
  }
}
