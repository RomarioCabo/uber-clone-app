import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

import '../../../domain/store/paneldriver/paneldrivercontroller.dart';

class PanelDriverPage extends StatefulWidget {
  const PanelDriverPage({Key? key}) : super(key: key);

  @override
  State<PanelDriverPage> createState() => _PanelDriverPageState();
}

class _PanelDriverPageState extends State<PanelDriverPage> {
  late PanelDriverController _controller;

  List<String> itensMenu = ["Configurações", "Deslogar"];

  @override
  void initState() {
    super.initState();

    _controller = PanelDriverController();
    _controller.retriveCurrentPosition();
    _controller.retrieveLastKnownPosition();
  }

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
      appBar: AppBar(
        title: const Text("Motorista"),
        actions: [
          PopupMenuButton<String>(
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
      body: Observer(
        builder: (_) {
          return GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _controller.positionCamera,
            onMapCreated: _controller.onMapCreated,
            myLocationEnabled: true,
          );
        },
      ),
    );
  }
}
