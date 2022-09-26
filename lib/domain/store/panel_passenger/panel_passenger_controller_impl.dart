import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:uber_clone/domain/destination/destination.dart';
import 'package:uber_clone/domain/store/panel_passenger/panel_passenger_controller.dart';
import 'package:uber_clone/domain/taxi_shipping_history/status_route.dart';

import '../../../infrastructure/helpers/request_state.dart';
import '../../../infrastructure/provider/shared_preferences/shared_preferences_provider_impl.dart';
import '../../../infrastructure/provider/taxi_shipping/taxi_shipping_provider_impl.dart';
import '../../../infrastructure/provider/taxi_shipping_history/taxi_shipping_history_provider_impl.dart';
import '../../provider/shared_preferences_provider.dart';
import '../../taxi_shipping/taxi_shipping_model.dart';
import '../../taxi_shipping_history/taxi_shipping_history_model.dart';
import '../../user/user_model.dart';

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

  @observable
  late Destination destination = Destination();

  @observable
  RequestState stateCallUber = Initial();

  @observable
  RequestState stateCancelUber = Initial();

  @observable
  RequestState stateRetrieveInformationDestination = Initial();

  @observable
  RequestState stateGetRouteAwaitingDriverAcceptance = Initial();

  @observable
  late String confirmation = "";

  @observable
  late bool thereIsAnUberRequest = false;

  late TaxiShippingHistoryModel? _taxiShippingHistoryModel =
      TaxiShippingHistoryModel();

  final TaxiShippingHistoryProviderImpl _taxiShippingHistoryProvider =
      TaxiShippingHistoryProviderImpl();

  final SharedPreferencesProvider _sharedPreferencesProvider =
      SharedPreferencesProviderImpl();

  final TaxiShippingProviderImpl _provider = TaxiShippingProviderImpl();

  @action
  @override
  getRouteAwaitingDriverAcceptance() async {
    try {
      stateGetRouteAwaitingDriverAcceptance = Loading();
      await Future.delayed(const Duration(seconds: 1));

      UserModel userModel = _sharedPreferencesProvider.getUser();

      _taxiShippingHistoryModel =
          await _taxiShippingHistoryProvider.getRouteAwaitingDriverAcceptance(
        idPassenger: userModel.id!,
      );

      if (_taxiShippingHistoryModel != null) {
        thereIsAnUberRequest = true;
      }

      stateGetRouteAwaitingDriverAcceptance = Completed();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }

      stateGetRouteAwaitingDriverAcceptance = Error(
        error: e.toString(),
      );
    }
  }

  @override
  onMapCreated(GoogleMapController controller) {
    _googleMapController.complete(controller);
  }

  @override
  retrieveLastKnownPosition({required double pixelRatio}) async {
    Position? position = await Geolocator.getLastKnownPosition();

    if (position != null) {
      positionCamera = CameraPosition(
          target: LatLng(position.latitude, position.longitude), zoom: 19);

      _showPassengerBookmark(local: position, pixelRatio: pixelRatio);

      _moveCamera(cameraPosition: positionCamera);
    }
  }

  @override
  retrieveCurrentPosition({required double pixelRatio}) {
    var locationOptions = const LocationSettings(
        accuracy: LocationAccuracy.high, distanceFilter: 10);

    Geolocator.getPositionStream(locationSettings: locationOptions)
        .listen((Position position) {
      positionCamera = CameraPosition(
          target: LatLng(position.latitude, position.longitude), zoom: 19);

      _showPassengerBookmark(local: position, pixelRatio: pixelRatio);

      _moveCamera(cameraPosition: positionCamera);
    });
  }

  @override
  retrieveInformationDestination({required String destinationAddress}) async {
    if (destinationAddress.isEmpty) {
      stateRetrieveInformationDestination = Error(
        error: "O campo destino não pode estar vazio.",
      );

      return;
    }

    stateRetrieveInformationDestination = Loading();

    try {
      await Future.delayed(const Duration(seconds: 2));

      //List<Location> locations = await locationFromAddress(destinationAddress, localeIdentifier: "en_US");

      //double latitude = locations.isNotEmpty ? locations[0].latitude : 0.0;
      double latitude = -4.947485307535378;
      //double longitude = locations.isNotEmpty ? locations[0].longitude : 0.0;
      double longitude = -37.988001229250415;

      //List<Placemark> listAddresses = await placemarkFromCoordinates(latitude, longitude);

      //if (listAddresses.isNotEmpty) {
      //Placemark address = listAddresses[0];
      Placemark address = Placemark(
        thoroughfare: "Rua Hermínio de Oliveira Brito",
        subThoroughfare: "905",
        administrativeArea: "Ceará",
        subAdministrativeArea: "Russas",
        subLocality: "Planalto da Catumbela",
        postalCode: "62900000",
      );

      destination = Destination(
        street: address.thoroughfare,
        number: address.subThoroughfare,
        state: address.administrativeArea,
        city: address.subAdministrativeArea,
        neighborhood: address.subLocality,
        postalCode: address.postalCode,
        latitude: latitude,
        longitude: longitude,
      );
      //}

      confirmation =
          "\nCidade: ${destination.city}\nEstado: ${destination.state}"
          "\nRua: ${destination.street}\nBairro: ${destination.neighborhood}"
          "\nCep: ${destination.postalCode}";

      stateRetrieveInformationDestination = Completed();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }

      stateRetrieveInformationDestination = Error(
        error: e.toString(),
      );
    }
  }

  @action
  @override
  callUber() async {
    try {
      stateCallUber = Loading();
      await Future.delayed(const Duration(seconds: 1));

      UserModel userModel = _sharedPreferencesProvider.getUser();

      TaxiShippingModel taxiShippingModel = await _provider.callUber(
        taxiShippingModel: TaxiShippingModel(
          id: null,
          destination: destination,
          driver: null,
          passenger: userModel,
          createdAt: null,
        ),
      );

      thereIsAnUberRequest = true;

      _taxiShippingHistoryModel = TaxiShippingHistoryModel(
        id: null,
        idTaxiShipping: taxiShippingModel.id,
        statusRoute: StatusRoute.WAITING_ACCEPT_DRIVER.name,
        eventDate: null,
      );

      stateCallUber = Completed();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }

      stateCallUber = Error(
        error: e.toString(),
      );
    }
  }

  @action
  @override
  cancelUber() async {
    try {
      stateCancelUber = Loading();
      await Future.delayed(const Duration(seconds: 1));

      await _taxiShippingHistoryProvider.cancelUber(
        taxiShippingHistoryModel: TaxiShippingHistoryModel(
          id: null,
          idTaxiShipping: _taxiShippingHistoryModel?.idTaxiShipping,
          statusRoute: StatusRoute.CANCELED_BY_PASSENGER.name,
          eventDate: null,
        ),
      );

      thereIsAnUberRequest = false;

      stateCancelUber = Completed();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }

      stateCancelUber = Error(
        error: e.toString(),
      );
    }
  }

  _moveCamera({required CameraPosition cameraPosition}) async {
    GoogleMapController googleMapController = await _googleMapController.future;
    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  _showPassengerBookmark({
    required Position local,
    required double pixelRatio,
  }) async {
    final Uint8List? markerIcon =
        await getBytesFromAsset(path: 'imagens/passageiro.png', width: 150);

    Marker markerPassenger = Marker(
      markerId: const MarkerId("passenger-marker"),
      position: LatLng(local.latitude, local.longitude),
      infoWindow: const InfoWindow(title: "Você"),
      icon: BitmapDescriptor.fromBytes(markerIcon!),
    );

    markers.add(markerPassenger);
  }

  Future<Uint8List?> getBytesFromAsset({
    required String path,
    required int width,
  }) async {
    ByteData data = await rootBundle.load(path);
    Codec codec = await instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))
        ?.buffer
        .asUint8List();
  }
}
