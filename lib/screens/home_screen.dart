import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mad/model/category.dart';
import 'package:mad/model/product.dart';
import 'package:mad/service/category_service.dart';
import 'package:mad/service/product_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoadingCategory = true;
  String _errorMessage = "Not Found";
  List<String> _categories = [
  "ទាំងអស់",
  "សម្លៀកបំពាក់",
  "អេឡិចត្រូនិក",
  "ទូរស័ព្ទ",
  "កុំព្យូទ័រ",
  "គ្រឿងសម្អាង",
  "សុខភាព",
  "ផ្រឿងសង្ហារឹម",
  "ផ្ទះបាយ",
  "កីឡា",
  "សៀវភៅ",
  "ប្រដាប់ក្មេងលេង",
  "ទារក និងមាតា",
  "សត្វចិញ្ចឹម",
  "អាហារ និងភេសជ្ជៈ",
  "រថយន្ត និងម៉ូតូ",
  "អំណោយ",
  "ផ្សេងៗ"
  ];
  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    // _loadCategory();
    _loadProductFromServer();
  }

  Future<void> _loadProductFromServer() async {
    final dataRes = await ProductService.instance.getProducts();
    setState(() {
      _products = dataRes;
    });
  }

  // Future<void> _loadCategory() async {
  //   await CategoryService.instance
  //       .getCategory()
  //       .then((categories) {
  //         setState(() {
  //           _categories = categories;
  //           _isLoadingCategory = false;
  //         });
  //       })
  //       .catchError((error) {
  //         setState(() {
  //           _isLoadingCategory = false;
  //           _errorMessage = error.toString();
  //         });
  //       });
  // }

  Future<String?> _getData() async {
    final pref = await SharedPreferences.getInstance();
    await Future.delayed(Duration(seconds: 3));
    return await pref.getString("AppName");
  }

  @override
  Widget build(BuildContext context) {
    // final place = FutureBuilder(
    //   future: _getData(),
    //   builder: (BuildContext context, AsyncSnapshot snapshot) {
    //     // State Progress
    //     if (snapshot.connectionState != ConnectionState.done) {
    //       return Center(child: CircularProgressIndicator());
    //     }
    //
    //     // Has Error
    //     if (snapshot.hasError) {
    //       return Center(child: Text("${snapshot.error}"));
    //     }
    //
    //     // No Data
    //     if (!snapshot.hasData) {
    //       return Center(child: Text("No Data"));
    //     }
    //
    //     String appName = snapshot.data;
    //     return Center(
    //       child: Text("${appName}", style: TextStyle(fontSize: 30)),
    //     );
    //   },
    // );

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
            width: 120,
            child: TextButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black45),
              child: Text("${c}"),
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

    List<Widget> topProduct = _products.map((p) {
      return Padding(
        padding: EdgeInsets.only(left: 4),
        child: Card(
          elevation: 0.2,
          child: Image.network(
            "${p.image}",
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child; // Image loaded completely
              return Image.asset('assets/images/default-image-cover.jpg'); // While loading
            },
            errorBuilder: (context, error, stackTrace) {
              return Image.asset('assets/images/default-image-cover.jpg'); // If network fails
            },
          ),
        ),
      );
    }).toList();

    final topTripRow = SizedBox(
      height: 200,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: topProduct),
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

    final subTitle = Padding(
      padding: EdgeInsets.only(left: 32, right: 16),
      child: Text(
        "What do you want to read today?",
        style: TextStyle(fontSize: 16, color: Colors.black87),
      ),
    );

    final searchWidget = Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          hintText: 'Search...',
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );

    final title = Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Text(
        "Hi, Guest",
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
      title: title,
        centerTitle: false,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            searchWidget,
            titleCategory,
            menuRow,
            topTripTitle,
            topTripRow,
            groupTripTitle,
            topTripRow,
          ],
        ),
      ),
    );
  }
}
