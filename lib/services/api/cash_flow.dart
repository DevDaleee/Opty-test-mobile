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

    try {
      var response = await Dio().post(
        '${ApiConstants.basePath}/cashflow/add/',
        data: cashFlowData,
        options: Options(headers: headers),
      );

      return {
        "success": true,
        "data": response.data,
        "statusCode": response.statusCode,
        "message": response.statusMessage ?? "Success",
      };
    } on DioException catch (e) {
      return {
        "success": false,
        "data": null,
        "statusCode": e.response?.statusCode ?? 500,
        "message": e.response?.data['message'] ?? "Something went wrong",
      };
    }
  }

  static Future<Map<String, dynamic>> deleteCashFlow(String cashFlowId) async {
    var token = await HeadersConfig.readAccessToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    try {
      var response = await Dio().post(
        '${ApiConstants.basePath}/cashflow/delete',
        data: {"id": cashFlowId},
        options: Options(headers: headers),
      );

      return {
        "success": true,
        "data": response.data,
        "statusCode": response.statusCode,
        "message": response.statusMessage ?? "Success",
      };
    } on DioException catch (e) {
      return {
        "success": false,
        "data": null,
        "statusCode": e.response?.statusCode ?? 500,
        "message": e.response?.data['message'] ?? "Something went wrong",
      };
    }
  }

  static Future<Map<String, dynamic>> updateCashFlow(
      String cashFlowId, Map<String, dynamic> updateData) async {
    var token = await HeadersConfig.readAccessToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    try {
      var response = await Dio().put(
        '${ApiConstants.basePath}/cashflow/$cashFlowId',
        data: updateData,
        options: Options(headers: headers),
      );

      return {
        "success": true,
        "data": response.data,
        "statusCode": response.statusCode,
        "message": response.statusMessage ?? "Success",
      };
    } on DioException catch (e) {
      return {
        "success": false,
        "data": null,
        "statusCode": e.response?.statusCode ?? 500,
        "message":
            e.response?.data?['message'] ?? "An unexpected error occurred",
      };
    } catch (e) {
      return {
        "success": false,
        "data": null,
        "statusCode": 500,
        "message": "Unexpected error: $e",
      };
    }
  }

  static Future<List<dynamic>> getAllCashFlows() async {
    var token = await HeadersConfig.readAccessToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    var response = await Dio().get(
      '${ApiConstants.basePath}/cashflow/getAll/',
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

    try {
      var response = await Dio().get(
        '${ApiConstants.basePath}/cashflow/$cashFlowId',
        options: Options(headers: headers),
      );

      return {
        "success": true,
        "data": response.data,
        "statusCode": response.statusCode,
        "message": response.statusMessage ?? "Success",
      };
    } on DioException catch (e) {
      return {
        "success": false,
        "data": null,
        "statusCode": e.response?.statusCode ?? 500,
        "message": e.response?.data['message'] ?? "Something went wrong",
      };
    }
  }
}
