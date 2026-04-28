import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mad/screens/startup_screen.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _onFileCreation();
  // await _orderProduct();
  // await _getOrderProduct();
  runApp(const App());
}

Future<void> _onFileCreation() async {
    final appDoc = await getApplicationDocumentsDirectory();
    String path = appDoc.path;
    final  file = File("${path}/visitme.txt");
    if(await file.exists() == false){
      await file.create(recursive:  true);
      print("File is created...");
    }
}

Future<void> _orderProduct() async {
  final appDoc = await getApplicationDocumentsDirectory();
  String path = appDoc.path;
  final  file = File("${path}/visitme.txt");
  String order1 = "productId=1,price=2,qty=3"+"\n";
  String order2 = "productId=2,price=5,qty=1"+"\n";
  await file.writeAsString(order1, mode: FileMode.append);
  await file.writeAsString(order2, mode: FileMode.append);
}

Future<void> _getOrderProduct() async {
  final appDoc = await getApplicationDocumentsDirectory();
  String path = appDoc.path;
  final  file = File("${path}/visitme.txt");
  List<String> data =  await file.readAsLines();
  // print("data $data");
  for(String s in data){
    print("Items : $s");
  }
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