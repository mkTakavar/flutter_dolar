import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fa'), //farsi
      ],
      theme: ThemeData(
          fontFamily: 'Vazir',
          textTheme:  TextTheme(
            headlineLarge: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.grey[800]
            ),

            headlineMedium: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w300,
               color: Colors.grey[200]
            ),

             headlineSmall: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
               color: Colors.red
            ),
             labelSmall: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
               color: Colors.green
            ),
             bodyLarge: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w300,
              color: Colors.grey[800]
            ),

            bodyMedium: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w300,
              color: Colors.grey[800]
            ),

            

          )),
      home:  Home(),
    );
  }
}
