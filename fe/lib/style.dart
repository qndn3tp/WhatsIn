import 'package:flutter/material.dart';

var theme = ThemeData(
  appBarTheme: AppBarTheme(
    color: Color(0xffFAFAFA),
    titleSpacing: 25,
    titleTextStyle: TextStyle(
        color: Color(0xff4C7A7E),
        fontSize: 25,
        fontWeight: FontWeight.bold),
    actionsIconTheme: IconThemeData(
        size: 35,
        color: Color(0xffD3D3D3)),
    elevation: 1,
  ),

  tabBarTheme: TabBarTheme(
    indicatorSize: TabBarIndicatorSize.label,
    labelColor:Color(0xff4C7A7E),
    unselectedLabelColor: Color(0xff7C7C7C),
    overlayColor: MaterialStateProperty.all(Color(0xffFAFAFA))
  ),
);