import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mad/data/db_manager.dart';
import 'package:mad/model/category.dart';
import 'package:mad/screens/startup_screen.dart';
import 'package:mad/service/category_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBManager.instance.database;

  final sea = Category(name: "Sea");
  final mountain = Category(name: "Mountain");
  final lake = Category(name: "Lake");

  await CategoryService.instance.insertCategory(sea);
  await CategoryService.instance.insertCategory(mountain);
  await CategoryService.instance.insertCategory(lake);


  await CategoryService.instance.getCategory();

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white, brightness: Brightness.light),
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