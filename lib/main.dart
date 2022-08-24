import 'package:flutter/material.dart';
import 'package:uber_clone/ui/pages/home/home.dart';

final ThemeData defaultTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    color: Color(0xff37474f),
  ),
  primaryColor: const Color(0xff37474f),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: const Color(0xff546e7a),
  ),
);

void main() => runApp(
      MaterialApp(
        title: "Uber",
        home: const Home(),
        theme: defaultTheme,
        debugShowCheckedModeBanner: false,
      ),
    );
