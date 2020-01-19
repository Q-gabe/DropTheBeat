import 'package:flutter/material.dart';

// Create an Icon display control
class NavigationIconView {
  // Create two attributes, one to show icon and the other to animate.
  final BottomNavigationBarItem item;
  final AnimationController controller;

  // Similar to the construction method in Java
  // Creating Navigation IconView requires passing in three parameters, icon icon, Title title, TickerProvider
  NavigationIconView({Widget icon, Widget title, TickerProvider vsync})
      : item = new BottomNavigationBarItem(
          icon: icon,
          title: title,
          backgroundColor: Colors.white,
        ),
        controller = new AnimationController(
          duration: Duration(milliseconds: 200), // Set the duration of the animation
          vsync: vsync // default properties and parameters
        );
}
