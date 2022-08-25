import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

class PanelDriverPage extends StatefulWidget {
  const PanelDriverPage({Key? key}) : super(key: key);

  @override
  State<PanelDriverPage> createState() => _PanelDriverPageState();
}

class _PanelDriverPageState extends State<PanelDriverPage> {
  List<String> itensMenu = ["Configurações", "Deslogar"];
  final Completer<GoogleMapController> _controllerGoogle = Completer();

  _choiceMenuItem(String choice) {
    switch (choice) {
      case "Deslogar":
        Navigator.pushReplacementNamed(context, "/login");
        break;
      case "Configurações":
        break;
    }
  }

  _onMapCreated(GoogleMapController controller) {
    _controllerGoogle.complete(controller);
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
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: const CameraPosition(
          target: LatLng(-23.563999, -46.653256),
          zoom: 16,
        ),
        onMapCreated: _onMapCreated,
      ),
    );
  }
}
