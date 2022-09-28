import 'package:flutter/material.dart';
import 'package:uber_clone/application/panel/panel_driver/panel_driver_page.dart';
import 'package:uber_clone/application/panel/panel_passenger/panel_passenger_page.dart';
import 'package:uber_clone/application/panel/routes_driver/routes_uber_page.dart';
import 'package:uber_clone/domain/argument/method_arguments.dart';
import 'package:uber_clone/domain/argument/who_called.dart';

class FragmentMain extends StatefulWidget {
  final MethodArguments arguments;

  const FragmentMain({Key? key, required this.arguments}) : super(key: key);

  @override
  State<FragmentMain> createState() => _FragmentMainState();
}

class _FragmentMainState extends State<FragmentMain> {
  List<String> itensMenu = ["Configurações", "Deslogar"];

  _choiceMenuItem(String choice) {
    switch (choice) {
      case "Deslogar":
        Navigator.pushReplacementNamed(context, "/login");
        break;
      case "Configurações":
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.arguments.title),
        actions: [
          PopupMenuButton(
            onSelected: _choiceMenuItem,
            itemBuilder: (context) {
              return itensMenu.map((String item) {
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList();
            },
          )
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    switch (widget.arguments.whoCalled) {
      case WhoCalled.panelPassenger:
        return const PanelPassengerPage();
      case WhoCalled.panelDriver:
        return PanelDriverPage(
          requestRoute: widget.arguments.clazz,
        );
      case WhoCalled.routesUber:
        return const RoutesUberPage();
    }
  }
}
