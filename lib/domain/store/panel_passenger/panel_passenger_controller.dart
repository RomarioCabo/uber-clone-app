import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class PanelPassengerController {
  getRouteAwaitingDriverAcceptance();

  onMapCreated(GoogleMapController controller);

  retrieveLastKnownPosition({required double pixelRatio});

  retrieveCurrentPosition({required double pixelRatio});

  retrieveInformationDestination({required String destinationAddress});

  callUber();

  cancelUber();
}
