import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';

part 'paneldrivercontroller.g.dart';

class PanelDriverController = PanelDriverControllerBase
    with _$PanelDriverController;

abstract class PanelDriverControllerBase with Store {
  final Completer<GoogleMapController> _googleMapController = Completer();

  @observable
  late CameraPosition positionCamera =
      const CameraPosition(target: LatLng(-23.563999, -46.653256));

  onMapCreated(GoogleMapController controller) {
    _googleMapController.complete(controller);
  }

  retrieveLastKnownPosition() async {
    Position? position = await Geolocator.getLastKnownPosition();

    if (position != null) {
      positionCamera = CameraPosition(
          target: LatLng(position.latitude, position.longitude), zoom: 19);

      _moveCamera(positionCamera);
    }
  }

  retriveCurrentPosition() {
    var locationOptions = const LocationSettings(
        accuracy: LocationAccuracy.high, distanceFilter: 10);

    Geolocator.getPositionStream(locationSettings: locationOptions)
        .listen((Position position) {
      positionCamera = CameraPosition(
          target: LatLng(position.latitude, position.longitude), zoom: 19);

      _moveCamera(positionCamera);
    });
  }

  _moveCamera(CameraPosition cameraPosition) async {
    GoogleMapController googleMapController = await _googleMapController.future;
    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }
}
