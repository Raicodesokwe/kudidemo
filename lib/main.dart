import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kudidemo/pages/homepage.dart';
import 'package:kudidemo/navbar/navbar.dart';
import 'package:kudidemo/pages/splash_screen.dart';
import 'package:kudidemo/theme/theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
    return ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
        child: Consumer<ThemeProvider>(
            builder: (context, ThemeProvider notifier, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: notifier.darkTheme
                ? lightThemeData(context)
                : darkThemeData(context),
            home: SplashScreen(),
          );
        }));
  }
}
