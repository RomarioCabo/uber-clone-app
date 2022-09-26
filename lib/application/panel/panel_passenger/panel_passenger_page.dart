import 'dart:io';

import 'package:alert_dialog/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:uber_clone/domain/store/panel_passenger/panel_passenger_controller_impl.dart';

import '../../../infrastructure/helpers/request_state.dart';
import '../../dialogs/show_alert_dialog.dart';
import '../../util/custom_button.dart';

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

    _controller = PanelPassengerControllerImpl();
    _controller.getRouteAwaitingDriverAcceptance();

    /// Reações
    _disposers.add(
      reaction(
        (_) => _controller.stateGetRouteAwaitingDriverAcceptance,
        _getRouteAwaitingDriverAcceptance,
      ),
    );
    _disposers.add(
      reaction(
        (_) => _controller.stateRetrieveInformationDestination,
        _stateRetrieveInformationDestination,
      ),
    );
    _disposers.add(
      reaction(
        (_) => _controller.stateCallUber,
        _callUber,
      ),
    );
    _disposers.add(
      reaction(
        (_) => _controller.stateCancelUber,
        _cancelUber,
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

  void _callUber(_) {
    if (_controller.stateCallUber is Loading) {
      showLoadingDialog(
        context: context,
        title: 'Enviando...',
      );
    }

    if (_controller.stateCallUber is Completed) {
      Navigator.of(context).pop();
    }
  }

  void _cancelUber(_) {
    if (_controller.stateCancelUber is Loading) {
      showLoadingDialog(
        context: context,
        title: 'Cancelando...',
      );
    }

    if (_controller.stateCancelUber is Completed) {
      Navigator.of(context).pop();
    }
  }

  void _getRouteAwaitingDriverAcceptance(_) {
    if (_controller.stateGetRouteAwaitingDriverAcceptance is Completed) {
      double pixelRatio = 0.0;

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        pixelRatio = MediaQuery.of(context).devicePixelRatio;
      });

      _controller.retrieveCurrentPosition(pixelRatio: pixelRatio);
      _controller.retrieveLastKnownPosition(pixelRatio: pixelRatio);

      _controllerMyLocation = TextEditingController();

      _controllerDestination = TextEditingController();
      _controllerDestination.text = "Rua Hermínio de Oliveira Brito, 905";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Passageiro"),
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
      body: Observer(
        builder: (_) {
          return _controller.stateGetRouteAwaitingDriverAcceptance is Loading
              ? _buildLoading()
              : _buildMapPassenger();
        },
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        child: const SpinKitDualRing(
          color: Color(0xff37474f),
          size: 40,
          lineWidth: 3,
        ),
      ),
    );
  }

  Widget _buildMapPassenger() {
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
        _controller.thereIsAnUberRequest
            ? Container()
            : _buildTextField(
                textEditingController: _controllerMyLocation,
                hintText: "Meu local",
                icon: Icons.location_on,
                color: Colors.green,
                top: 0,
                left: 0,
                right: 0,
                readOnly: true,
              ),
        _controller.thereIsAnUberRequest
            ? Container()
            : _buildTextField(
                textEditingController: _controllerDestination,
                hintText: "Digite o destino",
                icon: Icons.local_taxi,
                color: Colors.grey,
                top: 55,
                left: 0,
                right: 0,
                readOnly:
                    _controller.stateRetrieveInformationDestination is Loading,
              ),
        Positioned(
          right: 0,
          left: 0,
          bottom: 0,
          child: Padding(
            padding: Platform.isIOS
                ? const EdgeInsets.fromLTRB(20, 10, 20, 25)
                : const EdgeInsets.all(10),
            child: CustomButton(
              text: _controller.thereIsAnUberRequest
                  ? "Cancelar UBER"
                  : "Chamar UBER",
              color: _controller.thereIsAnUberRequest ? 0xFFD32F2F : 0xff37474f,
              loading:
                  _controller.stateRetrieveInformationDestination is Loading,
              onPressed: () {
                _onPressed();
              },
              enable:
                  _controller.stateRetrieveInformationDestination is! Loading,
            ),
          ),
        )
      ],
    );
  }

  _onPressed() {
    if (_controller.thereIsAnUberRequest) {
      return _controller.cancelUber();
    }

    return _controller.retrieveInformationDestination(
        destinationAddress: _controllerDestination.text);
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
