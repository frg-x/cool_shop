import 'package:cool_shop/constants.dart';
import 'package:cool_shop/home_screen/home_screen.dart';
import 'package:cool_shop/widgets/my_bottom_navbar.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int activeScreenNumber = 0;

  List<Widget> get screensList => [
        const HomeScreen(testScreenTitle: 'Home'),
        const HomeScreen(testScreenTitle: 'Shop'),
        const HomeScreen(testScreenTitle: 'Bag'),
        const HomeScreen(testScreenTitle: 'Favorites'),
        const HomeScreen(testScreenTitle: 'Profile'),
      ];

  void callback(int number) {
    setState(() {
      activeScreenNumber = number;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AllColors.appBackgroundColor,
        bottomNavigationBar: MyBottomNavigationBar(
          callback: callback,
          activeScreen: activeScreenNumber,
        ),
        body: screensList[activeScreenNumber],
      ),
    );
  }
}
