import 'package:flutter/material.dart';
import 'package:uber_clone/application/home/loginpage.dart';
import 'package:uber_clone/application/routes.dart';

final ThemeData defaultTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    color: Color(0xff37474f),
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: const Color(0xff546e7a),
    secondary: const Color(0xff546e7a),
  ),
);

void main() => runApp(
      MaterialApp(
        title: "Uber",
        home: const LoginPage(),
        initialRoute: "/login",
        theme: defaultTheme,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routes.generateRoutes,
      ),
    );
