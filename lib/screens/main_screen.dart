import 'package:flutter/material.dart';
import 'package:mad/screens/cart_screen.dart';
import 'package:mad/screens/home_screen.dart';
import 'package:mad/screens/more_screen.dart';
import 'package:mad/screens/search_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int _currentIndex = 0;

  List<Widget> screenList = [
    HomeScreen(),
    SearchScreen(),
    CartScreen(),
    MoreScreen()
  ];

  void _onBottomNavBarClick(int currentIndex){
    setState(() {
      _currentIndex = currentIndex;
    });
  }

  @override
  Widget build(BuildContext context) {

    List<BottomNavigationBarItem> bottomNavItems = [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
      BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
      BottomNavigationBarItem(icon: Icon(Icons.more_vert), label: 'More')
    ];

    final bottomNav = BottomNavigationBar(
      elevation: 3,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.brown,
      backgroundColor: Colors.deepOrange,
      selectedFontSize: 16,
      unselectedFontSize: 12,
      items: bottomNavItems,
      currentIndex: _currentIndex,
      onTap: _onBottomNavBarClick,
    );

    return Scaffold(
      body: screenList.elementAt(_currentIndex),
      bottomNavigationBar: bottomNav,
    );
  }
}
