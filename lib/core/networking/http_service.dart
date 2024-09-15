import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zeko_hotel_crm/core/storage/storage.dart';
import 'package:zeko_hotel_crm/main.dart';

class HttpService {
  final String baseUrl;

  HttpService({required this.baseUrl});

  Future<dynamic> post(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
  }) async {
    var token = getIt.get<SharedPreferences>().getString(PrefKeys.token.name);

    final url = buildUrl(endpoint: endpoint, queryParams: queryParams);

    Map<String, dynamic> requestHeaders =
        buildHeaders(token: token) as Map<String, String>;
    try {
      if (headers != null) {
        requestHeaders.addAll(headers);
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    dynamic responseJson;

    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(body),
        headers: requestHeaders as Map<String, String>?,
      );

      debugPrint('POST: $url');

      responseJson = handleResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  // Creates a Map with the necessary headers for any request sent to our API
  Map buildHeaders({String? token}) {
    var headers = <String, String>{};

    // headers[Constants.apiKeyHeader] = apiKey;
    headers['Content-Type'] = 'application/json';

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
      // logger.d("${headers['Authorization']}");
    }

    return headers;
  }

  String buildUrl(
      {required String endpoint,
      Map<String, dynamic>? queryParams,
      String? preferredUrl}) {
    var apiUri = Uri.parse(baseUrl);
    final apiPath = '${apiUri.path}/$endpoint';
    final uri = Uri(
      scheme: apiUri.scheme,
      host: apiUri.host,
      port: apiUri.port,
      path: apiPath,
      queryParameters: queryParams,
    ).toString();

    return uri;
  }

  dynamic handleCampaignReponse(http.Response response) {
    var status = response.statusCode;
    var responseJson;
    if (status >= 200 && status < 300) {
      responseJson = json.decode(response.body);
    } else if (status == 400) {
      debugPrint(
        'Status: ${response.statusCode} Unable to login: ${response.body.toString()}',
      );
      throw BadRequestException(response.body.toString());
    } else if (status == 401 && status < 500) {
      debugPrint(
        'Status: ${response.statusCode} Unable to login: ${response.body.toString()}',
      );
      throw UnauthorisedException(response.body.toString());
    } else {
      debugPrint(
        'Status: ${response.statusCode} Unable to login: ${response.body.toString()}',
      );
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode} ${response.body}');
    }
    return responseJson;
  }

  dynamic handleResponse(http.Response response) {
    var status = response.statusCode;

    dynamic responseJson;

    responseJson = json.decode(response.body);

    if (status >= 200 && status < 300) {
      return responseJson;
    } else {
      // This type of error only due to message inside message object for create profile api.
      throw BadRequestException(responseJson['messageDetail']);
    }
  }

  dynamic handleBytes(http.Response response) {
    var status = response.statusCode;

    if (status >= 200 && status < 300) {
      return response.bodyBytes;
    } else if (status == 400) {
      // throw BadRequestException(responseJson['message']);
    } else if (status == 401) {
      // throw UnauthorisedException(responseJson['message']);
    } else {
      // throw BadRequestException(responseJson['message']);
    }
  }
}

// Exceptions
class CustomException implements Exception {
  final _message;
  final _prefix;

  CustomException([this._message, this._prefix]);

  @override
  String toString() {
    return '$_prefix$_message';
  }
}

class FetchDataException extends CustomException {
  String? message;
  FetchDataException([this.message])
      : super(message, 'Error During Communication: ');
}

class BadRequestException implements Exception {
  final String message;
  BadRequestException(this.message) : super();
}

class ApiError implements Exception {
  final String message;
  final int statusCode;
  final bool error;
  ApiError(this.message, this.statusCode, this.error);
}

class UnauthorisedException implements Exception {
  final String message;
  UnauthorisedException(this.message) : super();
}

class FormatException implements Exception {
  final List<Map<String, dynamic>> message;

  FormatException(this.message);
}

class InvalidInputException extends CustomException {
  InvalidInputException([String? message]) : super(message, 'Invalid Input: ');
}
