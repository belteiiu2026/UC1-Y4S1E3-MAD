import 'package:flutter/material.dart';
import 'package:mad/screens/startup_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MAD-E3',
      theme: ThemeData(
        // fontFamily: 'KantumruyPro',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink, brightness: Brightness.light),
        textTheme: TextTheme(
          displayLarge: TextStyle(fontSize: 18),
          displayMedium: TextStyle(fontSize: 16),
          displaySmall: TextStyle(fontSize: 14)
        )
      ),

      home: StartupScreen(),
    );
  }
}