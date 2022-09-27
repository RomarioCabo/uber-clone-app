import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../domain/error/error_model.dart';
import 'api_exception.dart';

class ApiBaseHelper {
  Future<dynamic> post({
    required String url,
    required Map<String, dynamic> body,
  }) async {
    try {
      Response response;

      var dio = Dio();

      response = await dio.post(url, data: body);
      var data = response.data;

      _printResponse(response.statusCode, data);

      return data;
    } catch (e) {
      if (e is DioError) {
        _buildResponseError(e.response?.statusCode, e.response?.data);
      }
    }
  }

  Future<dynamic> get({
    required String url,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      Response response;

      var dio = Dio();
      response = await dio.get(url, queryParameters: queryParams);
      var data = response.data;

      _printResponse(response.statusCode, data);

      return data;
    } catch (e) {
      if (e is DioError) {
        _buildResponseError(e.response?.statusCode, e.response?.data);
      }
    }
  }

  void _buildResponseError(
    int? statusCode,
    dynamic data,
  ) {
    if (kDebugMode) {
      print("$statusCode $data");
    }

    var error = _buildMessageError(data);

    switch (statusCode) {
      case 400:
        throw BadRequestException(
          statusCode,
          error,
        );

      case 401:
      case 403:
        throw UnauthorisedException(
          statusCode,
          error,
        );

      case 500:
      default:
        throw FetchDataException(
          statusCode,
          error,
        );
    }
  }

  String _buildMessageError(dynamic errorMessage) {
    var error = ErrorModel.fromJson(errorMessage);
    return error.reasons![0];
  }

  void _printResponse(int? statusCode, dynamic data) {
    if (kDebugMode) {
      print("$statusCode $data");
    }
  }
}
