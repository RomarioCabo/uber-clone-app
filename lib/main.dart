import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:uber_clone/application/routes.dart';
import 'application/login/login_page.dart';
import 'infrastructure/provider/shared_preferences/shared_preferences_manager.dart';

final ThemeData defaultTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    color: Color(0xff37474f),
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: const Color(0xff546e7a),
    secondary: const Color(0xff546e7a),
  ),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var sharedPreferencesManager = SharedPreferencesManager();
  await sharedPreferencesManager.initializationDone;

  GetIt.I.registerSingleton(sharedPreferencesManager);

  runApp(
    MaterialApp(
      title: "Uber",
      home: const LoginPage(),
      initialRoute: "/login",
      theme: defaultTheme,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routes.generateRoutes,
    ),
  );
}