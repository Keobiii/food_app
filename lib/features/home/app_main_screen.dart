import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/features/food/food_app_home_screen.dart';
import 'package:food_app/features/profile/profile_screen.dart';
import 'package:iconsax/iconsax.dart';

class AppMainScreen extends StatefulWidget {
  const AppMainScreen({super.key});

  @override
  State<AppMainScreen> createState() => _AppMainScreenState();
}

class _AppMainScreenState extends State<AppMainScreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    FoodAppHomeScreen(),
    Scaffold(),
    ProfileScreen(),
    Scaffold(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItems(Iconsax.home_15, "A", 0),
            SizedBox(width: 10),
            _buildNavItems(Iconsax.heart, "B", 1),
            SizedBox(width: 90),
            _buildNavItems(Icons.person_outline, "C", 2),
            SizedBox(width: 10),
            Stack(
              clipBehavior: Clip.none,
              children: [
                _buildNavItems(Iconsax.shopping_cart, "D", 3),
                Positioned(
                  right: -7,
                  top: 5,
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 10,
                    child: Text(
                      "0",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ),
                Positioned(
                  right: 135,
                  top: -25,
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 30,
                    child: Icon(
                      CupertinoIcons.search,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItems(IconData icon, String label, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 28,
            color: _currentIndex == index ? Colors.red : Colors.grey,
          ),
          SizedBox(height: 3),
          CircleAvatar(
            radius: 3,
            backgroundColor:
                _currentIndex == index ? Colors.red : Colors.transparent,
          ),
        ],
      ),
    );
  }
}
