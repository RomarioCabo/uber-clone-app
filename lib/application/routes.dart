import 'package:flutter/material.dart';
import 'package:uber_clone/application/panel/panel_driver/panel_driver_page.dart';
import 'package:uber_clone/application/panel/panel_passenger/panel_passenger_page.dart';
import 'package:uber_clone/application/panel/routes_driver/routes_uber_page.dart';
import 'package:uber_clone/application/sign_in/sign_in_page.dart';

import '../domain/taxi_shipping/taxi_shipping_model.dart';
import 'login/login_page.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    dynamic arguments;

    if (settings.arguments != null) {
      arguments = _getArgument(settings);
    }

    switch (settings.name) {
      case "/login":
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case "/create-account":
        return MaterialPageRoute(builder: (_) => const SignInPage());
      case "/panel-passenger":
        return MaterialPageRoute(builder: (_) => const PanelPassengerPage());
      case "/panel-driver":
        return MaterialPageRoute(
          builder: (_) => PanelDriverPage(
            requestRoute: arguments,
          ),
        );
      case "/routes-uber":
        return MaterialPageRoute(builder: (_) => const RoutesUberPage());
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

  static dynamic _getArgument(RouteSettings settings) {
    if (settings.arguments is TaxiShippingModel) {
      return settings.arguments as TaxiShippingModel;
    }
  }
}
