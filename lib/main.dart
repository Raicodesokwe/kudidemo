import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kudidemo/pages/chat_page.dart';
import 'package:kudidemo/pages/group_task.dart';
import 'package:kudidemo/pages/homepage.dart';
import 'package:kudidemo/navbar/navbar.dart';
import 'package:kudidemo/pages/splash_screen.dart';
import 'package:kudidemo/providers/google_signin.dart';
import 'package:kudidemo/providers/task_provider.dart';
import 'package:kudidemo/providers/theme_provider.dart';
import 'package:kudidemo/services/auth_service.dart';
import 'package:kudidemo/services/notification_service.dart';
import 'package:provider/provider.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.data.toString()}');
  print('Handling a background message ${message.notification!.title}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotifyService.init();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => TaskProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => GoogleSignInProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
          builder: (context, ThemeProvider notifier, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: notifier.themeData,
          home: AuthService.handleAuth(),
          routes: {'chat': (_) => ChatPage(), 'group': (_) => GroupTask()},
        );
      }),
    );
  }
}
