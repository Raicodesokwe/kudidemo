import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kudidemo/widgets/neon_button.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class TermsDialog extends StatelessWidget {
  const TermsDialog({Key? key}) : super(key: key);

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
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      insetPadding: EdgeInsets.all(30),
      content: SizedBox(
        width: size.width * 0.97,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Text('TERMS OF SERVICE')),
              SizedBox(
                height: size.height * 0.06,
              ),
              Text(
                'PLEASE READ THE FOLLOWING TERMS OF SERVICE BEFORE USING OUR MOBILE APPLICATION (OUR APP). BY UTILIZING OUR APP, YOU AGREE TO BE BOUND BY THE CURRENT VERSION OF OUR TERMS OF SERVICE AND PRIVACY POLICY',
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Text('1.GENERAL'),
              SizedBox(
                height: size.height * 0.03,
              ),
              Text(
                'Welcome to the app of Plan it("Plan it","We","Us"). Plan it provides productivity tools and wellness services for users who download and install our App(hereinafter the App may be referred to as the "Service")',
                style: GoogleFonts.prompt(
                    fontWeight: FontWeight.w300, fontSize: 14),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Text('2.ACCEPTANCE OF THE TERMS OF SERVICE'),
              SizedBox(
                height: size.height * 0.03,
              ),
              Text(
                'We ask that you review and abide by these Terms and Conditions, our Privacy Policy, and any other terms and conditions that may appear on the site from time to time. Your use of the service constitutes your agreement to these Terms and Conditions, and we reserve the right to revise these Terms and Conditions at any time without notice to you. When we make revisions, we will post them on the Site and they will be effective immediately upon posting. You agree to check this section periodically to be aware of any changes to the Terms and Conditions. YOUR CONTINUED USE OF THE SERVICES AFTER THE POSTING OF ANY OF THE REVISIONS SHALL BE CONSIDERED YOUR AGREEMENT TO THE MODIFIED TERMS AND CONDITIONS. If you do not agree to these Terms and Conditions, please do not use the service \n\nThe service is offered and available to users who are 13 years of age or older. By using the Services, you represent and warrant that you are of legal age to form a binding contract with Plan it and meet all of the foregoing eligibility requirements. If you do not meet all of these requirements , you must not access or use the Service. \n\nThe Service and its Content are intended solely for personal and commercial use by you. Any use of the Service or its content other than for personal and commercial purposes is prohibited. ',
                style: GoogleFonts.prompt(
                    fontWeight: FontWeight.w300, fontSize: 14),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Text('3.WHAT WE OWN'),
              SizedBox(
                height: size.height * 0.03,
              ),
              Text(
                'Unless otherwise noted, all material and services available through the App, and all materials provided by or through the Service, its affiliates,subsidiaries , employees, agents, licensors or other commercial partners including, but not limited to software, all informational text, software documentation, design of and "look and feel," layout, photographs, graphics, audio, video, messages, interactive and instant messaging, design and functions, files, documents, images, or other materials, whether publicly posted or privately transmitted as well as all derivative works thereof (collectively, the "Content") are the intellectual property of Plan it, our licensors, and our contributors. The content is protected by copyright, trademark, trade-dress, and any other applicable national or international intellectual property laws. All Plan it trademarks and service marks, logos, slogans and taglines are the property of Plan it. All other trademarks, service marks, logos, slogans and taglines are the property of their respective owners. Except as otherwise specifically provided herein , nothing should be construed as granting any license or right to use any trademarks, service marks, logos, slogans or taglines displayed on Plan it without our express written permission, or the express written permissiion of such third party that may own the trademark, sevice mark, logo, slogan or tagline.',
                style: GoogleFonts.prompt(
                    fontWeight: FontWeight.w300, fontSize: 14),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Text('4.OUR LICENSE TO YOU'),
              SizedBox(
                height: size.height * 0.03,
              ),
              Text(
                'Subject to this Agreement, Plan It hereby grants you a limited, revocable, non-transferable and non-exclusive license to use the Service through a user identification reference provided by Plan it ("User ID") to the extent, and only to the extent, necessary to access and use our Service in accordance with the terms of this Agreement. This license does not permit you, and you agree not to: store,copy,reproduce, republish, modify, upload, post, translate, scrape, rent, lease, loan, sell,distribute, transfer, transmit, display, decompile, reverse engineer, reverse assemble, decipher or otherwise attempt to discover any programming code or any source code used in or with the Service or otherwise distribute in any way the components of the Service other than as specifically permitted in this Agreement . You may not sell,assign, sublicense, grant a security interest in or otherwise attempt to transfer any right in the Service, create derivative works based on or in any manner commercially exploit the Service, in whole or in part, other than as expressly permitted in this Agreement. Any use of the Service for any purpose other than as specifically permitted herein or without our prior consent or the prior written consent of our licensors , as applicable, is expressly prohibited. We reserve all rights not expressly granted in this Agreement ',
                style: GoogleFonts.prompt(
                    fontWeight: FontWeight.w300, fontSize: 14),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Text('5.USE OF THE SERVICE'),
              SizedBox(
                height: size.height * 0.03,
              ),
              Text(
                'We reserve the right to withdraw or amend our App and any Service or material we provide, including the text messaging and wellness audio content services, in our sole discretion without notice. We will not be liable if, for any reason , all or any part of the Service is unavailable at any time or for any period. From time to time we may restrict access to some parts of our App, to users including registered users.\n\nTo access the Service, you may be asked to provide certain registration details or other information, including a valid cellphone number. It is a condition of your use of the Service that all the information you provide to use the Service is correct, current and complete. You agree that all the information you provide to register with this App, including but not limited to through the use of any interactive features, is governed by our Privacy Policy, and you consent to all actions we take with respect to your information consistent with our Privacy Policy.\n\nPurchasers of our Premium subscription will need to pay for a monthly or annual subscription prior to unlocking Premium content. All sales are final, and we do not offer refunds for our Premium subscription.\n\nIf you choose, or are provided with, a user name, password or any other piece of information as part of our security procedures, you must treat such information as confidential, and you must not disclose it to any other person or entity. You also acknowledge that your account is personal to you and agree not to provide any other person with access to the Service using your user name, password, cell phone number, or other security information. You agree to notify us immediately of any unauthorized access to or use of your user name, password, cell phone number, or other security information. You agree to notify us immediately of any unauthorized access to or use of your username or password or any other breach of security. You also agree to ensure that you exit from your account at the end of each session. You should use particular caution when accessing your account when accessing your account from a public or shared computer so that others are not able to view or record your password or other personal information\n\nWe have the right to disable any user name,cellphone number associated with an account,password, or other identifier, whether chosen by you or provided by us, at any time in our sole discretion for any or no reason, including if, in our opinion, you have violated any provision of these Terms of Service or our Privacy Policy.',
                style: GoogleFonts.prompt(
                    fontWeight: FontWeight.w300, fontSize: 14),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Text('6.RELIANCE ON THE INFORMATION SENT'),
              SizedBox(
                height: size.height * 0.03,
              ),
              Text(
                'The information sent via Plan it\'s Service, or presented on or through our App, is made available solely for general information purposes. We do not warrant the accuracy, completeness, usefulness, or safety of this information. Any reliance you place on such information is strictly at your own risk. WE DISCLAIM ALL LIABILITY AND RESPONSIBILITY ARISING FROM ANY RELIANCE PLACED ON SUCH INFORMATION BY YOU OR ANY OTHER VISITOR TO THE SITE, OR BY ANYONE WHO MAY BE INFORMED OF ANY OF ITS CONTENTS OR THE CONTENTS OF THE SERVICE',
                style: GoogleFonts.prompt(
                    fontWeight: FontWeight.w300, fontSize: 14),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Text('7.CONTENT YOU PROVIDE TO US'),
              SizedBox(
                height: size.height * 0.03,
              ),
              Text(
                'You are legally responsible for all information, data, text, software, music, sound, photographs, graphics, video, messages or other Content uploaded, posted or stored in connection with your use of the Plan it Service. Plan it is not responsible for your Content. You hereby grant Plan it a worldwide, royalty-free, non-exclusive license to host and use the Content in order to provide you with the Service, and hereby represent and warrant that you have all the rights necessary to grant us such license. You are responsible for any Content that may be lost or unrecoverable through your use of the Service. You are encouraged to archive your Content regularly and frequently\n\nAll information we collect through our App, or through your use of the Service is subject to our Privacy Policy. By using the App, you consent to all actions taken by us with respect to your information in compliance with the Privacy Policy ',
                style: GoogleFonts.prompt(
                    fontWeight: FontWeight.w300, fontSize: 14),
              )
            ],
          ),
        ),
      ),
      actions: [
        Center(
          child: Container(
            height: 60,
            child: Center(
              child: Icon(
                Icons.check,
                size: 30,
                color: themeData ? Colors.white : Colors.black,
              ),
            ),
            width: 60,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: themeData ? Colors.black : Colors.white),
          ),
        )
      ],
    );
  }
}
