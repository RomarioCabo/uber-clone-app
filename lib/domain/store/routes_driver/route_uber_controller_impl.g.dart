// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_uber_controller_impl.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RouteUberControllerImpl on RouteUberControllerBase, Store {
  late final _$requestStateGetAllUberEligibleRoutesAtom = Atom(
      name: 'RouteUberControllerBase.requestStateGetAllUberEligibleRoutes',
      context: context);

  @override
  RequestState get requestStateGetAllUberEligibleRoutes {
    _$requestStateGetAllUberEligibleRoutesAtom.reportRead();
    return super.requestStateGetAllUberEligibleRoutes;
  }

  @override
  set requestStateGetAllUberEligibleRoutes(RequestState value) {
    _$requestStateGetAllUberEligibleRoutesAtom
        .reportWrite(value, super.requestStateGetAllUberEligibleRoutes, () {
      super.requestStateGetAllUberEligibleRoutes = value;
    });
  }

  late final _$requestStateTryAgainAtom = Atom(
      name: 'RouteUberControllerBase.requestStateTryAgain', context: context);

  @override
  RequestState get requestStateTryAgain {
    _$requestStateTryAgainAtom.reportRead();
    return super.requestStateTryAgain;
  }

  @override
  set requestStateTryAgain(RequestState value) {
    _$requestStateTryAgainAtom.reportWrite(value, super.requestStateTryAgain,
        () {
      super.requestStateTryAgain = value;
    });
  }

  late final _$eligibleRoutesAtom =
      Atom(name: 'RouteUberControllerBase.eligibleRoutes', context: context);

  @override
  ObservableList<TaxiShippingModel?> get eligibleRoutes {
    _$eligibleRoutesAtom.reportRead();
    return super.eligibleRoutes;
  }

  @override
  set eligibleRoutes(ObservableList<TaxiShippingModel?> value) {
    _$eligibleRoutesAtom.reportWrite(value, super.eligibleRoutes, () {
      super.eligibleRoutes = value;
    });
  }

  @override
  String toString() {
    return '''
requestStateGetAllUberEligibleRoutes: ${requestStateGetAllUberEligibleRoutes},
requestStateTryAgain: ${requestStateTryAgain},
eligibleRoutes: ${eligibleRoutes}
    ''';
  }
}
