import 'package:dio/dio.dart';
import 'package:finance/services/constants.dart';
import 'package:finance/services/headers.dart';

class AccountService {
  static Future<Map<String, dynamic>> createUser(
      String email, String password, String name) async {
    try {
      var userData = <String, String>{
        "email": email,
        "password": password,
        "name": name,
      };

      Response response = await Dio().post(
        '${ApiConstants.basePath}/user/register',
        data: userData,
      );

      return {
        "success": true,
        "data": response.data,
        "statusCode": response.statusCode,
        "message": response.statusMessage ?? "User created successfully",
      };
    } on DioException catch (e) {
      return {
        "success": false,
        "data": null,
        "statusCode": e.response?.statusCode ?? 500,
        "message": e.response?.data['message'] ?? "Failed to create user",
      };
    }
  }

  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    try {
      var userData = <String, String>{
        "email": email,
        "password": password,
      };

      Response response = await Dio().post(
        '${ApiConstants.basePath}/auth/login',
        data: userData,
      );

      // Adiciona o token se a resposta for bem-sucedida
      if (response.statusCode == 200 || response.statusCode == 201) {
        await HeadersConfig.addTokenKey(
            accessKeyValue: response.data['access_token']);
      }

      return {
        "success": true,
        "data": response.data,
        "statusCode": response.statusCode,
        "message": response.statusMessage ?? "Login successful",
      };
    } on DioException catch (e) {
      return {
        "success": false,
        "data": null,
        "statusCode": e.response?.statusCode ?? 500,
        "message": e.response?.data['message'] ?? "Login failed",
      };
    }
  }

  static Future<Map<String, dynamic>> getUserByEmail(String email) async {
    try {
      var token = await HeadersConfig.readAccessToken();

      var headers = <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      Response response = await Dio().post(
        '${ApiConstants.basePath}/user/email',
        data: {"email": email},
        options: Options(headers: headers),
      );

      return {
        "success": true,
        "data": response.data,
        "statusCode": response.statusCode,
        "message": response.statusMessage ?? "User retrieved successfully",
      };
    } on DioException catch (e) {
      return {
        "success": false,
        "data": null,
        "statusCode": e.response?.statusCode ?? 500,
        "message": e.response?.data['message'] ?? "Failed to retrieve user",
      };
    }
  }

  static Future<Map<String, dynamic>> getCurrentUser() async {
    var token = await HeadersConfig.readAccessToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    try {
      var response = await Dio().post(
        '${ApiConstants.basePath}/user/me',
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
