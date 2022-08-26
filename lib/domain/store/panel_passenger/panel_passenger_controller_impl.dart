import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
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

  @observable
  Set<Marker> markers = {};

  @override
  onMapCreated(GoogleMapController controller) {
    _googleMapController.complete(controller);
  }

  @override
  retrieveLastKnownPosition(double pixelRatio) async {
    Position? position = await Geolocator.getLastKnownPosition();

    if (position != null) {
      positionCamera = CameraPosition(
          target: LatLng(position.latitude, position.longitude), zoom: 19);

      _showPassengerBookmark(position, pixelRatio);

      _moveCamera(positionCamera);
    }
  }

  @override
  retriveCurrentPosition(double pixelRatio) {
    var locationOptions = const LocationSettings(
        accuracy: LocationAccuracy.high, distanceFilter: 10);

    Geolocator.getPositionStream(locationSettings: locationOptions)
        .listen((Position position) {
      positionCamera = CameraPosition(
          target: LatLng(position.latitude, position.longitude), zoom: 19);

      _showPassengerBookmark(position, pixelRatio);

      _moveCamera(positionCamera);
    });
  }

  _moveCamera(CameraPosition cameraPosition) async {
    GoogleMapController googleMapController = await _googleMapController.future;
    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  _showPassengerBookmark(Position local, double pixelRatio) async {
    final Uint8List? markerIcon =
        await getBytesFromAsset('imagens/passageiro.png', 150);

    Marker marcadorPassageiro = Marker(
        markerId: const MarkerId("passenger-marker"),
        position: LatLng(local.latitude, local.longitude),
        infoWindow: const InfoWindow(title: "Você"),
        icon: BitmapDescriptor.fromBytes(markerIcon!));

    markers.add(marcadorPassageiro);
  }

  Future<Uint8List?> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    Codec codec = await instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))
        ?.buffer
        .asUint8List();
  }
}
