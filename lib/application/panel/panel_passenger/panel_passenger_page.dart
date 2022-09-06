import 'dart:io';

import 'package:alert_dialog/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:uber_clone/domain/store/panel_passenger/panel_passenger_controller_impl.dart';

import '../../../infrastructure/helpers/request_state.dart';
import '../../dialogs/custom_dialog.dart';
import '../../util/custom_buttom.dart';

class PanelPassengerPage extends StatefulWidget {
  const PanelPassengerPage({Key? key}) : super(key: key);

  @override
  State<PanelPassengerPage> createState() => _PanelPassengerPageState();
}

class _PanelPassengerPageState extends State<PanelPassengerPage> {
  late PanelPassengerControllerImpl _controller;

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

  /// Reactions
  final List<ReactionDisposer> _disposers = [];

  late final TextEditingController _controllerMyLocation;
  late final TextEditingController _controllerDestination;

  @override
  void initState() {
    super.initState();

    double pixelRatio = 0.0;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      pixelRatio = MediaQuery.of(context).devicePixelRatio;
    });

    _controller = PanelPassengerControllerImpl();
    _controller.retrieveCurrentPosition(pixelRatio);
    _controller.retrieveLastKnownPosition(pixelRatio);

    _controllerMyLocation = TextEditingController();

    _controllerDestination = TextEditingController();
    _controllerDestination.text = "Rua Coronel Perdigão Sobrinho, 241";

    /// Reações
    _disposers.add(
      reaction(
        (_) => _controller.stateRetrieveInformationDestination,
        _stateRetrieveInformationDestination,
      ),
    );
  }

  @override
  void dispose() {
    for (var disposer in _disposers) {
      disposer();
    }
    super.dispose();
  }

  void _stateRetrieveInformationDestination(_) {
    if (_controller.stateRetrieveInformationDestination is Completed) {
      showAlertDialog(
        context: context,
        title: 'Confirme o endereço',
        content: _controller.confirmation,
        function: () {
          Navigator.of(context).pop();
          _controller.callUber();
        },
      );
    }

    if (_controller.stateRetrieveInformationDestination is Error) {
      alert(
        context,
        title: const Text('Atenção'),
        content: Text(
            (_controller.stateRetrieveInformationDestination as Error).error!),
        textOK: const Text('FECHAR'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Passageiro"),
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
          return Stack(
            children: [
              GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _controller.positionCamera,
                onMapCreated: _controller.onMapCreated,
                //myLocationEnabled: true,
                markers: _controller.markers,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
              ),
              _buildTextField(
                textEditingController: _controllerMyLocation,
                hintText: "Meu local",
                icon: Icons.location_on,
                color: Colors.green,
                top: 0,
                left: 0,
                right: 0,
                readOnly: true,
              ),
              _buildTextField(
                textEditingController: _controllerDestination,
                hintText: "Digite o destino",
                icon: Icons.local_taxi,
                color: Colors.grey,
                top: 55,
                left: 0,
                right: 0,
                readOnly: _enable(),
              ),
              Positioned(
                right: 0,
                left: 0,
                bottom: 0,
                child: Padding(
                  padding: Platform.isIOS
                      ? const EdgeInsets.fromLTRB(20, 10, 20, 25)
                      : const EdgeInsets.all(10),
                  child: CustomButtom(
                    text: "Chamar UBER",
                    color: 0xff1ebbd8,
                    loading: _enable(),
                    onPressed: () {
                      _controller.retrieveInformationDestination(
                          _controllerDestination.text);
                    },
                    enable: _buttonEnable(),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  bool _enable() {
    return _controller.stateCallUber is Loading ||
        _controller.stateRetrieveInformationDestination is Loading;
  }

  bool _buttonEnable() {
    return _controller.stateCallUber is! Loading &&
        _controller.stateRetrieveInformationDestination is! Loading;
  }

  Widget _buildTextField({
    required TextEditingController textEditingController,
    required String? hintText,
    required IconData? icon,
    required MaterialColor? color,
    required double? top,
    required double? left,
    required double? right,
    required bool? readOnly,
  }) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          padding: const EdgeInsets.only(bottom: 14),
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(3),
            color: Colors.white,
          ),
          child: TextField(
            controller: textEditingController,
            readOnly: readOnly!,
            decoration: InputDecoration(
              icon: Container(
                margin: const EdgeInsets.only(left: 20),
                width: 10,
                height: 10,
                child: Icon(
                  icon,
                  color: color,
                ),
              ),
              hintText: hintText,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(left: 15),
            ),
          ),
        ),
      ),
    );
  }
}
