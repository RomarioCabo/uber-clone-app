import 'dart:convert';

class Destination {
  String? street;
  String? number;
  String? state;
  String? city;
  String? neighborhood;
  String? postalCode;
  double? latitude;
  double? longitude;

  Destination({
    this.street,
    this.number,
    this.state,
    this.city,
    this.neighborhood,
    this.postalCode,
    this.latitude,
    this.longitude,
  });

  Destination.fromJson(Map<String, dynamic> json) {
    street = json.containsKey('street') && json['street'] != null
        ? json['street']
        : null;
    number = json.containsKey('number') && json['number'] != null
        ? json['number']
        : null;
    state = json.containsKey('state') && json['state'] != null
        ? json['state']
        : null;
    city =
        json.containsKey('city') && json['city'] != null ? json['city'] : null;
    neighborhood =
        json.containsKey('neighborhood') && json['neighborhood'] != null
            ? json['neighborhood']
            : null;
    postalCode = json.containsKey('postalCode') && json['postalCode'] != null
        ? json['postalCode']
        : null;
    latitude = json.containsKey('latitude') && json['latitude'] != null
        ? json['latitude']
        : null;
    longitude = json.containsKey('longitude') && json['longitude'] != null
        ? json['longitude']
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['street'] = street;
    data['number'] = number;
    data['state'] = state;
    data['city'] = city;
    data['neighborhood'] = neighborhood;
    data['postalCode'] = postalCode;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }

  String model2Json() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['street'] = street;
    data['number'] = number;
    data['state'] = state;
    data['city'] = city;
    data['neighborhood'] = neighborhood;
    data['postalCode'] = postalCode;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return jsonEncode(data);
  }
}
