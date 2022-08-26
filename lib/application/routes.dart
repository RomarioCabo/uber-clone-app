import 'package:flutter/material.dart';
import 'package:uber_clone/application/panel/panel_driver/panel_driver_page.dart';
import 'package:uber_clone/application/panel/panel_passenger/panel_passenger_page.dart';
import 'package:uber_clone/application/sign_in/sign_in_page.dart';

import 'login/login_page.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case "/login":
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case "/create-account":
        return MaterialPageRoute(builder: (_) => const SignInPage());
      case "/panel-passenger":
        return MaterialPageRoute(builder: (_) => const PanelPassengerPage());
      case "/panel-driver":
        return MaterialPageRoute(builder: (_) => const PanelDriverPage());
      default:
        _errorRoute();
    }

    throw Exception();
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Tela não encontrada!"),
          ),
          body: const Center(
            child: Text("Tela não encontrada!"),
          ),
        );
      },
    );
  }
}
