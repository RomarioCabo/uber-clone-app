import 'dart:convert';

class TaxiShippingHistoryModel {
  String? id;
  String? idTaxiShipping;
  String? statusRoute;
  String? eventDate;

  TaxiShippingHistoryModel({
    this.id,
    this.idTaxiShipping,
    this.statusRoute,
    this.eventDate,
  });

  TaxiShippingHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json.containsKey('id') && json['id'] != null ? json['id'] : null;
    idTaxiShipping =
        json.containsKey('idTaxiShipping') && json['idTaxiShipping'] != null
            ? json['idTaxiShipping']
            : null;
    statusRoute = json.containsKey('statusRoute') && json['statusRoute'] != null
        ? json['statusRoute']
        : null;
    eventDate = json.containsKey('eventDate') && json['eventDate'] != null
        ? json['eventDate']
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idTaxiShipping'] = idTaxiShipping;
    data['statusRoute'] = statusRoute;
    data['eventDate'] = eventDate;
    return data;
  }

  String model2Json() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idTaxiShipping'] = idTaxiShipping;
    data['statusRoute'] = statusRoute;
    data['eventDate'] = eventDate;
    return jsonEncode(data);
  }
}
