import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:maharashtra_board_books/data/core/api_constants.dart';

class ApiFun {
  ApiFun._();

  static Future<dynamic> apiGetWithoutParams(String endpoint) async {
    http.Response response = await http.get(
      Uri.parse(ApiConstants.BASE_URL + endpoint),
    );
    if (kDebugMode) {
      print('$endpoint Api Res ----: ${response.body}');
    }

    return jsonDecode(response.body.toString());
  }

  static Future<dynamic> apiGetWithParams(String endpoint, String deviceId) async {
    http.Response response = await http.get(
      Uri.parse(ApiConstants.BASE_URL + endpoint + "?device_id=" + deviceId),
    );
    if (kDebugMode) {
      print('$endpoint Api Res ----: ${response.body}');
    }

    return jsonDecode(response.body.toString());
  }

  static Future<dynamic> apiPostWithoutBody(String endpoint) async {
    http.Response response = await http.post(
      Uri.parse(ApiConstants.BASE_URL + endpoint),
    );
    if (kDebugMode) {
      print('$endpoint Api Res ----: ${response.body}');
    }
    return jsonDecode(response.body.toString());
  }

  static Future<dynamic> apiPostWithBody(String endpoint, Map<String, dynamic> body) async {
    http.Response response = await http.post(
      Uri.parse(ApiConstants.BASE_URL + endpoint),
      body: body,
    );

    if (kDebugMode) {
      print('$endpoint Api Res ----: ${response.body}');
    }
    return jsonDecode(response.body.toString());
  }
}