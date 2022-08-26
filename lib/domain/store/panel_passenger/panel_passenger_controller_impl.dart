import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:uber_clone/domain/store/panel_passenger/panel_passenger_controller.dart';

part 'panel_passenger_controller_impl.g.dart';

class PanelPassengerControllerImpl = PanelPassengerControllerBase
    with _$PanelPassengerControllerImpl;

abstract class PanelPassengerControllerBase
    with Store
    implements PanelPassengerController {
  final Completer<GoogleMapController> _googleMapController = Completer();

  @observable
  late CameraPosition positionCamera =
      const CameraPosition(target: LatLng(-23.563999, -46.653256));

  @override
  onMapCreated(GoogleMapController controller) {
    _googleMapController.complete(controller);
  }

  @override
  retrieveLastKnownPosition() async {
    Position? position = await Geolocator.getLastKnownPosition();

    if (position != null) {
      positionCamera = CameraPosition(
          target: LatLng(position.latitude, position.longitude), zoom: 19);

      _moveCamera(positionCamera);
    }
  }

  @override
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