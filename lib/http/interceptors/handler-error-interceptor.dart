import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HandlerErrorInterceptor extends InterceptorsWrapper {
  final Dio dio;

  HandlerErrorInterceptor({required this.dio});

  @override
  Future onError(DioError err, handler) {
    String? message = err.message;

    if ((err.response?.data?['messages'] ?? "").toString().isNotEmpty) {
      message = err.response?.data?['messages']?.toList()?.join('/') ?? err.message;
    }

    /*if (err.response?.statusCode == 403) {
      Navigator.of(AppConfig.navigatorKey.currentContext!).pushReplacementNamed(AppRoutes.LOGIN);
    }*/

    throw Exception(message);
  }
}
