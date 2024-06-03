import 'package:flutter/material.dart';
import 'package:priority_soft_test_project/screens/profile.dart';
import 'package:priority_soft_test_project/screens/review_page.dart';
import 'cart_page.dart';
import 'discover_page.dart';
// Import other necessary pages here, e.g., favorite_page.dart, cart_page.dart, profile_page.dart

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    DiscoverPage(),
    ReviewPage(),
    CartPage(),
    ProfilePage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(

      body: _pages[_currentIndex],

      bottomNavigationBar: SizedBox(

        child: BottomNavigationBar(

          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black,
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Discover',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'Review',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}







