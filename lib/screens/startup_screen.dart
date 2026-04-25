import 'package:flutter/material.dart';
import 'package:mad/screens/login_screen.dart';

import 'package:mad/widgets/app_logo.dart' as appLogo;

class StartupScreen extends StatefulWidget {
  const StartupScreen({super.key});

  @override
  State<StartupScreen> createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> {
  @override
  Widget build(BuildContext context) {
    final getStartBtn = Padding(
      padding: EdgeInsets.only(left: 8, right: 8, bottom: 16),
      child: SizedBox(
        height: 40,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF3051A0)),
          onPressed: () {
            final route = MaterialPageRoute(
              builder: (BuildContext context) => LoginScreen(),
            );
            Navigator.pushReplacement(context, route);
          },
          child: Text("ចាប់ផ្តើម", style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: Center(child: appLogo.logo)),
            getStartBtn,
          ],
        ),
      ),
    );
  }
}
