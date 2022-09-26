import 'package:flutter/material.dart';

import 'package:uber_clone/application/sign_in/sign_in_page.dart';

import '../domain/argument/method_arguments.dart';
import 'fragment/fragment_main.dart';
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
      case "/fragment-main":
        return MaterialPageRoute(
          builder: (_) => FragmentMain(
            arguments: arguments,
          ),
        );
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
    if (settings.arguments is MethodArguments) {
      return settings.arguments as MethodArguments;
    }
  }
}
