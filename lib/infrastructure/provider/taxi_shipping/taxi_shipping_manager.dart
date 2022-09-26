import 'package:flutter/foundation.dart';

import '../../../domain/taxi_shipping/taxi_shipping_model.dart';
import '../../helpers/api_base_helper.dart';
import '../../util/strings.dart';

class TaxiShippingManager {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<TaxiShippingModel> callUber(
      {required TaxiShippingModel taxiShippingModel}) async {
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

  Future<List<TaxiShippingModel?>> getAllUberEligibleRoutes() async {
    final response = await _helper.get(
      url: "$baseUrl/get_all_uber_eligible_routes",
    );

    return List<TaxiShippingModel>.from(
      response.map((item) => TaxiShippingModel.fromJson(item)),
    );
  }
}
