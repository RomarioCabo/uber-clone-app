class ErrorModel {
  String? status;
  String? timestamp;
  List<String>? reasons;

  ErrorModel({this.status, this.timestamp, this.reasons});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    status = json.containsKey('status') && json['status'] != null
        ? json['status']
        : null;
    timestamp = json.containsKey('timestamp') && json['timestamp'] != null
        ? json['timestamp']
        : null;
    reasons = json.containsKey('reasons') && json['reasons'] != null
        ? json['reasons'].cast<String>()
        : null;
  }
}
