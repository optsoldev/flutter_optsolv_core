import 'dart:io';

import 'package:dio/dio.dart';

import '../token-manager.dart';

class TokenInterceptor extends InterceptorsWrapper {
  final Dio dio;
  TokenInterceptor({required this.dio});

  @override
  Future onRequest(RequestOptions options, handler) async {
    TokenManager tokenManager = TokenManager();
    var token = options.headers[HttpHeaders.authorizationHeader];

    if (token == null) {
      //dio.lock();

      token = await tokenManager.getKey(tokenManager.AccessToken);
      //String? localId = await tokenManager.getKey(tokenManager.LocalId);

      final tokenExpired = await tokenManager.isTokenExpired();

      if (!tokenExpired) {
        //var auth = Provider.of<AuthProvider>(AppConfig.navigatorKey.currentContext!, listen: false);
        //var t = auth.accessToken;
      }

      //dio.unlock();

      options.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
      //options.headers['Local-Id'] = localId;
    }

    return super.onRequest(options, handler);
  }
}
