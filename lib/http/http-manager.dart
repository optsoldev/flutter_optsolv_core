import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:path/path.dart';

import 'api-result.dart';
import 'base-model.dart';
import 'exceptions.dart';
import 'interceptors/interceptors.dart';

typedef ObjectCreator<T> = T Function(Map<String, dynamic>);

class HttpManager<T extends BaseModel> {
  final ObjectCreator<T> creator;
  late Dio _dio;

  HttpManager(this.creator) {
    _dio = Dio(BaseOptions(
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    ));

    _dio.httpClientAdapter = IOHttpClientAdapter(createHttpClient: () {
      var client = HttpClient();
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    });

    _dio.interceptors.add(TokenInterceptor(dio: _dio));
    _dio.interceptors.add(RefreshTokenInterceptor(dio: _dio));
    _dio.interceptors.add(HandlerErrorInterceptor(dio: _dio));
    _dio.interceptors.add(ResponseInterceptor(dio: _dio));
  }

  Future<ApiResult<T>> delete(String url, Map<String, dynamic> data) async {
    var response = await _dio.delete(url, data: data);
    return _returnResponse(response);
  }

  Future<Response<dynamic>> download(String url, String path,
      {Map<String, dynamic>? data, String method = 'GET'}) async {
    var response = await _dio.download(url, path,
        data: data, options: Options(method: method));
    return response;
  }

  Future<ApiResult<T>> get(String url) async {
    var response = await _dio.get(url);
    return _returnResponse(response);
  }

  Future<ApiResult<List<T>>> getAll(String url,
      [Map<String, dynamic>? data]) async {
    var response = await _dio.get(url, queryParameters: data);
    return _returnResponseList(response);
  }

  Future<dynamic> getDynamic(String url) async {
    var response = await _dio.get(url);
    return response;
  }

  Future<ApiResult<T>> post(String url, Map<String, dynamic>? data) async {
    var response = await _dio.post(url, data: data);
    return _returnResponse(response);
  }

  Future<ApiResult<List<T>>> postAll(String url,
      [Map<String, dynamic>? data]) async {
    var response = await _dio.post(url, data: data);
    return _returnResponseList(response);
  }

  Future<ApiResult<T>> postAttachments(String url, Map<String, dynamic> data,
      {String filePropertyName = "", List<File> files = const []}) async {
    FormData fdata = FormData.fromMap(data);

    for (final item in files) {
      fdata.files.add(MapEntry(
          filePropertyName,
          await MultipartFile.fromFile(item.path,
              filename: basename(item.path))));
    }

    var response = await _dio.post(url, data: fdata);

    return _returnResponse(response);
  }

  Future<dynamic> postDynamic(String url, Map<String, dynamic>? data) async {
    var response = await _dio.post(url, data: data);
    return response;
  }

  Future<ApiResult<T>> put(String url, Map<String, dynamic>? data) async {
    var response = await _dio.put(url, data: data);
    return _returnResponse(response);
  }

  Future<dynamic> putDynamic(String url, Map<String, dynamic>? data) async {
    var response = await _dio.put(url, data: data);
    return response;
  }

  ApiResult<T> _returnResponse(Response<dynamic> response) {
    if ((response.statusCode! >= 200 && response.statusCode! <= 299) ||
        response.statusCode == 400) {
      ApiResult<T> result = ApiResult<T>();

      result.success = response.data['success'];
      result.failure = response.data['failure'];
      result.messages = response.data['messages'].toList().cast<String>();

      if (response.data['data'] != null) {
        result.data = this.creator(response.data['data']);
      }

      return result;
    }

    switch (response.statusCode) {
      case 400:
        throw BadRequestException();
      case 401:
      case 403:
        throw UnauthorisedException();
      case 500:
      default:
        throw FetchDataException();
    }
  }

  ApiResult<List<T>> _returnResponseList(Response<dynamic> response) {
    if ((response.statusCode! >= 200 && response.statusCode! <= 299) ||
        response.statusCode == 400) {
      ApiResult<List<T>> result = ApiResult<List<T>>();

      result.success = response.data['success'];
      result.failure = response.data['failure'];
      result.messages = response.data['messages']?.toList().cast<String>();
      result.total = response.data['total'];
      result.page = response.data['page'];
      result.pageSize = response.data['pageSize'];

      if (response.data['data'] is List) {
        result.data = response.data['data']
            .map((e) => this.creator(e))
            .toList()
            .cast<T>();
      } else if (response.data['data']?['items'] != null) {
        result.data = response.data['data']['items']
            .map((e) => this.creator(e))
            .toList()
            .cast<T>();
      } else {
        result.data = [];
      }

      return result;
    }

    switch (response.statusCode) {
      case 400:
        throw BadRequestException();
      case 401:
      case 403:
        throw UnauthorisedException();
      case 500:
      default:
        throw FetchDataException();
    }
  }
}
