import 'package:uber_clone/domain/taxi_shipping/taxi_shipping_model.dart';
import 'package:uber_clone/infrastructure/provider/taxi_shipping/taxi_shipping_manager.dart';

import '../../../domain/provider/taxi_shipping_provider.dart';

class TaxiShippingProviderImpl implements TaxiShippingProvider {
  final TaxiShippingManager _manager = TaxiShippingManager();

  @override
  Future<TaxiShippingModel> callUber(TaxiShippingModel taxiShippingModel) {
    return _manager.callUber(taxiShippingModel);
  }
}