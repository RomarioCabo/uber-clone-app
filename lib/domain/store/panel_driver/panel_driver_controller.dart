import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class PanelDriverController {
  onMapCreated(GoogleMapController controller);

  retrieveLastKnownPosition();

  retriveCurrentPosition();
}