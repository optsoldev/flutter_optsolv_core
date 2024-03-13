import 'package:dio/dio.dart';

class ResponseInterceptor extends InterceptorsWrapper {
  final Dio dio;
  ResponseInterceptor({required this.dio});

  @override
  Future onResponse(Response response, ResponseInterceptorHandler handler) async {
    /*var messages = response.data.messages;

    if(messages != null){
      
    }*/

    return super.onResponse(response, handler);
  }
}
