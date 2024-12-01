import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:finance/services/constants.dart';
import 'package:finance/services/headers.dart';

class CashFlowService {
  static Future<Map<String, dynamic>> addCashFlow(
      Map<String, dynamic> cashFlowData) async {
    var token = await HeadersConfig.readAccessToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    var response = await Dio().post(
      '${ApiConstants.basePath}/cashflow/add',
      data: cashFlowData,
      options: Options(headers: headers),
    );

    return _handleResponse(response);
  }

  static Future<Map<String, dynamic>> deleteCashFlow(String cashFlowId) async {
    var token = await HeadersConfig.readAccessToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    var response = await Dio().post(
      '${ApiConstants.basePath}/cashflow/delete',
      data: {"id": cashFlowId},
      options: Options(headers: headers),
    );

    return _handleResponse(response);
  }

  static Future<List<dynamic>> getAllCashFlows() async {
    var token = await HeadersConfig.readAccessToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    var response = await Dio().get(
      '${ApiConstants.basePath}/cashflow/getAll',
      options: Options(headers: headers),
    );

    if (response.data is List<dynamic> && response.data != null) {
      return response.data;
    }

    return [];
  }

  static Future<Map<String, dynamic>> getCashFlowById(String cashFlowId) async {
    var token = await HeadersConfig.readAccessToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    var response = await Dio().get(
      '${ApiConstants.basePath}/cashflow/$cashFlowId',
      options: Options(headers: headers),
    );

    return _handleResponse(response);
  }

  static Map<String, dynamic> _handleResponse(Response response) {
    if (response.statusCode == 200) {
      return {
        "status_code": response.statusCode,
        "data": json.decode(utf8.decode(response.data)),
      };
    }
    return {
      "status_code": response.statusCode,
      "detail": json.decode(utf8.decode(response.data))['detail'],
    };
  }
}
