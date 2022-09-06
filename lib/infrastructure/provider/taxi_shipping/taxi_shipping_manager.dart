import 'package:flutter/foundation.dart';

import '../../../domain/taxi_shipping/taxi_shipping_model.dart';
import '../../helpers/api_base_helper.dart';
import '../../util/strings.dart';

class TaxiShippingManager {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<TaxiShippingModel> callUber(
      TaxiShippingModel taxiShippingModel) async {
    String json = taxiShippingModel.model2Json();

    if (kDebugMode) {
      print(json);
    }

    final response = await _helper.post(
      url: "$baseUrl/taxi_shipping/create",
      body: json,
    );

    return TaxiShippingModel.fromJson(response);
  }
}
