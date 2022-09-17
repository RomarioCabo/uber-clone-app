import 'dart:convert';

import '../destination/destination.dart';
import '../user/user_model.dart';

class TaxiShippingModel {
  String? id;
  Destination? destination;
  UserModel? driver;
  UserModel? passenger;
  String? createdAt;

  TaxiShippingModel({
    this.id,
    this.destination,
    this.driver,
    this.passenger,
    this.createdAt,
  });

  TaxiShippingModel.fromJson(Map<String, dynamic> json) {
    id = json.containsKey('id') && json['id'] != null ? json['id'] : null;
    destination = json.containsKey('destination') && json['destination'] != null
        ? Destination.fromJson(json['destination'])
        : null;
    driver = json.containsKey('driver') && json['driver'] != null
        ? UserModel.fromJson(json['driver'])
        : null;
    passenger = json.containsKey('passenger') && json['passenger'] != null
        ? UserModel.fromJson(json['passenger'])
        : null;
    createdAt = json.containsKey('createdAt') && json['createdAt'] != null
        ? json['createdAt']
        : null;
  }

  String model2Json() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (destination != null) {
      data['destination'] = destination!.toJson();
    }
    if (driver != null) {
      data['driver'] = driver!.toJson();
    } else {
      data['driver'] = null;
    }
    if (passenger != null) {
      data['passenger'] = passenger!.toJson();
    }
    data['createdAt'] = createdAt;
    return jsonEncode(data);
  }
}
