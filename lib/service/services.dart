import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../app_utility/singleton.dart';

class HttpServices {
  static final HttpServices _instance = HttpServices._internal();



  factory HttpServices() => _instance;
  late Dio dio;
 // static String baseURL = "https://central.dev.apptra.com.au/api/pact/task_v2/";
  static String baseURL = "https://central.apptra.com.au/api/pact/task_v2/";

  HttpServices._internal()  {
    BaseOptions options = BaseOptions(
      baseUrl: baseURL,
      connectTimeout: const Duration(seconds: 15000),
      receiveTimeout: const Duration(seconds: 18000),
      followRedirects: true,
      headers: {"Authorization": Singleton().token},
      contentType: 'application/json',
      responseType: ResponseType.json,

    );
    dio = Dio(options);
  }

   setHeader(){
    dio.options.headers["Authorization"] = Singleton().token;
  }

  Future post(String path,
      {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      debugPrint("post path-> $path");
      debugPrint("post Authorization-> ${dio.options.headers["Authorization"]}");
      var response =
      await dio.post(path, data:FormData.fromMap(data), queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      return exceptionData(e);
    }
  }

  Future postPost(String path,
      {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      debugPrint("post path-> $path");
      debugPrint("post Authorization-> ${dio.options.headers["Authorization"]}");
      var response =
      await dio.post(path, data:FormData.fromMap(data), queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      return exceptionData(e);
    }
  }


  Future postMultipartFile(String path,
      {required FormData data, Map<String, dynamic>? queryParameters}) async {

    try {

      var response =
      await dio.post(path, data:data, onReceiveProgress: (int sentBytes, int totalBytes) {
        double progressPercent = sentBytes / totalBytes * 100;
        if (progressPercent == 100) {

        }
      },
        onSendProgress: (int sentBytes, int totalBytes) async{

          double progressPercent = sentBytes / totalBytes * 100;
          Singleton().percentage=progressPercent.toInt();
          if (progressPercent == 100) {
          }
        },);
      return response.data;

    } on DioException catch (e) {
      return exceptionData(e);
    }
  }


  Future get(String path) async {

    try {
      var response = await dio.get(path);
      return response.data;
    } on DioException catch (e) {
      return exceptionData(e);
    }
  }

  Future put(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      var response = await dio.put(path, data: data, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      return exceptionData(e);
    }
  }

  Future delete(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      var response = await dio.delete(path, data: data, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      return exceptionData(e);
    }
  }

  String exceptionData(dynamic error) {
    if (error is DioException) {
      return _handleDioError(error);
    }
    if (error is SocketException) {
      return "Network Connection Failed";
    }
    return "Unexpected Error";
  }

  String _handleDioError(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.badResponse:
        return "Invalid Server Response";
      case DioExceptionType.connectionTimeout:
        return "Connection Timed Out";
      case DioExceptionType.receiveTimeout:
        return "Server Response Timeout";
      case DioExceptionType.sendTimeout:
        return "Request Send Timeout";
      case DioExceptionType.connectionError:
        return "Network Connection Failed";
      case DioExceptionType.unknown:
        return "Network Error";
      case DioExceptionType.badCertificate:
        return "Invalid Security Certificate";
      case DioExceptionType.cancel:
        return "Request Cancelled";
    }
  }

}
