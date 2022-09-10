import '../taxi_shipping_history/taxi_shipping_history_model.dart';

abstract class TaxiShippingHistoryProvider {
  Future<TaxiShippingHistoryModel?> getRouteAwaitingDriverAcceptance(
      int idPassenger);

  Future<TaxiShippingHistoryModel> cancelUber(
      TaxiShippingHistoryModel taxiShippingHistoryModel);
}
