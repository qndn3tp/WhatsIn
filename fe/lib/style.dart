import 'package:flutter/material.dart';

final backgroundColor = Color(0xffFAFAFA);
final pointColor = Color(0xff4C7A7E);
final catTextStyle = TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff33484A)
                          );

var theme = ThemeData(
  textTheme: TextTheme(
    displayLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black
    ),
    displayMedium: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 15,
        color: Colors.black,
    ),
    displaySmall: TextStyle(
        fontSize: 13,
        color: Colors.black,
    ),
  ),

  appBarTheme: AppBarTheme(
    color: backgroundColor,
    titleSpacing: 25,
    titleTextStyle: TextStyle(
        color: pointColor,
        fontSize: 25,
        fontWeight: FontWeight.bold
    ),
    actionsIconTheme: IconThemeData(
        size: 35,
        color: backgroundColor
    ),
    elevation: 1,
  ),

  tabBarTheme: TabBarTheme(
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(color: pointColor, width: 2)
    ),
    indicatorSize: TabBarIndicatorSize.label,
    labelColor: pointColor,
    labelStyle: TextStyle(fontWeight: FontWeight.bold),
    unselectedLabelColor: Color(0xff7C7C7C),
    unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
    overlayColor: MaterialStateProperty.all(backgroundColor)
  ),
);