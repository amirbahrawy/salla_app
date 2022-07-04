import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'colors.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    systemOverlayStyle:  SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    iconTheme:  IconThemeData(color: Colors.black),
    elevation: 0.0,
    titleTextStyle:  TextStyle(
        color: Colors.black, fontSize: 22.0, fontWeight: FontWeight.bold),
    backgroundColor: Colors.white,
  ),
  fontFamily: 'Jannah',
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor),
);
ThemeData darkTheme = ThemeData(
  fontFamily: 'Jannah',
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: dark,
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness: Brightness.light,
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    color: dark,
    elevation: 0.0,
    titleTextStyle: const TextStyle(
        color: Colors.white, fontSize: 22.0, fontWeight: FontWeight.bold),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      unselectedItemColor: Colors.grey,
      backgroundColor: dark,
      elevation: 20.0),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: defaultColor)
);
