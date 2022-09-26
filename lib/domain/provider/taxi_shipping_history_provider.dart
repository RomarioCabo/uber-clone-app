import '../taxi_shipping_history/taxi_shipping_history_model.dart';

abstract class TaxiShippingHistoryProvider {
  Future<TaxiShippingHistoryModel?> getRouteAwaitingDriverAcceptance(
      {required int idPassenger});

  Future<TaxiShippingHistoryModel> cancelUber(
      {required TaxiShippingHistoryModel taxiShippingHistoryModel});
}
