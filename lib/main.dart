import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart'; // Welcome Screen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Finance Tracker',
      theme: ThemeData(
        primaryColor: Colors.yellow,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          color: Colors.black,
          titleTextStyle: TextStyle(color: Colors.yellow),
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(color: Colors.yellow, fontSize: 24, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(color: Colors.yellow, fontSize: 16),
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.yellow)
            .copyWith(background: Colors.black),
      ),
      home: WelcomeScreen(),  // Welcome page
    );
  }
}
