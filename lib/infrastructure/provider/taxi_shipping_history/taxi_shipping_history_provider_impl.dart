import 'package:uber_clone/domain/taxi_shipping_history/taxi_shipping_history_model.dart';
import 'package:uber_clone/infrastructure/provider/taxi_shipping_history/taxi_shipping_history_manager.dart';

import '../../../domain/provider/taxi_shipping_history_provider.dart';

class TaxiShippingHistoryProviderImpl implements TaxiShippingHistoryProvider {
  final TaxiShippingHistoryManager _manager = TaxiShippingHistoryManager();

  @override
  Future<TaxiShippingHistoryModel?> getRouteAwaitingDriverAcceptance(
      {required int idPassenger}) async {
    return await _manager.getRouteAwaitingDriverAcceptance(
        idPassenger: idPassenger);
  }

  @override
  Future<TaxiShippingHistoryModel> cancelUber(
      {required TaxiShippingHistoryModel taxiShippingHistoryModel}) async {
    return await _manager.cancelUber(
        taxiShippingHistoryModel: taxiShippingHistoryModel);
  }
}
