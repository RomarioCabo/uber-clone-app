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

  late final _$destinationAtom =
      Atom(name: 'PanelPassengerControllerBase.destination', context: context);

  @override
  Destination get destination {
    _$destinationAtom.reportRead();
    return super.destination;
  }

  @override
  set destination(Destination value) {
    _$destinationAtom.reportWrite(value, super.destination, () {
      super.destination = value;
    });
  }

  late final _$stateCallUberAtom = Atom(
      name: 'PanelPassengerControllerBase.stateCallUber', context: context);

  @override
  RequestState get stateCallUber {
    _$stateCallUberAtom.reportRead();
    return super.stateCallUber;
  }

  @override
  set stateCallUber(RequestState value) {
    _$stateCallUberAtom.reportWrite(value, super.stateCallUber, () {
      super.stateCallUber = value;
    });
  }

  late final _$stateCancelUberAtom = Atom(
      name: 'PanelPassengerControllerBase.stateCancelUber', context: context);

  @override
  RequestState get stateCancelUber {
    _$stateCancelUberAtom.reportRead();
    return super.stateCancelUber;
  }

  @override
  set stateCancelUber(RequestState value) {
    _$stateCancelUberAtom.reportWrite(value, super.stateCancelUber, () {
      super.stateCancelUber = value;
    });
  }

  late final _$stateRetrieveInformationDestinationAtom = Atom(
      name: 'PanelPassengerControllerBase.stateRetrieveInformationDestination',
      context: context);

  @override
  RequestState get stateRetrieveInformationDestination {
    _$stateRetrieveInformationDestinationAtom.reportRead();
    return super.stateRetrieveInformationDestination;
  }

  @override
  set stateRetrieveInformationDestination(RequestState value) {
    _$stateRetrieveInformationDestinationAtom
        .reportWrite(value, super.stateRetrieveInformationDestination, () {
      super.stateRetrieveInformationDestination = value;
    });
  }

  late final _$stateGetRouteAwaitingDriverAcceptanceAtom = Atom(
      name:
          'PanelPassengerControllerBase.stateGetRouteAwaitingDriverAcceptance',
      context: context);

  @override
  RequestState get stateGetRouteAwaitingDriverAcceptance {
    _$stateGetRouteAwaitingDriverAcceptanceAtom.reportRead();
    return super.stateGetRouteAwaitingDriverAcceptance;
  }

  @override
  set stateGetRouteAwaitingDriverAcceptance(RequestState value) {
    _$stateGetRouteAwaitingDriverAcceptanceAtom
        .reportWrite(value, super.stateGetRouteAwaitingDriverAcceptance, () {
      super.stateGetRouteAwaitingDriverAcceptance = value;
    });
  }

  late final _$confirmationAtom =
      Atom(name: 'PanelPassengerControllerBase.confirmation', context: context);

  @override
  String get confirmation {
    _$confirmationAtom.reportRead();
    return super.confirmation;
  }

  @override
  set confirmation(String value) {
    _$confirmationAtom.reportWrite(value, super.confirmation, () {
      super.confirmation = value;
    });
  }

  late final _$thereIsAnUberRequestAtom = Atom(
      name: 'PanelPassengerControllerBase.thereIsAnUberRequest',
      context: context);

  @override
  bool get thereIsAnUberRequest {
    _$thereIsAnUberRequestAtom.reportRead();
    return super.thereIsAnUberRequest;
  }

  @override
  set thereIsAnUberRequest(bool value) {
    _$thereIsAnUberRequestAtom.reportWrite(value, super.thereIsAnUberRequest,
        () {
      super.thereIsAnUberRequest = value;
    });
  }

  late final _$getRouteAwaitingDriverAcceptanceAsyncAction = AsyncAction(
      'PanelPassengerControllerBase.getRouteAwaitingDriverAcceptance',
      context: context);

  @override
  Future getRouteAwaitingDriverAcceptance() {
    return _$getRouteAwaitingDriverAcceptanceAsyncAction
        .run(() => super.getRouteAwaitingDriverAcceptance());
  }

  late final _$callUberAsyncAction =
      AsyncAction('PanelPassengerControllerBase.callUber', context: context);

  @override
  Future callUber() {
    return _$callUberAsyncAction.run(() => super.callUber());
  }

  late final _$cancelUberAsyncAction =
      AsyncAction('PanelPassengerControllerBase.cancelUber', context: context);

  @override
  Future cancelUber() {
    return _$cancelUberAsyncAction.run(() => super.cancelUber());
  }

  @override
  String toString() {
    return '''
positionCamera: ${positionCamera},
markers: ${markers},
destination: ${destination},
stateCallUber: ${stateCallUber},
stateCancelUber: ${stateCancelUber},
stateRetrieveInformationDestination: ${stateRetrieveInformationDestination},
stateGetRouteAwaitingDriverAcceptance: ${stateGetRouteAwaitingDriverAcceptance},
confirmation: ${confirmation},
thereIsAnUberRequest: ${thereIsAnUberRequest}
    ''';
  }
}
