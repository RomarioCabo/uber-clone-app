import 'package:flutter/foundation.dart';

import '../../../domain/taxi_shipping/taxi_shipping_model.dart';
import '../../helpers/api_base_helper.dart';
import '../../util/strings.dart';

class TaxiShippingManager {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<TaxiShippingModel> callUber(
      {required TaxiShippingModel taxiShippingModel}) async {
    var data = taxiShippingModel.toJson();

    if (kDebugMode) {
      print(data);
    }

    final response = await _helper.post(
      url: "$baseUrl/taxi_shipping/create",
      body: data,
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
