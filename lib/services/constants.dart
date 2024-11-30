import 'package:dio/dio.dart';

class ApiConstants {
  static var basePath = 'http://localhost:3333';
  static Dio dio = Dio();
  // dio.options.connectTimeout = const Duration(seconds: 10);
  // dio.options.receiveTimeout = const Duration(seconds: 10);
  // dio.options.headers = {'Content-Type': 'application/json'};
}
