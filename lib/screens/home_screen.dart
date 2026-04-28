import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  void initState() {
    super.initState();
    //_saveData();
  }

  Future<void> _saveData() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('AppName', "VisitMe");
  }

  // Future<void> _getData() async {
  //   final pref = await SharedPreferences.getInstance();
  //   String? appName = await pref.getString("AppName");
  //   setState(() {
  //     _appName = appName;
  //   });
  // }
  // String? _appName;

  Future<String?> _getData() async {
      final pref = await SharedPreferences.getInstance();
      await Future.delayed(Duration(seconds: 3));
      return await pref.getString("AppName");
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          elevation: 3,
        ),
      body: SafeArea(
          child:  FutureBuilder(
              future: _getData(),
              builder: (BuildContext context, AsyncSnapshot snapshot){

                // State Progress
                if(snapshot.connectionState != ConnectionState.done){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                // Has Error
                if(snapshot.hasError){
                  return Center(
                    child: Text("${snapshot.error}"),
                  );
                }

                // No Data
                if(!snapshot.hasData){
                  return Center(
                    child: Text("No Data"),
                  );
                }

                String appName = snapshot.data;
                return Center(
                  child: Text("${appName}", style: TextStyle(fontSize: 30),),
                )   ;

              })
      ),
    );
  }
}
