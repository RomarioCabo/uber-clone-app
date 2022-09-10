import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:uber_clone/domain/error/error_model.dart';
import 'package:uber_clone/infrastructure/helpers/api_exception.dart';

class ApiBaseHelper {
  Future<dynamic> post({
    required String url,
    required String body,
  }) async {
    return await _request(
      httpMethod: "POST",
      url: url,
      body: body,
    );
  }

  Future<dynamic> get(
      {required String url, String? queryParams}) async {
    return await _request(
      httpMethod: "GET",
      url: url,
      queryParams: queryParams,
    );
  }

  Future<dynamic> _request({
    required String httpMethod,
    required String url,
    String? body,
    String? queryParams,
  }) async {
    dynamic responseJson;

    if (kDebugMode) {
      print(url);
    }

    var headers = {
      'Content-Type': 'application/json;charset=UTF-8',
    };

    var request = http.Request(httpMethod, Uri.parse(url));

    request.headers.addAll(headers);

    if (body != null) {
      request.body = body;
    }

    http.Response response =
        await http.Response.fromStream(await request.send());

    responseJson = _returnResponse(response);

    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    if (kDebugMode) {
      print("${response.statusCode} ${utf8.decode(response.bodyBytes)}");
    }

    switch (response.statusCode) {
      case 201:
      case 200:
        if (response.bodyBytes.isEmpty) {
          return null;
        } else {
          return json.decode(utf8.decode(response.bodyBytes));
        }

      case 400:
        var error = json.decode(utf8.decode(response.bodyBytes));

        throw BadRequestException(
          response.statusCode,
          _buildMessageError(error),
        );

      case 401:
      case 403:
        var error = json.decode(utf8.decode(response.bodyBytes));

        throw UnauthorisedException(
          response.statusCode,
          _buildMessageError(error),
        );

      case 500:
      default:
        var error = json.decode(utf8.decode(response.bodyBytes));

        throw FetchDataException(
          response.statusCode,
          _buildMessageError(error),
        );
    }
  }

  String _buildMessageError(dynamic errorMessage) {
    var error = ErrorModel.fromJson(errorMessage);
    return error.reasons![0];
  }
}
