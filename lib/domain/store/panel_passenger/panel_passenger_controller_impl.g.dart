// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'panel_passenger_controller_impl.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PanelPassengerControllerImpl on PanelPassengerControllerBase, Store {
  late final _$positionCameraAtom = Atom(
      name: 'PanelPassengerControllerBase.positionCamera', context: context);

  @override
  CameraPosition get positionCamera {
    _$positionCameraAtom.reportRead();
    return super.positionCamera;
  }

  @override
  set positionCamera(CameraPosition value) {
    _$positionCameraAtom.reportWrite(value, super.positionCamera, () {
      super.positionCamera = value;
    });
  }

  late final _$markersAtom =
      Atom(name: 'PanelPassengerControllerBase.markers', context: context);

  @override
  Set<Marker> get markers {
    _$markersAtom.reportRead();
    return super.markers;
  }

  @override
  set markers(Set<Marker> value) {
    _$markersAtom.reportWrite(value, super.markers, () {
      super.markers = value;
    });
  }

  @override
  String toString() {
    return '''
positionCamera: ${positionCamera},
markers: ${markers}
    ''';
  }
}
