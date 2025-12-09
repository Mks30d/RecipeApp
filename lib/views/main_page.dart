import 'package:flutter/material.dart';
import 'package:recipe_app/views/home_screen.dart';
import 'package:recipe_app/utils/constants.dart';
import 'package:recipe_app/widgets/save_details.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;
  late final List<Widget> pages;

  @override
  void initState() {
    pages = [
      HomeScreen(),
      navBarPage(Icons.favorite),
      navBarPage(Icons.calendar_month),
      // navBarPage(Icons.settings),
      SaveDetails(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Recipe App'), centerTitle: true),
      backgroundColor: backgroundColor,

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: selectedIndex,
        elevation: 2,
        iconSize: 26,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          color: primaryColor,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
        ),
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              selectedIndex == 0 ? Icons.home_filled : Icons.home_outlined,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              selectedIndex == 1 ? Icons.favorite : Icons.favorite_border,
            ),

            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              selectedIndex == 2
                  ? Icons.calendar_month
                  : Icons.calendar_month_outlined,
            ),
            label: 'Meal Plan',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              selectedIndex == 3 ? Icons.settings : Icons.settings_outlined,
            ),
            label: 'Settings',
          ),
        ],
      ),
      body: pages[selectedIndex],
    );
  }

  navBarPage(iconName) {
    return Center(child: Icon(iconName, size: 60, color: primaryColor));
  }
}
