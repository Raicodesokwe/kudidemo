import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kudidemo/models/billable_model.dart';
import 'package:kudidemo/models/budget_model.dart';
import 'package:kudidemo/models/expense_item.dart';

import 'package:kudidemo/pages/chat_page.dart';
import 'package:kudidemo/pages/finances/finances_page.dart';
import 'package:kudidemo/pages/finances/finances_page.dart';
import 'package:kudidemo/pages/group_task.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:kudidemo/pages/homepage.dart';
import 'package:kudidemo/providers/bilable_provider.dart';
import 'package:kudidemo/providers/budget_provider.dart';
import 'package:kudidemo/providers/color_provider.dart';
import 'package:kudidemo/providers/expense_provider.dart';
import 'package:kudidemo/providers/google_signin.dart';
import 'package:kudidemo/providers/habits_provider.dart';
import 'package:kudidemo/providers/pic_provider.dart';
import 'package:kudidemo/providers/task_provider.dart';
import 'package:kudidemo/providers/theme_provider.dart';
import 'package:kudidemo/providers/timer_provider.dart';
import 'package:kudidemo/services/auth_service.dart';
import 'package:kudidemo/services/notification_service.dart';
import 'package:provider/provider.dart';

import 'models/task_model.dart';

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
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  Hive.registerAdapter(BudgetModelAdapter());

  Hive.registerAdapter(BillableModelAdapter());
  Hive.registerAdapter(ExpenseItemAdapter());
  await Hive.openBox("Habit_Database");
  //once a box is open, all its data is loaded from local storage in2 memory for immediate access
  //we can then retrieve data synchronously without using async/await
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ListenableProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => TaskProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => GoogleSignInProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ColorProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => HabitsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ExpenseProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => TimerProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PicProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => BillableProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => BudgetProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
          builder: (context, ThemeProvider notifier, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: notifier.themeData,
          home: AuthService.handleAuth(),
          routes: {
            'chat': (_) => ChatPage(),
            'group': (_) => GroupTask(),
            '/home': (_) => HomePage(),
            '/finance': (context) => FinancesPage(),
          },
        );
      }),
    );
  }
}
