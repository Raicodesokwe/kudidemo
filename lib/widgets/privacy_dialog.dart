import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class PrivacyDialog extends StatefulWidget {
  const PrivacyDialog({Key? key}) : super(key: key);

  @override
  State<PrivacyDialog> createState() => _PrivacyDialogState();
}

class _PrivacyDialogState extends State<PrivacyDialog>
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
                            'PRIVACY POLICY',
                            style: GoogleFonts.prompt(
                                fontWeight: FontWeight.w700, fontSize: 18),
                          )),
                          SizedBox(
                            height: size.height * 0.06,
                          ),
                          Text(
                            'Plan it ("we" or "us" or "our") respects the privacy of our users ("user" or "you"). This Privacy Policy explains how we collect, use, disclose and safeguard your information when you visit ou mobile Application ( the "App"). Please read this Privacy Policy carefully. IF YOU DO NOT AGREE WITH THE TERMS OF THIS PRIVACY POLICY, PLEASE DO NOT ACCESS THE APP.\n\nWe reserve the right to make changes to this Privacy Policy at any time and for any reason. We will alert you about any changes by updating the "Last updated" date of this Privacy Policy.You are encouraged to periodically review this Privacy Policy to stay informed of updates. You will be deemed to have been made aware of, will be subject to and will be deemed to have accepted the changes in any revised Privacy Policy by your continued use of the App after the date such revised Privacy Policy is posted.\n\nThis Privacy Policy does not apply to the third-party online/mobile store from which you install the App or make payments, including any in-game virtual items, which may also collect and use data about you. We are not responsible for any of the data collected by any such third party.',
                            style: GoogleFonts.prompt(
                                fontWeight: FontWeight.w300, fontSize: 14),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text('COLLECTION OF YOUR INFORMATION'),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text(
                            'We may collect information about you in a variety of ways. The information we may collect via the App depends on the content and materials you use and includes:',
                            style: GoogleFonts.prompt(
                                fontWeight: FontWeight.w300, fontSize: 14),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text('Personal Data'),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text(
                            'We collect and store all personal information related to your App profile, which you voluntarily give us either upon sign-up or through continued use of the App:\n-First and last name\n-Nickname\n-Email address\n-Birthday\n-Demographic location\n-Timezone\n-Photos uploaded',
                            style: GoogleFonts.prompt(
                                fontWeight: FontWeight.w300, fontSize: 14),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text('Derivative Data and Uploaded Media'),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text(
                            'Information our servers automatically collect when you access the App, such as your native actions that are integral to the App, actions taken when creating entries, editing entries and uploading media to the App. As such, we may also request access to your device\'s photo roll or camera in order for us to upload your media to the app. Any media uploaded in this fashion, will be collected and stored on our servers. If you wish to change our access or permissions, you may do so in your device\'s settings.',
                            style: GoogleFonts.prompt(
                                fontWeight: FontWeight.w300, fontSize: 14),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text('Geo-Location Information'),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text(
                            'We may request access or permission to and track location-based information from your mobile device, either continuously or while you are using the App, to provide location-based services. If you wish to change our access or permissions, you may do so in your device\'s settings.',
                            style: GoogleFonts.prompt(
                                fontWeight: FontWeight.w300, fontSize: 14),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text('Mobile Device Access'),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text(
                            'We may request access or permissions to certain features from your mobile device\'s reminders, and other features. If you wish to change our access or permissions, you may do so in your device\'s settings.',
                            style: GoogleFonts.prompt(
                                fontWeight: FontWeight.w300, fontSize: 14),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text('Mobile Device Data'),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text(
                            'Device information such as your mobile device ID number, model and manufacturer, version of your operating system, phone number, country, location, and any other data you choose to provide.',
                            style: GoogleFonts.prompt(
                                fontWeight: FontWeight.w300, fontSize: 14),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text('Push Notifications'),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text(
                            'We may request to send you push notifications regarding your account or the App. If you wish to opt-out from receiving these types of communications, you may turn them off in your device\'s settings.',
                            style: GoogleFonts.prompt(
                                fontWeight: FontWeight.w300, fontSize: 14),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text('Data from Contests, Giveaways and Surveys.'),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text(
                            'Personal and other information you may provide when entering contests or giveaways and/or responding to surveys',
                            style: GoogleFonts.prompt(
                                fontWeight: FontWeight.w300, fontSize: 14),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text('USE OF YOUR INFORMATION'),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text(
                            'Having accurate information about you permits us to provide you with a smooth, efficient and customized experience. Specifically, we may use information collected about you via the App to:\n-Generate a personal profile about you to make future visits to the App more personalized.\n-Monitor and analyze usage and trends to improve your experience with the App.\n-Notify you of updates to the App.\n-Request feedback and contact you about your use of the App.\n-To improve our product(we continually strive to improve Plan it based on your feedback)\n-We may periodically send promotional emails about new products, special offers or other information which we think you may find interesting using the email address which you have provided.\n\nWe will also require you to link either your iTunes Account, ApplePay Account or Google Play Account with our App if you wish to purchase one of our Premium subscriptions. This does not give us access to your credit card or banking information, but is needed so that we can process your purchases/subscriptions.',
                            style: GoogleFonts.prompt(
                                fontWeight: FontWeight.w300, fontSize: 14),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text('DISCLOSURE OF YOUR INFORMATION'),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text(
                            'We may share information we have collected about you in certain situations. Your information may be disclosed as follows:\n\nWe will not sell,distribute or lease your personal information to unrelated third parties unless we have your permission or are required by law to do so. We may need to send your personal information to unrelated third parties unless we have your permission or are required by law to do so. We may need to send your personal information to our third-party vendors, who are under contractual obligations to keep this information confidential. We may also use your personal information to send you promotional information about third parties which we think you may find interesting if you tell us that you wish this to happen. Finally, if we ever sell Plan It App, or participate in a merger or consolidation and our User Data is one of the assets involved in the sale, your personal information will be part of this sale or transfer.\n\nWe may also disclose your personal information:\n-To comply with any court order, law or legal process, including to respond to any government or regulatory request.\n-To enforce or apply our Terms of Service and other agreements, including for billing and collection purposes.\n-If we believe disclosure is necessary or appropriate to protect the rights,property or safety of Plan it Apps, our customers or others. This may include exchanging information with other companies and organizations for the purposes of fraud protection and credit risk reduction.',
                            style: GoogleFonts.prompt(
                                fontWeight: FontWeight.w300, fontSize: 14),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text('TRACKING TECHNOLOGIES'),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text('Cookies and Web Beacons'),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text(
                            'We may use cookies, web beacons, tracking pixels, and other tracking technologies on the App to help customize the App and improve your experience. For more information on how we use cookies, please refer to our Cookie Policy posted on the App, which is incorporated into this Privacy Policy. By using the App, you agree to be bound by our Cookie Policy.',
                            style: GoogleFonts.prompt(
                                fontWeight: FontWeight.w300, fontSize: 14),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text('Website Analytics'),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text(
                            'We may also partner with selected third-party vendors such as Google Analytics, Facebook Business Manager, to allow tracking technologies and remarketing services on the App through the use of first party cookies and third-party cookies, to, among other things, analyze and track users\' use of the App, determine the popularity of certain content ,and better understand online activity. By accessing the App, you consent the collection and use of your information by these third-party vendors. However, if you do not want any information to be collected and used by tracking technologies, you can visit the third-party vendor or Network Advertising initiative Opt-Out Tool or Digital Advertising Alliance Opt-Out Tool.\n\nYou should be aware that getting a new computer, installing a new browser, upgrading an existing browser or erasing or otherwise altering your browser\'s cookies files may also clear certain opt-out cookies, plug-ins or settings.',
                            style: GoogleFonts.prompt(
                                fontWeight: FontWeight.w300, fontSize: 14),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text('THIRD-PARTY WEBSITES'),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text(
                            'The App may contain links to third-party websites and applications of interest, including advertisements and external services that are not affiliated with us. Once you have used these links to leave the App, any information you provide to these third parties is not covered by this Privacy Policy and we cannot guarantee the safety and privacy of your information. Before visiting and providing any information to any third-party websites, you should inform yourself of the privacy policies and practices (if any) of the third party responsible for that website and you should take those steps necessary to, in your discretion, protect the privacy of your information. We are not responsible for the content or privacy and security practices and policies of any third-parties, including other sites, services or applications that may be linked to or from the App.\n\nYou should exercise caution and look at the privacy statement applicable to the website in question.',
                            style: GoogleFonts.prompt(
                                fontWeight: FontWeight.w300, fontSize: 14),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text('SECURITY OF YOUR INFORMATION'),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text(
                            'We use administrative,technical and physical security measures to help protect your personal information. While we have taken reasonable steps to secure the personal information you provide to us, please be aware that despite our efforts, no security measures are perfect or impenetrable and no method of data transmission can be guaranteed against any interception or other type of misuse. Any information disclosed online is vulnerable to interception and misuse by unauthorized parties. Therefore we cannot guarantee complete security if you provide personal information.',
                            style: GoogleFonts.prompt(
                                fontWeight: FontWeight.w300, fontSize: 14),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text('CHILDREN UNDER THE AGE OF 13'),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text(
                            'Our service is not intended for children under 13 years of age. No one under the age of 13 may provide any personal information to or on the App. We do not knowingly collect personal information from children under 13. If you are under 13, do not use or provide any information on this App, or on or through any of its features /functionality, make any purchases through the App, use any of the interactive or public comment features that may be available on this App, or provide any information about yourself to us, including your name, address, telephone number, e-mail address or any screen name or username you may use.\n\nIf we learn that we have collected or received personal information from a child under 13 without verification of parental consent,we will delete that information. If you believe we might have any information from or about a child under 13,please contact us at Planit@gmail.com.',
                            style: GoogleFonts.prompt(
                                fontWeight: FontWeight.w300, fontSize: 14),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text('CONTROLS FOR DO-NOT-TRACK FEATURES'),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text(
                            'Most web browsers and some mobile operating systems include a Do-Not-Track("DNT") feature or setting you can activate to signal your privacy preference not to have data about your online browsing activities monitored and collected. No uniform technology standard for recognizing and implementing DNT signals has been finalized. As such, we do not currently respond to DNT browser signals or any other mechanism that automatically communicates your choice not to be tracked online. If a standard for online tracking is daopted that we must follow in the future, we will inform you about that practice in a revised version of this Privacy Policy.',
                            style: GoogleFonts.prompt(
                                fontWeight: FontWeight.w300, fontSize: 14),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text('OPTIONS REGARDING YOUR\nINFORMATION'),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text('Account Information'),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text(
                            'You can review and change your personal information by logging into your profile through the App and visisting your account profile page.\n\nYou may also send us an e-mail at Planit@gmail.com to request access to, correct or delete any personal information that you have provided to us. We may not be able to delete your personal information except by also deleting your user account. We also may not accomodate a request to change information if we believe the change would violate any law or legal requirement, or cause the information to be incorrect.\n\nWhen we receive a termination or deletion request, all data that is deemed non-critical to the cases outlined above, will be retained at most 30 days in which period we will ensure complete deletion of such data from all databases and back-ups.\n\nUpon your request to terminate your account, we will deactivate or delete your account and information from our active databases. However, some information may be retained in our files to prevent fraud, troubleshoot problems, assist with any investigations, enforce our Terms of Service and/or comply with legal requirements.',
                            style: GoogleFonts.prompt(
                                fontWeight: FontWeight.w300, fontSize: 14),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text('Email and Communications'),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text(
                            'If you no longer wish to receive correspondence, emails or other communications from us, you may opt out by:\n\n-Contacting us using the contact information provided below.\n-Clicking the opt-out button at the bottom of any promotional email you receive.\n\nIf you no longer wish to receive correspondence,emails or other communications from third parties, you are responsible for contacting the third party directly.',
                            style: GoogleFonts.prompt(
                                fontWeight: FontWeight.w300, fontSize: 14),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text(
                              'NOTICE TO USERS FROM THE EUROPEAN ECONOMIC AREA'),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text(
                            'If you are visiting and using the Services from the European Economic Area ("EEA"),please be aware that you are sending information (including personal data) to the United States and India where our partner platform\'s servers are located. Our partners and/or staff operating outside the EEA may process this information. The information may then be transferred within the United States or India or back out of the United States or India to other countries outside your country of residence, depending on the type of information and how we store it. These countries(including the United States and India) may not necessarily have data protection laws as comprehensive or protective as those in your country of residence; however, our collection,storage and use of your personal data will at times continue to be governed by this Privacy Policy.\n\nBY SUPPLYING YOUR PERSONAL INFORMATION TO US, YOU EXPRESSLY AGREE TO THE TRANSFER OF YOUR PERSONAL INFORMATION OUT OF THE EEA, AND TO THE PROCESSING OF YOUR INFORMATIONIN THE U.S AND INDIA,SUBJECT TO THIS PRIVACY POLICY.',
                            style: GoogleFonts.prompt(
                                fontWeight: FontWeight.w300, fontSize: 14),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text('YOUR CONSENT'),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text(
                            'By using our App, you consent to our privacy policy.',
                            style: GoogleFonts.prompt(
                                fontWeight: FontWeight.w300, fontSize: 14),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text('CONTACT US'),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text(
                            'If you have questions or comments about this Privacy Policy, please contact us at:\n\nPlan it\nNairobi,Kenya\nPlanit@gmail.com',
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
                          style: GoogleFonts.prompt(color: Colors.black),
                        ))
                  ],
                )),
          )
        : ScaleTransition(
            scale: scaleAnimation,
            child: AlertDialog(
              backgroundColor: Theme.of(context).backgroundColor,
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
                      Center(child: Text('PRIVACY POLICY')),
                      SizedBox(
                        height: size.height * 0.06,
                      ),
                      Text(
                        'Plan it ("we" or "us" or "our") respects the privacy of our users ("user" or "you"). This Privacy Policy explains how we collect, use, disclose and safeguard your information when you visit ou mobile Application ( the "App"). Please read this Privacy Policy carefully. IF YOU DO NOT AGREE WITH THE TERMS OF THIS PRIVACY POLICY, PLEASE DO NOT ACCESS THE APP.\n\nWe reserve the right to make changes to this Privacy Policy at any time and for any reason. We will alert you about any changes by updating the "Last updated" date of this Privacy Policy.You are encouraged to periodically review this Privacy Policy to stay informed of updates. You will be deemed to have been made aware of, will be subject to and will be deemed to have accepted the changes in any revised Privacy Policy by your continued use of the App after the date such revised Privacy Policy is posted.\n\nThis Privacy Policy does not apply to the third-party online/mobile store from which you install the App or make payments, including any in-game virtual items, which may also collect and use data about you. We are not responsible for any of the data collected by any such third party.',
                        style: GoogleFonts.prompt(
                            fontWeight: FontWeight.w300, fontSize: 14),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text('COLLECTION OF YOUR INFORMATION'),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        'We may collect information about you in a variety of ways. The information we may collect via the App depends on the content and materials you use and includes:',
                        style: GoogleFonts.prompt(
                            fontWeight: FontWeight.w300, fontSize: 14),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text('Personal Data'),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        'We collect and store all personal information related to your App profile, which you voluntarily give us either upon sign-up or through continued use of the App:\n-First and last name\n-Nickname\n-Email address\n-Birthday\n-Demographic location\n-Timezone\n-Photos uploaded',
                        style: GoogleFonts.prompt(
                            fontWeight: FontWeight.w300, fontSize: 14),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text('Derivative Data and Uploaded Media'),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        'Information our servers automatically collect when you access the App, such as your native actions that are integral to the App, actions taken when creating entries, editing entries and uploading media to the App. As such, we may also request access to your device\'s photo roll or camera in order for us to upload your media to the app. Any media uploaded in this fashion, will be collected and stored on our servers. If you wish to change our access or permissions, you may do so in your device\'s settings',
                        style: GoogleFonts.prompt(
                            fontWeight: FontWeight.w300, fontSize: 14),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text('Geo-Location Information'),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        'We may request access or permission to and track location-based information from your mobile device, either continuously or while you are using the App, to provide location-based services. If you wish to change our access or permissions, you may do so in your device\'s settings',
                        style: GoogleFonts.prompt(
                            fontWeight: FontWeight.w300, fontSize: 14),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text('Mobile Device Access'),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        'We may request access or permissions to certain features from your mobile device\'s reminders, and other features. If you wish to change our access or permissions, you may do so in your device\'s settings.',
                        style: GoogleFonts.prompt(
                            fontWeight: FontWeight.w300, fontSize: 14),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text('Mobile Device Data'),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        'Device information such as your mobile device ID number, model and manufacturer, version of your operating system, phone number, country, location, and any other data you choose to provide.',
                        style: GoogleFonts.prompt(
                            fontWeight: FontWeight.w300, fontSize: 14),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text('Push Notifications'),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        'We may request to send you push notifications regarding your account or the App. If you wish to opt-out from receiving these types of communications, you may turn them off in your device\'s settings.',
                        style: GoogleFonts.prompt(
                            fontWeight: FontWeight.w300, fontSize: 14),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text('Data from Contests, Giveaways and Surveys.'),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        'Personal and other information you may provide when entering contests or giveaways and/or responding to surveys',
                        style: GoogleFonts.prompt(
                            fontWeight: FontWeight.w300, fontSize: 14),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text('USE OF YOUR INFORMATION'),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        'Having accurate information about you permits us to provide you with a smooth, efficient and customized experience. Specifically, we may use information collected about you via the App to:\n-Generate a personal profile about you to make future visits to the App more personalized.\n-Monitor and analyze usage and trends to improve your experience with the App.\n-Notify you of updates to the App.\n-Request feedback and contact you about your use of the App.\n-To improve our product(we continually strive to improve Plan it based on your feedback)\n-We may periodically send promotional emails about new products, special offers or other information which we think you may find interesting using the email address which you have provided.\n\nWe will also require you to link either your iTunes Account, ApplePay Account or Google Play Account with our App if you wish to purchase one of our Premium subscriptions. This does not give us access to your credit card or banking information, but is needed so that we can process your purchases/subscriptions.',
                        style: GoogleFonts.prompt(
                            fontWeight: FontWeight.w300, fontSize: 14),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text('DISCLOSURE OF YOUR INFORMATION'),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        'We may share information we have collected about you in certain situations. Your information may be disclosed as follows:\n\nWe will not sell,distribute or lease your personal information to unrelated third parties unless we have your permission or are required by law to do so. We may need to send your personal information to unrelated third parties unless we have your permission or are required by law to do so. We may need to send your personal information to our third-party vendors, who are under contractual obligations to keep this information confidential. We may also use your personal information to send you promotional information about third parties which we think you may find interesting if you tell us that you wish this to happen. Finally, if we ever sell Plan It App, or participate in a merger or consolidation and our User Data is one of the assets involved in the sale, your personal information will be part of this sale or transfer.\n\nWe may also disclose your personal information:\n-To comply with any court order, law or legal process, including to respond to any government or regulatory request.\n-To enforce or apply our Terms of Service and other agreements, including for billing and collection purposes.\n-If we believe disclosure is necessary or appropriate to protect the rights,property or safety of Plan it Apps, our customers or others. This may include exchanging information with other companies and organizations for the purposes of fraud protection and credit risk reduction.',
                        style: GoogleFonts.prompt(
                            fontWeight: FontWeight.w300, fontSize: 14),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text('TRACKING TECHNOLOGIES'),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text('Cookies and Web Beacons'),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        'We may use cookies, web beacons, tracking pixels, and other tracking technologies on the App to help customize the App and improve your experience. For more information on how we use cookies, please refer to our Cookie Policy posted on the App, which is incorporated into this Privacy Policy. By using the App, you agree to be bound by our Cookie Policy.',
                        style: GoogleFonts.prompt(
                            fontWeight: FontWeight.w300, fontSize: 14),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text('Website Analytics'),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        'We may also partner with selected third-party vendors such as Google Analytics, Facebook Business Manager, to allow tracking technologies and remarketing services on the App through the use of first party cookies and third-party cookies, to, among other things, analyze and track users\' use of the App, determine the popularity of certain content ,and better understand online activity. By accessing the App, you consent the collection and use of your information by these third-party vendors. However, if you do not want any information to be collected and used by tracking technologies, you can visit the third-party vendor or Network Advertising initiative Opt-Out Tool or Digital Advertising Alliance Opt-Out Tool.\n\nYou should be aware that getting a new computer, installing a new browser, upgrading an existing browser or erasing or otherwise altering your browser\'s cookies files may also clear certain opt-out cookies, plug-ins or settings.',
                        style: GoogleFonts.prompt(
                            fontWeight: FontWeight.w300, fontSize: 14),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text('THIRD-PARTY WEBSITES'),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        'The App may contain links to third-party websites and applications of interest, including advertisements and external services that are not affiliated with us. Once you have used these links to leave the App, any information you provide to these third parties is not covered by this Privacy Policy and we cannot guarantee the safety and privacy of your information. Before visiting and providing any information to any third-party websites, you should inform yourself of the privacy policies and practices (if any) of the third party responsible for that website and you should take those steps necessary to, in your discretion, protect the privacy of your information. We are not responsible for the content or privacy and security practices and policies of any third-parties, including other sites, services or applications that may be linked to or from the App.\n\nYou should exercise caution and look at the privacy statement applicable to the website in question.',
                        style: GoogleFonts.prompt(
                            fontWeight: FontWeight.w300, fontSize: 14),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text('SECURITY OF YOUR INFORMATION'),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        'We use administrative,technical and physical security measures to help protect your personal information. While we have taken reasonable steps to secure the personal information you provide to us, please be aware that despite our efforts, no security measures are perfect or impenetrable and no method of data transmission can be guaranteed against any interception or other type of misuse. Any information disclosed online is vulnerable to interception and misuse by unauthorized parties. Therefore we cannot guarantee complete security if you provide personal information.',
                        style: GoogleFonts.prompt(
                            fontWeight: FontWeight.w300, fontSize: 14),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text('CHILDREN UNDER THE AGE OF 13'),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        'Our service is not intended for children under 13 years of age. No one under the age of 13 may provide any personal information to or on the App. We do not knowingly collect personal information from children under 13. If you are under 13, do not use or provide any information on this App, or on or through any of its features /functionality, make any purchases through the App, use any of the interactive or public comment features that may be available on this App, or provide any information about yourself to us, including your name, address, telephone number, e-mail address or any screen name or username you may use.\n\nIf we learn that we have collected or received personal information from a child under 13 without verification of parental consent,we will delete that information. If you believe we might have any information from or about a child under 13,please contact us at Planit@gmail.com.',
                        style: GoogleFonts.prompt(
                            fontWeight: FontWeight.w300, fontSize: 14),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text('CONTROLS FOR DO-NOT-TRACK FEATURES'),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        'Most web browsers and some mobile operating systems include a Do-Not-Track("DNT") feature or setting you can activate to signal your privacy preference not to have data about your online browsing activities monitored and collected. No uniform technology standard for recognizing and implementing DNT signals has been finalized. As such, we do not currently respond to DNT browser signals or any other mechanism that automatically communicates your choice not to be tracked online. If a standard for online tracking is daopted that we must follow in the future, we will inform you about that practice in a revised version of this Privacy Policy.',
                        style: GoogleFonts.prompt(
                            fontWeight: FontWeight.w300, fontSize: 14),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text('OPTIONS REGARDING YOUR\nINFORMATION'),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text('Account Information'),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        'You can review and change your personal information by logging into your profile through the App and visisting your account profile page.\n\nYou may also send us an e-mail at Planit@gmail.com to request access to, correct or delete any personal information that you have provided to us. We may not be able to delete your personal information except by also deleting your user account. We also may not accomodate a request to change information if we believe the change would violate any law or legal requirement, or cause the information to be incorrect.\n\nWhen we receive a termination or deletion request, all data that is deemed non-critical to the cases outlined above, will be retained at most 30 days in which period we will ensure complete deletion of such data from all databases and back-ups.\n\nUpon your request to terminate your account, we will deactivate or delete your account and information from our active databases. However, some information may be retained in our files to prevent fraud, troubleshoot problems, assist with any investigations, enforce our Terms of Service and/or comply with legal requirements.',
                        style: GoogleFonts.prompt(
                            fontWeight: FontWeight.w300, fontSize: 14),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text('Email and Communications'),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        'If you no longer wish to receive correspondence, emails or other communications from us, you may opt out by:\n\n-Contacting us using the contact information provided below.\n-Clicking the opt-out button at the bottom of any promotional email you receive.\n\nIf you no longer wish to receive correspondence,emails or other communications from third parties, you are responsible for contacting the third party directly.',
                        style: GoogleFonts.prompt(
                            fontWeight: FontWeight.w300, fontSize: 14),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text('NOTICE TO USERS FROM THE EUROPEAN ECONOMIC AREA'),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        'If you are visiting and using the Services from the European Economic Area ("EEA"),please be aware that you are sending information (including personal data) to the United States and India where our partner platform\'s servers are located. Our partners and/or staff operating outside the EEA may process this information. The information may then be transferred within the United States or India or back out of the United States or India to other countries outside your country of residence, depending on the type of information and how we store it. These countries(including the United States and India) may not necessarily have data protection laws as comprehensive or protective as those in your country of residence; however, our collection,storage and use of your personal data will at times continue to be governed by this Privacy Policy.\n\nBY SUPPLYING YOUR PERSONAL INFORMATION TO US, YOU EXPRESSLY AGREE TO THE TRANSFER OF YOUR PERSONAL INFORMATION OUT OF THE EEA, AND TO THE PROCESSING OF YOUR INFORMATIONIN THE U.S AND INDIA,SUBJECT TO THIS PRIVACY POLICY.',
                        style: GoogleFonts.prompt(
                            fontWeight: FontWeight.w300, fontSize: 14),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text('YOUR CONSENT'),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        'By using our App, you consent to our privacy policy.',
                        style: GoogleFonts.prompt(
                            fontWeight: FontWeight.w300, fontSize: 14),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text('CONTACT US'),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        'If you have questions or comments about this Privacy Policy, please contact us at:\n\nPlan it\nNairobi,Kenya\nPlanit@gmail.com',
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
                          color: Theme.of(context).textTheme.bodyText2!.color,
                        ),
                      ),
                      width: 60,
                      decoration: decorator.copyWith(
                          shape: BoxShape.circle,
                          color: Theme.of(context).backgroundColor),
                    ),
                  ),
                )
              ],
            ));
  }
}
