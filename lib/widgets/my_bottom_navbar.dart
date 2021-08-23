import 'package:cool_shop/constants.dart';
import 'package:cool_shop/widgets/bottom_menu_item.dart';
import 'package:flutter/material.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({Key? key, required this.activeScreen})
      : super(key: key);
  final int activeScreen;

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: AllColors.black.withOpacity(0.06),
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        child: Container(
          height: 83,
          padding: const EdgeInsets.fromLTRB(27, 11, 27, 0),
          color: AllColors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BottomMenuItem(
                screenNumber: 0,
                title: 'Home',
                assetName: 'home',
                activeScreen: widget.activeScreen,
              ),
              BottomMenuItem(
                screenNumber: 1,
                title: 'Shop',
                assetName: 'shop',
                activeScreen: widget.activeScreen,
              ),
              BottomMenuItem(
                screenNumber: 2,
                title: 'Bag',
                assetName: 'bag',
                activeScreen: widget.activeScreen,
              ),
              BottomMenuItem(
                screenNumber: 3,
                title: 'Favorites',
                assetName: 'fav',
                activeScreen: widget.activeScreen,
              ),
              BottomMenuItem(
                screenNumber: 4,
                title: 'Profile',
                assetName: 'profile',
                activeScreen: widget.activeScreen,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
