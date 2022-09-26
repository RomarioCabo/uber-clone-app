import 'package:flutter/foundation.dart';

import '../../../domain/taxi_shipping_history/taxi_shipping_history_model.dart';
import '../../helpers/api_base_helper.dart';
import '../../util/strings.dart';

class TaxiShippingHistoryManager {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<TaxiShippingHistoryModel?> getRouteAwaitingDriverAcceptance(
      {required int idPassenger}) async {
    final response = await _helper.get(
      url:
          "$baseUrl/taxi_shipping_history/passenger/waiting_accept_driver/$idPassenger",
    );

    return response == null
        ? null
        : TaxiShippingHistoryModel.fromJson(response);
  }

  Future<TaxiShippingHistoryModel> cancelUber(
  {required TaxiShippingHistoryModel taxiShippingHistoryModel}) async {
    var json = taxiShippingHistoryModel.model2Json();

    if (kDebugMode) {
      print(json);
    }

    final response = await _helper.post(
      url: "$baseUrl/taxi_shipping_history/create",
      body: json,
    );

    return TaxiShippingHistoryModel.fromJson(response);
  }
}
