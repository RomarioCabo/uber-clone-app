import 'package:flutter/material.dart';
import 'package:uber_clone/application/panel/paneldriver/paneldriverpage.dart';
import 'package:uber_clone/application/panel/panelpassenger/panelpassengerpage.dart';
import 'package:uber_clone/application/signin/signinpage.dart';

import 'login/loginpage.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case "/login":
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case "/create_account":
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
