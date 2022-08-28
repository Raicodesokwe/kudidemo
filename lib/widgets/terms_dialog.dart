import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kudidemo/widgets/neon_button.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class TermsDialog extends StatefulWidget {
  const TermsDialog({Key? key}) : super(key: key);

  @override
  State<TermsDialog> createState() => _TermsDialogState();
}

class _TermsDialogState extends State<TermsDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

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
    return Platform.isIOS
        ? ScaleTransition(
            scale: scaleAnimation,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: CupertinoAlertDialog(
                content: SizedBox(
                  width: size.width * 0.97,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: Text(
                          'TERMS OF SERVICE',
                          style: GoogleFonts.prompt(
                              fontWeight: FontWeight.w700, fontSize: 18),
                        )),
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
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Text('8.GEOGRAPHIC RESTRICTION'),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Text(
                          'The owner of the Service is based in Kenya. Access to the Service may not be legal by certain persons or in certain countries. If you access the Service from outside Kenya, you do so on your own initiative and are responsible for compliance with local laws and cell phone provider rates and terms of service.',
                          style: GoogleFonts.prompt(
                              fontWeight: FontWeight.w300, fontSize: 14),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Text('9.IMAGE AND VIDEO'),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Text(
                          'Plan it may send or display images, audio and video(the "Material") from time to time. The types of Material Users are authorized to access on the Site includes Material commissioned by Plan it, embedded Material, Material we believe to be covered by the Fair Use Doctrine, Material from photographic archive and video vendors and Material supplied to our staff or released into the public domain by public relations and marketing companies for press purposes.',
                          style: GoogleFonts.prompt(
                              fontWeight: FontWeight.w300, fontSize: 14),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Text('10.COPYRIGHT NOTICES'),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Text(
                          'If Plan it publishes Material that you think infringes your copyright, please email us at Planit@gmail.com and we will address your concerns. We reserve the right at our sole discretion, to remove any content without prior notice.',
                          style: GoogleFonts.prompt(
                              fontWeight: FontWeight.w300, fontSize: 14),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Text('11.ACCURACY OF INFORMATION'),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Text(
                          'While we strive for accuracy, information on the site may sometimes contain errors or inaccuracies. Plan it does not make any warranty as to the correctness or reliability of the App\'s content or any other text messages we send out to Users.',
                          style: GoogleFonts.prompt(
                              fontWeight: FontWeight.w300, fontSize: 14),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Text('12.EMAIL CORRESPONDENCE'),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Text(
                          'Emails sent to any of our @Plan it or @Planit email addresses are considered our property. You can read more about this in our Privacy Policy',
                          style: GoogleFonts.prompt(
                              fontWeight: FontWeight.w300, fontSize: 14),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Text('13.LINKS'),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Text(
                          'Our App will occasionally contain links to, and quotation of, Material from other sites. Plan it is responsible for neither the content nor the privacy pracitces of other sites. We encourage our users to be aware when they leave the Plan it App and to read the privacy statements of any website that may collect personally identifiable information.',
                          style: GoogleFonts.prompt(
                              fontWeight: FontWeight.w300, fontSize: 14),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Text('14.INFORMATION SECURITY'),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Text(
                          'No data transmission over the internet can be guaranteed to be 100% safe. Thus, we cannot warrant that your information will be absolutely secure. Plan it has a variety of safeguards- technical, administrative and physical- in place to help protect against unauthorized access to, use, or disclosure of user information.',
                          style: GoogleFonts.prompt(
                              fontWeight: FontWeight.w300, fontSize: 14),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Text(
                            '15.THE LEGAL STUFF - DISCLAIMER AND LIMITATION OF LIABILITY'),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Text(
                          'EXCEPT AS EXPRESSLY SET FORTH IN THESE TERMS AND CONDITIONS, YOU EXPRESSLY UNDERSTAND AND AGREE THAT THE APP, CONTENT,PRODUCTS AND/OR SERVICE ON THE APP OR ELSEWHERE ARE PROVIDED "AS IS" AND ON AN "AS AVAILABLE" BASIS. TO THE FULLEST EXTENT PERMITTED BY LAW AND EXCEPT AS EXPRESSLY SET FORTH IN THESE TERMS AND CONDITIONS, PLAN IT DISCLAIMS ALL WARRANTIES, EXPRESS OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT, DOES NOT REPRESENT OR WARRANT THAT THE APP WILL BE UNINTERRUPTED OR ERROR-FREE, THAT ANY DEFECTS WILL BE CORRECTED, OR THAT THE APP OR THE SERVER THAT MAKES THE APP AVAILABLE ARE FREE FROM VIRUSES OR ANYTHING ELSE HARMFUL. FURTHER, EXCEPT AS EXPRESLY SET FORTH IN THESE TERMS AND CONDITIONS, PLAN IT MAKES NO WARRANTIES OR REPRESENTATIONS ABOUT THE ACCURACY, ADEQUACY, USEFULNESS, RELIABILITY OR COMPLETENESS OF THE APP, TEXT MESSAGES, SERVICES, CONTENT, THE CONTENT OF ANY THIRD-PARTY SITE LINKED TO OR FROM THIS SITE,COMMENTS, INFORMATION, INFORMATION PROVIDED BY US OR OUR VENDORS, OR ANY OTHER ITEMS OR MATERIALS ON THE APP OR LINKED TO OR FROM THE APP.\n\nPLAN IT ASSUMES NO LIABLITY OR RESPONSIBILITY FOR\n(A) ANY ERRORS, MISTAKES OR INACCURACIES OF THE CONTENT, PRODUCTS, SERVICES, INFORMATION, APP AND MATERIALS SET FORTH ON OR MADE AVAILABLE THROUGH THE SITE\n(B) PERSONAL INJURY OR PROPERTY DAMAGE, OF ANY NATURE WHATSOEVER, RESULTING FROM YOUR ACCESS TO OR USE OF THE APP, PRODUCTS, SERVICES OR ANY THIRD PARTY SITE(S), PRODUCTS OR SERVICES\n(C) ANY UNAUTHORIZED ACCESS TO OR USE OF THE SERVERS THAT HOST THE APP OR ANY THIRD PARTY SITE(S) AND/OR ANY AND ALL PERSONAL INFORMATION STORED THEREIN\n(D) ANY INTERRUPTION OR CESSATION OF TRANSMISSION TO OR FROM THE APP OR THIRD PARTY SITE(S)\n(E) ANY BUGS, VIRUSES, TROJAN HORSES OR THE LIKE WHICH MAY BE TRANSMITTED TO OR THROUGH THE APP OR ANY THIRD PARTY SITE(S) BY PLAN IT OR ANY THIRD PARTY, AND/OR\n(F) ANY ERRORS OR OMISSIONS IN THE NETWORK OR ANY CONTENT, INFORMATION AND MATERIALS(INCLUDING BUT NOT LIMITED TO THIRD PARTY SITE(S)) OR FOR ANY LOSS OR DAMAGE OF ANY KIND INCURRED AS A RESULT OF THE USE OF ANY OF THE FOREGOING.\n\nNO PERSON (INCLUDING ANY AGENT, DEALER OR REPRESENTATIVE OF PLAN IT) IS AUTHORIZED TO MAKE ANY REPRESENTATION OR WARRANTY CONCERNING PLAN IT\'S APP AND SERVICES, AND YOU ACKNOWLEDGE AND AGREE THAT YOU HAVE NOT RELIED ON ANY OTHER WARRANTIES OR REPRESENTATIONS.\n\nIN NO EVENT SHALL PLAN IT OR ITS SUBSIDIARIES, AFFILIATES, AGENTS, SUPPLIERS, VENDORS, MANUFACTURERS OR DISTRIBUTORS BE LIABLE FOR ANY INDIRECT, SPECIAL, PUNITIVE, INCIDENTAL, EXEMPLARY OR CONSEQUENTIAL DAMAGES, INCLUDING WITHOUT LIMITATION, DAMAGES FOR LOSS OF USE, DATA, REVENUE OR PROFITS, BUSINESS INTERRUPTION, OR LOSS OF BUSINESS OPPORTUNITY OR GOODWILL, ARISING FROM OR IN CONNECTION WITH\n(A) THE USE OF, OR INABILITY TO USE, THE APP;\n(B)THE PROVISION OF OR FAILURE TO PROVIDE SERVICES, MATERIALS, CONTENT OR SOFTWARE AVAILABLE FROM OR THROUGH THE APP OR ANY OTHER THIRD PARTY WEBSITE(S); OR\n(C)THE CONDUCT OF OTHER USERS OF THE SITE, WHETHER BASED ON CONTRACT, TORT, NEGLIGENCE, STRICT LIABLITY OR OTHERWISE, EVEN IF PLAN IT HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES. YOU ASSUME COMPLETE RESPONSIBILITY FOR YOUR USE OF THE APP. YOUR SOLE REMEDY AGAINST PLAN IT FOR DISSATISFACTION WITH THE APP OR ANY CONTENT IS TO STOP USING THE APP. THAT SAID, IF PLAN IT IS FOUND TO BE LIABLE TO YOU FOR ANY DAMAGE OR LOSS ARISING OUT OF OR WHICH IS IN ANY WAY CONNECTEDWITH YOUR USE OF THE APP, ANY CONTENT OR PURCHASE OF ANY PRODUCTS OR SERVICES ON OR THROUGH THE APP, PLAN IT\'S LIABILITY SHALL NOT EXCEED \$100.00 IN THE AGGREGATE',
                          style: GoogleFonts.prompt(
                              fontWeight: FontWeight.w300, fontSize: 14),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Text('16.ARBITRATION'),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Text(
                          'For any dispute you have with Plan it, you agree to first contact us at Planit@gmail.com and attempt to resolve the dispute with us informally. If Plan it has not been able to resolve the dispute with you informally, we each agree to resolve any claim, dispute or controversy(excluding claims for injunctive or other equitable relief) arising out of or in connection with or relating to these terms by binding arbitration by the Kenyan branch of the Chartered Institute of Arbitatrators("Institute"), except as provided herein. Unless you and Plan it agree otherwise, the arbitration will be conducted in the county where Plan it\'s headquarters are located(Nairobi, Kenya). Each party will be responsible for paying any filing, administrative and arbitrator fees in accordance with the rules of the Kenya Branch of the Chartered Institute of Arbitrators',
                          style: GoogleFonts.prompt(
                              fontWeight: FontWeight.w300, fontSize: 14),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Text('17.TERMINATION'),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Text(
                          'These Terms of Service are effective unless and until terminated by either you or Plan it. You may terminate these terms of service as they apply to you at any time by ceasing to use the App. Plan it may terminate these Terms of Service at any time immediately and without notice, and accordingly deny you access to the App, for any reason in its sole discretion; however, the provisions in these Terms of Service that relate to the intellectual property, indemnification, disclaimer, limitation of liability, and choice of law shall survive any termination of these Terms of Service',
                          style: GoogleFonts.prompt(
                              fontWeight: FontWeight.w300, fontSize: 14),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Text('18.ENTIRE AGREEMENT'),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Text(
                          'These Terms of Service (together with our Privacy Policy, which is expressly incorporated herein by reference and which can be accessed on this App, and any other Terms that may appear on the App from time to time) contain the entire understanding and agreement between you and Plan it with respect to your use and access of this App, and supersede all prior agreements, terms conditions and understandings, both written and oral, with respect to such use and access of the App. No representation, statement or inducement, whether oral or written, not contained in these Terms of Service( and any other terms that may appear on the App from time to time) or the Privacy Policy shall bind any party to this agreement. No additional or different terms or conditions will be binding upon us unless expressly agreed to in writing by an officer of Plan it. No other representative has any authority to waive , alter, vary or add to these Terms of Service. Before using this App, please read through all referenced documents carefully',
                          style: GoogleFonts.prompt(
                              fontWeight: FontWeight.w300, fontSize: 14),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Text('19.SEVERABILITY'),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Text(
                          'If any portion of these Terms of Service is held to be invalid or unenforceable, the invalid or unenforceable portion shall be modified in accordance with the applicable law with a provision that most closely reflects the intention of the original provision, and the remainder of these Terms of Service shall remain in full force and effect. The failure of Plan it to insist upon or enforce strict performance by you of any provision of these Terms of Service shall not be construed as a waiver of any provision or right.',
                          style: GoogleFonts.prompt(
                              fontWeight: FontWeight.w300, fontSize: 14),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Text('20.CHANGES TO OUR TERMS OF SERVICE'),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Text(
                          'We may revise and update these Terms of Service from time to time in our sole discretion. All changes are effective immediately when we post them, and apply to all access to and use of the App thereafter. However, any changes to the dispute resolution provisions set forth in Governing Law and Jurisdiction and Arbitration above will not apply to any disputes for which the parties have actual notice on or prior to the date the change is posted on the App.\n\nYour continued use of the App following the posting of revised Terms of Service means that you accept and agree to the changes. You are expected to check this page from time to time so that you are aware of any changes, as they are binding on you.',
                          style: GoogleFonts.prompt(
                              fontWeight: FontWeight.w300, fontSize: 14),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Text('NOTICE OF CHANGES AND USE OF TERMS OF SERVICE'),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Text(
                          'We may provide notice to you relating to the App and/or these Terms of Service by sending an e-mail to your last known e-mail address and any such notice shall be deemed given and received on the day it is sent. A printed version of these Terms of Service and of any notices given to you in electronic form or otherwise shall be admissible in judicial or administrative proceedings based upon or relating to these Terms of Service to the same extent and subject to the same conditions as other business documents and records originally generated and mantained in printed form. You agree that any course of action that you may desire to bring arising out of or related to these Terms of Service and/or the App must commence within one (1) year after the cause of action arises. You may not use the App or export the content in violation of Kenyan export laws and regulations. If you access the App from a location outside Kenya, you are responsible for compliance with all local laws.',
                          style: GoogleFonts.prompt(
                              fontWeight: FontWeight.w300, fontSize: 14),
                        )
                      ],
                    ),
                  ),
                ),
                actions: [
                  CupertinoDialogAction(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'ok',
                        style: GoogleFonts.prompt(
                            color: themeData ? Colors.black : Colors.white),
                      ))
                ],
              ),
            ),
          )
        : ScaleTransition(
            scale: scaleAnimation,
            child: AlertDialog(
              backgroundColor: themeData ? Colors.grey[300] : Colors.grey[900],
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
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text('8.GEOGRAPHIC RESTRICTION'),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        'The owner of the Service is based in Kenya. Access to the Service may not be legal by certain persons or in certain countries. If you access the Service from outside Kenya, you do so on your own initiative and are responsible for compliance with local laws and cell phone provider rates and terms of service.',
                        style: GoogleFonts.prompt(
                            fontWeight: FontWeight.w300, fontSize: 14),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text('9.IMAGE AND VIDEO'),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        'Plan it may send or display images, audio and video(the "Material") from time to time. The types of Material Users are authorized to access on the Site includes Material commissioned by Plan it, embedded Material, Material we believe to be covered by the Fair Use Doctrine, Material from photographic archive and video vendors and Material supplied to our staff or released into the public domain by public relations and marketing companies for press purposes.',
                        style: GoogleFonts.prompt(
                            fontWeight: FontWeight.w300, fontSize: 14),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text('10.COPYRIGHT NOTICES'),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        'If Plan it publishes Material that you think infringes your copyright, please email us at Planit@gmail.com and we will address your concerns. We reserve the right at our sole discretion, to remove any content without prior notice.',
                        style: GoogleFonts.prompt(
                            fontWeight: FontWeight.w300, fontSize: 14),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text('11.ACCURACY OF INFORMATION'),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        'While we strive for accuracy, information on the site may sometimes contain errors or inaccuracies. Plan it does not make any warranty as to the correctness or reliability of the App\'s content or any other text messages we send out to Users.',
                        style: GoogleFonts.prompt(
                            fontWeight: FontWeight.w300, fontSize: 14),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text('12.EMAIL CORRESPONDENCE'),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        'Emails sent to any of our @Plan it or @Planit email addresses are considered our property. You can read more about this in our Privacy Policy',
                        style: GoogleFonts.prompt(
                            fontWeight: FontWeight.w300, fontSize: 14),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text('13.LINKS'),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        'Our App will occasionally contain links to, and quotation of, Material from other sites. Plan it is responsible for neither the content nor the privacy pracitces of other sites. We encourage our users to be aware when they leave the Plan it App and to read the privacy statements of any website that may collect personally identifiable information.',
                        style: GoogleFonts.prompt(
                            fontWeight: FontWeight.w300, fontSize: 14),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text('14.INFORMATION SECURITY'),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        'No data transmission over the internet can be guaranteed to be 100% safe. Thus, we cannot warrant that your information will be absolutely secure. Plan it has a variety of safeguards- technical, administrative and physical- in place to help protect against unauthorized access to, use, or disclosure of user information.',
                        style: GoogleFonts.prompt(
                            fontWeight: FontWeight.w300, fontSize: 14),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                          '15.THE LEGAL STUFF - DISCLAIMER AND LIMITATION OF LIABILITY'),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        'EXCEPT AS EXPRESSLY SET FORTH IN THESE TERMS AND CONDITIONS, YOU EXPRESSLY UNDERSTAND AND AGREE THAT THE APP, CONTENT,PRODUCTS AND/OR SERVICE ON THE APP OR ELSEWHERE ARE PROVIDED "AS IS" AND ON AN "AS AVAILABLE" BASIS. TO THE FULLEST EXTENT PERMITTED BY LAW AND EXCEPT AS EXPRESSLY SET FORTH IN THESE TERMS AND CONDITIONS, PLAN IT DISCLAIMS ALL WARRANTIES, EXPRESS OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT, DOES NOT REPRESENT OR WARRANT THAT THE APP WILL BE UNINTERRUPTED OR ERROR-FREE, THAT ANY DEFECTS WILL BE CORRECTED, OR THAT THE APP OR THE SERVER THAT MAKES THE APP AVAILABLE ARE FREE FROM VIRUSES OR ANYTHING ELSE HARMFUL. FURTHER, EXCEPT AS EXPRESLY SET FORTH IN THESE TERMS AND CONDITIONS, PLAN IT MAKES NO WARRANTIES OR REPRESENTATIONS ABOUT THE ACCURACY, ADEQUACY, USEFULNESS, RELIABILITY OR COMPLETENESS OF THE APP, TEXT MESSAGES, SERVICES, CONTENT, THE CONTENT OF ANY THIRD-PARTY SITE LINKED TO OR FROM THIS SITE,COMMENTS, INFORMATION, INFORMATION PROVIDED BY US OR OUR VENDORS, OR ANY OTHER ITEMS OR MATERIALS ON THE APP OR LINKED TO OR FROM THE APP.\n\nPLAN IT ASSUMES NO LIABLITY OR RESPONSIBILITY FOR\n(A) ANY ERRORS, MISTAKES OR INACCURACIES OF THE CONTENT, PRODUCTS, SERVICES, INFORMATION, APP AND MATERIALS SET FORTH ON OR MADE AVAILABLE THROUGH THE SITE\n(B) PERSONAL INJURY OR PROPERTY DAMAGE, OF ANY NATURE WHATSOEVER, RESULTING FROM YOUR ACCESS TO OR USE OF THE APP, PRODUCTS, SERVICES OR ANY THIRD PARTY SITE(S), PRODUCTS OR SERVICES\n(C) ANY UNAUTHORIZED ACCESS TO OR USE OF THE SERVERS THAT HOST THE APP OR ANY THIRD PARTY SITE(S) AND/OR ANY AND ALL PERSONAL INFORMATION STORED THEREIN\n(D) ANY INTERRUPTION OR CESSATION OF TRANSMISSION TO OR FROM THE APP OR THIRD PARTY SITE(S)\n(E) ANY BUGS, VIRUSES, TROJAN HORSES OR THE LIKE WHICH MAY BE TRANSMITTED TO OR THROUGH THE APP OR ANY THIRD PARTY SITE(S) BY PLAN IT OR ANY THIRD PARTY, AND/OR\n(F) ANY ERRORS OR OMISSIONS IN THE NETWORK OR ANY CONTENT, INFORMATION AND MATERIALS(INCLUDING BUT NOT LIMITED TO THIRD PARTY SITE(S)) OR FOR ANY LOSS OR DAMAGE OF ANY KIND INCURRED AS A RESULT OF THE USE OF ANY OF THE FOREGOING.\n\nNO PERSON (INCLUDING ANY AGENT, DEALER OR REPRESENTATIVE OF PLAN IT) IS AUTHORIZED TO MAKE ANY REPRESENTATION OR WARRANTY CONCERNING PLAN IT\'S APP AND SERVICES, AND YOU ACKNOWLEDGE AND AGREE THAT YOU HAVE NOT RELIED ON ANY OTHER WARRANTIES OR REPRESENTATIONS.\n\nIN NO EVENT SHALL PLAN IT OR ITS SUBSIDIARIES, AFFILIATES, AGENTS, SUPPLIERS, VENDORS, MANUFACTURERS OR DISTRIBUTORS BE LIABLE FOR ANY INDIRECT, SPECIAL, PUNITIVE, INCIDENTAL, EXEMPLARY OR CONSEQUENTIAL DAMAGES, INCLUDING WITHOUT LIMITATION, DAMAGES FOR LOSS OF USE, DATA, REVENUE OR PROFITS, BUSINESS INTERRUPTION, OR LOSS OF BUSINESS OPPORTUNITY OR GOODWILL, ARISING FROM OR IN CONNECTION WITH\n(A) THE USE OF, OR INABILITY TO USE, THE APP;\n(B)THE PROVISION OF OR FAILURE TO PROVIDE SERVICES, MATERIALS, CONTENT OR SOFTWARE AVAILABLE FROM OR THROUGH THE APP OR ANY OTHER THIRD PARTY WEBSITE(S); OR\n(C)THE CONDUCT OF OTHER USERS OF THE SITE, WHETHER BASED ON CONTRACT, TORT, NEGLIGENCE, STRICT LIABLITY OR OTHERWISE, EVEN IF PLAN IT HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES. YOU ASSUME COMPLETE RESPONSIBILITY FOR YOUR USE OF THE APP. YOUR SOLE REMEDY AGAINST PLAN IT FOR DISSATISFACTION WITH THE APP OR ANY CONTENT IS TO STOP USING THE APP. THAT SAID, IF PLAN IT IS FOUND TO BE LIABLE TO YOU FOR ANY DAMAGE OR LOSS ARISING OUT OF OR WHICH IS IN ANY WAY CONNECTEDWITH YOUR USE OF THE APP, ANY CONTENT OR PURCHASE OF ANY PRODUCTS OR SERVICES ON OR THROUGH THE APP, PLAN IT\'S LIABILITY SHALL NOT EXCEED \$100.00 IN THE AGGREGATE',
                        style: GoogleFonts.prompt(
                            fontWeight: FontWeight.w300, fontSize: 14),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text('16.ARBITRATION'),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        'For any dispute you have with Plan it, you agree to first contact us at Planit@gmail.com and attempt to resolve the dispute with us informally. If Plan it has not been able to resolve the dispute with you informally, we each agree to resolve any claim, dispute or controversy(excluding claims for injunctive or other equitable relief) arising out of or in connection with or relating to these terms by binding arbitration by the Kenyan branch of the Chartered Institute of Arbitatrators("Institute"), except as provided herein. Unless you and Plan it agree otherwise, the arbitration will be conducted in the county where Plan it\'s headquarters are located(Nairobi, Kenya). Each party will be responsible for paying any filing, administrative and arbitrator fees in accordance with the rules of the Kenya Branch of the Chartered Institute of Arbitrators',
                        style: GoogleFonts.prompt(
                            fontWeight: FontWeight.w300, fontSize: 14),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text('17.TERMINATION'),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        'These Terms of Service are effective unless and until terminated by either you or Plan it. You may terminate these terms of service as they apply to you at any time by ceasing to use the App. Plan it may terminate these Terms of Service at any time immediately and without notice, and accordingly deny you access to the App, for any reason in its sole discretion; however, the provisions in these Terms of Service that relate to the intellectual property, indemnification, disclaimer, limitation of liability, and choice of law shall survive any termination of these Terms of Service',
                        style: GoogleFonts.prompt(
                            fontWeight: FontWeight.w300, fontSize: 14),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text('18.ENTIRE AGREEMENT'),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        'These Terms of Service (together with our Privacy Policy, which is expressly incorporated herein by reference and which can be accessed on this App, and any other Terms that may appear on the App from time to time) contain the entire understanding and agreement between you and Plan it with respect to your use and access of this App, and supersede all prior agreements, terms conditions and understandings, both written and oral, with respect to such use and access of the App. No representation, statement or inducement, whether oral or written, not contained in these Terms of Service( and any other terms that may appear on the App from time to time) or the Privacy Policy shall bind any party to this agreement. No additional or different terms or conditions will be binding upon us unless expressly agreed to in writing by an officer of Plan it. No other representative has any authority to waive , alter, vary or add to these Terms of Service. Before using this App, please read through all referenced documents carefully',
                        style: GoogleFonts.prompt(
                            fontWeight: FontWeight.w300, fontSize: 14),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text('19.SEVERABILITY'),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        'If any portion of these Terms of Service is held to be invalid or unenforceable, the invalid or unenforceable portion shall be modified in accordance with the applicable law with a provision that most closely reflects the intention of the original provision, and the remainder of these Terms of Service shall remain in full force and effect. The failure of Plan it to insist upon or enforce strict performance by you of any provision of these Terms of Service shall not be construed as a waiver of any provision or right.',
                        style: GoogleFonts.prompt(
                            fontWeight: FontWeight.w300, fontSize: 14),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text('20.CHANGES TO OUR TERMS OF SERVICE'),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        'We may revise and update these Terms of Service from time to time in our sole discretion. All changes are effective immediately when we post them, and apply to all access to and use of the App thereafter. However, any changes to the dispute resolution provisions set forth in Governing Law and Jurisdiction and Arbitration above will not apply to any disputes for which the parties have actual notice on or prior to the date the change is posted on the App.\n\nYour continued use of the App following the posting of revised Terms of Service means that you accept and agree to the changes. You are expected to check this page from time to time so that you are aware of any changes, as they are binding on you.',
                        style: GoogleFonts.prompt(
                            fontWeight: FontWeight.w300, fontSize: 14),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text('NOTICE OF CHANGES AND USE OF TERMS OF SERVICE'),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        'We may provide notice to you relating to the App and/or these Terms of Service by sending an e-mail to your last known e-mail address and any such notice shall be deemed given and received on the day it is sent. A printed version of these Terms of Service and of any notices given to you in electronic form or otherwise shall be admissible in judicial or administrative proceedings based upon or relating to these Terms of Service to the same extent and subject to the same conditions as other business documents and records originally generated and mantained in printed form. You agree that any course of action that you may desire to bring arising out of or related to these Terms of Service and/or the App must commence within one (1) year after the cause of action arises. You may not use the App or export the content in violation of Kenyan export laws and regulations. If you access the App from a location outside Kenya, you are responsible for compliance with all local laws.',
                        style: GoogleFonts.prompt(
                            fontWeight: FontWeight.w300, fontSize: 14),
                      )
                    ],
                  ),
                ),
              ),
              actions: [
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 60,
                      child: Center(
                        child: Icon(
                          Icons.check,
                          size: 30,
                          color: themeData ? Colors.black : Colors.white,
                        ),
                      ),
                      width: 60,
                      decoration: decorator.copyWith(
                          shape: BoxShape.circle,
                          color:
                              themeData ? Colors.grey[300] : Colors.grey[900]),
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
