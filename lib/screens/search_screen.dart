import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
        centerTitle: true,
        actions: [
          Icon(Icons.search),
          Icon(Icons.more_vert)
        ],
      ),
      body: SafeArea(child: Center(child: Text("No Data"),)),
    );
  }
}
