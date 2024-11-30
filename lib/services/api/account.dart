import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:finance/services/constants.dart';
import 'package:finance/services/headers.dart';

class AccountService {
  static Future<Map<String, dynamic>> profile() async {
    var token = await HeadersConfig.readAccessToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    var response = await ApiConstants.dio.get(
      '${ApiConstants.basePath}/me',
      options: Options(
        headers: headers,
      ),
    );

    if (response.statusCode == 200) {
      return {
        "status_code": response.statusCode,
        "data": json.decode(
          utf8.decode(response.data),
        ),
      };
    }

    return {
      "status_code": response.statusCode,
      "detail": json.decode(utf8.decode(response.data))['detail']
    };
  }
}
