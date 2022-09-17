import 'package:mobx/mobx.dart';
import 'package:uber_clone/domain/store/routes_driver/route_uber_controller.dart';

import '../../../infrastructure/helpers/request_state.dart';
import '../../../infrastructure/provider/taxi_shipping/taxi_shipping_provider_impl.dart';
import '../../taxi_shipping/taxi_shipping_model.dart';

part 'route_uber_controller_impl.g.dart';

class RouteUberControllerImpl = RouteUberControllerBase
    with _$RouteUberControllerImpl;

abstract class RouteUberControllerBase
    with Store
    implements RouteUberController {
  @observable
  RequestState requestStateGetAllUberEligibleRoutes = Initial();

  @observable
  ObservableList<TaxiShippingModel?> eligibleRoutes = ObservableList();

  final TaxiShippingProviderImpl _taxiShippingProvider =
      TaxiShippingProviderImpl();

  @override
  getAllUberEligibleRoutes() async {
    try {
      requestStateGetAllUberEligibleRoutes = Loading();

      await _getRoutes();

      requestStateGetAllUberEligibleRoutes = Completed();
    } catch (e) {
      requestStateGetAllUberEligibleRoutes = Error(
        error: e.toString(),
      );
    }
  }

  @override
  Future<void> reloadAllUberEligibleRoutes() async {
    await _getRoutes();
  }

  _getRoutes() async {
    await Future.delayed(const Duration(seconds: 1));

    eligibleRoutes = ObservableList<TaxiShippingModel?>.of(
      await _taxiShippingProvider.getAllUberEligibleRoutes(),
    );
  }
}
