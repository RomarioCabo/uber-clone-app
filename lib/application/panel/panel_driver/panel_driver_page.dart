import 'dart:io';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

import '../../../domain/store/panel_driver/panel_driver_controller_impl.dart';
import '../../../domain/taxi_shipping/taxi_shipping_model.dart';
import '../../util/custom_button.dart';

class PanelDriverPage extends StatefulWidget {
  final TaxiShippingModel requestRoute;

  const PanelDriverPage({
    Key? key,
    required this.requestRoute,
  }) : super(key: key);

  @override
  State<PanelDriverPage> createState() => _PanelDriverPageState();
}

class _PanelDriverPageState extends State<PanelDriverPage> {
  late PanelDriverControllerImpl _controller;

  @override
  void initState() {
    super.initState();

    _controller = PanelDriverControllerImpl();
    _controller.retriveCurrentPosition();
    _controller.retrieveLastKnownPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return _buildMapPassenger();
      },
    );
  }

  Widget _buildMapPassenger() {
    return Stack(
      children: [
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _controller.positionCamera,
          onMapCreated: _controller.onMapCreated,
          myLocationEnabled: true,
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
              text: "ACEITAR CORRIDA",
              color: 0xff37474f,
              loading: false,
              onPressed: () {},
              enable: true,
            ),
          ),
        )
      ],
    );
  }
}
