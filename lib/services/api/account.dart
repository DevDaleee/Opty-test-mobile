import 'package:dio/dio.dart';
import 'package:finance/services/constants.dart';
import 'package:finance/services/headers.dart';

class AccountService {
  static Future<Map<String, dynamic>> createUser(
      String email, String password, String name) async {
    var userData = <String, String>{
      "email": email,
      "password": password,
      "name": name,
    };

    Response response = await Dio().post(
      '${ApiConstants.basePath}/user/register',
      data: userData,
    );

    Map<String, dynamic> res = {
      "status_code": response,
      "data": response.statusMessage,
    };

    return res;
  }

  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    var userData = <String, String>{
      "email": email,
      "password": password,
    };

    Response response = await Dio().post(
      '${ApiConstants.basePath}/auth/login',
      data: userData,
    );
    if (response.statusCode != 200 || response.statusCode != 201) {
      await HeadersConfig.addTokenKey(
          accessKeyValue: response.data['access_token']);
    }
    Map<String, dynamic> res = {
      "status_code": response,
      "data": response.statusMessage,
    };

    return res;
  }

  static Future<Response> getUserByEmail(String email) async {
    var token = await HeadersConfig.readAccessToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    var response = await Dio().post(
      '${ApiConstants.basePath}/user/email',
      data: {"email": email},
      options: Options(headers: headers),
    );

    return response;
  }

  static Future<Map<String, dynamic>> getCurrentUser() async {
    var token = await HeadersConfig.readAccessToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    var response = await Dio().post(
      '${ApiConstants.basePath}/user/me',
      options: Options(headers: headers),
    );

    Map<String, dynamic> res = {
      "status_code": response,
      "data": response.statusMessage,
    };

    return res;
  }
}
