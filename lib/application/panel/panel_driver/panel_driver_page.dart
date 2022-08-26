import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

import '../../../domain/store/panel_driver/panel_driver_controller_impl.dart';

class PanelDriverPage extends StatefulWidget {
  const PanelDriverPage({Key? key}) : super(key: key);

  @override
  State<PanelDriverPage> createState() => _PanelDriverPageState();
}

class _PanelDriverPageState extends State<PanelDriverPage> {
  late PanelDriverControllerImpl _controller;

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
  void initState() {
    super.initState();

    _controller = PanelDriverControllerImpl();
    _controller.retriveCurrentPosition();
    _controller.retrieveLastKnownPosition();
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
