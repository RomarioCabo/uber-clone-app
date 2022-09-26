import '../taxi_shipping/taxi_shipping_model.dart';

abstract class TaxiShippingProvider {
  Future<TaxiShippingModel> callUber(
      {required TaxiShippingModel taxiShippingModel});

  Future<List<TaxiShippingModel?>> getAllUberEligibleRoutes();
}
