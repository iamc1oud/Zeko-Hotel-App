import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zeko_hotel_crm/core/storage/shared_preferences.dart';
import 'dart:convert';

import 'package:zeko_hotel_crm/main.dart';

class HttpService {
  final String? baseUrl;

  HttpService({this.baseUrl});

  Future<Either<Exception, Map<String, dynamic>>> post(
      String endpoint, Map<String, dynamic> body) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: _headers(),
        body: jsonEncode(body),
      );

      var decodedResponse = _handleResponse(response);
      return Right(decodedResponse);
    } catch (e) {
      return Left(Exception('API Error: Check logs'));
    }
  }

  Map<String, String> _headers() {
    var token = getIt.get<SharedPreferences>().getString(PrefKeys.token.name);

    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  _handleResponse(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
          'HTTP request failed with status: ${response.statusCode}');
    }

    return jsonDecode(utf8.decode(response.bodyBytes)) as Map;
  }
}
