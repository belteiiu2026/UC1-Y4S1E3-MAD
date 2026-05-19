import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mad/model/category.dart';
import 'package:mad/service/category_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoadingCategory = true;
  String _errorMessage = "Not Found";
  List<Category> _categories = [];

  @override
  void initState() {
    super.initState();
    _loadCategory();
  }

  Future<void> _loadCategory() async {
    await CategoryService.instance
        .getCategory()
        .then((categories) {
          setState(() {
            _categories = categories;
            _isLoadingCategory = false;
          });
        })
        .catchError((error) {
          setState(() {
            _isLoadingCategory = false;
            _errorMessage = error.toString();
          });
        });
  }

  Future<String?> _getData() async {
    final pref = await SharedPreferences.getInstance();
    await Future.delayed(Duration(seconds: 3));
    return await pref.getString("AppName");
  }

  @override
  Widget build(BuildContext context) {
    final place = FutureBuilder(
      future: _getData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        // State Progress
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(child: CircularProgressIndicator());
        }

        // Has Error
        if (snapshot.hasError) {
          return Center(child: Text("${snapshot.error}"));
        }

        // No Data
        if (!snapshot.hasData) {
          return Center(child: Text("No Data"));
        }

        String appName = snapshot.data;
        return Center(
          child: Text("${appName}", style: TextStyle(fontSize: 30)),
        );
      },
    );

    final titleCategory = Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Category",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          TextButton(onPressed: () {}, child: Text("See All")),
        ],
      ),
    );

    List<Widget> menu = _categories
        .map(
          (c) => Container(
            width: 100,
            child: TextButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black45),
              child: Text("${c.name}"),
            ),
          ),
        )
        .toList();

    final menuRow = SizedBox(
      height: 60,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: menu),
      ),
    );

    final topTripTitle = Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Top Trip",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          TextButton(onPressed: () {}, child: Text("See All")),
        ],
      ),
    );

    List<Widget> topTripList = _categories
        .map(
          (t) => Padding(
            padding: EdgeInsets.only(left: 4),
            child: Container(
              child: Image.asset("assets/images/Kirirom_National_Park.jpeg"),
            ),
          ),
        )
        .toList();

    final topTripRow = SizedBox(
      height: 200,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: topTripList),
      ),
    );

    final groupTripTitle = Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Group Trip",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          TextButton(onPressed: () {}, child: Text("See All")),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(elevation: 3),
      body: SafeArea(
        child: ListView(
          children: [titleCategory, menuRow, topTripTitle, topTripRow, groupTripTitle, topTripRow],
        ),
      ),
    );
  }
}
