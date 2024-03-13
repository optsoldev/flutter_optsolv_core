import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../config/app-config.dart';
import '../../config/app-routes.dart';
import '../token-manager.dart';

class RefreshTokenInterceptor extends InterceptorsWrapper {
  final Dio dio;
  late int failRequestUnahtorize;
  late Duration retryInterval;

  RefreshTokenInterceptor({required this.dio}) {
    failRequestUnahtorize = 3;
    retryInterval = const Duration(seconds: 3);
  }

  @override
  Future onResponse(Response response, handler) async {
    if (response.statusCode == 403) {
      Navigator.of(AppConfig.navigatorKey.currentContext!).pushReplacementNamed(AppRoutes.LOGIN);
    }

    if (response.statusCode == 401) {
      //em cada onRespose so chama a await se for 401, evitando dar await em todos statusCode
      if (await TokenManager().isTokenExpired()) {
        /*dio.lock();
        try {
          if (failRequestUnahtorize > 0) {
            failRequestUnahtorize -= 1;

            Provider.of<AuthProvider>(AppConfig.navigatorKey.currentContext!, listen: false).tokenRefresh();

            await Future.delayed(retryInterval);
            return sendRequest(response);
          }
        } catch (e) {}
        dio.unlock();*/

        Navigator.of(AppConfig.navigatorKey.currentContext!).pushReplacementNamed(AppRoutes.LOGIN);
      }

      throw Exception('Tratar refresh token');
    }

    return super.onResponse(response, handler);
  }

  Future<Response> sendRequest(Response response) {
    return dio.request(response.requestOptions.path,
        cancelToken: response.requestOptions.cancelToken,
        data: response.data,
        onReceiveProgress: response.requestOptions.onReceiveProgress,
        onSendProgress: response.requestOptions.onSendProgress,
        queryParameters: response.requestOptions.queryParameters,
        options: Options(headers: response.requestOptions.headers));
  }
}
