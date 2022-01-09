import 'dart:async';

import 'package:dio/dio.dart';
import 'package:j_net/request/j_base_request.dart';

import 'j_net_adapter.dart';
import 'j_net_error.dart';

/// Dio适配器
class DioAdapter extends JNetAdapter {
  final _dio = Dio();

  @override
  Future<JNetResponse<T>> send<T>(JNetRequest request) async {
    dynamic response, options = Options(headers: request.header);
    var error;
    try {
      if (request.httpMethod == HttpMethod.GET) {
        response = await _dio.get(request.url(), options: options);
      } else if (request.httpMethod == HttpMethod.POST) {
        response = await _dio.post(request.url(),
            data: request.params, options: options);
      } else if (request.httpMethod == HttpMethod.DELETE) {
        response = await _dio.delete(request.url(),
            data: request.params, options: options);
      }
    } on DioError catch (e) {
      error = e;
      response = e.response;
    }
    if (error != null) {
      /// 抛出HiNetError
      throw JNetError(response?.statusCode ?? -1, error.toString(),
          data: buildRes(response, request));
    }
    return buildRes(response, request) as FutureOr<JNetResponse<T>>;
  }

  /// 构建HiNetResponse
  JNetResponse buildRes(Response response, JNetRequest request) {
    return JNetResponse(
        data: response.data,
        request: request,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        extra: response);
  }
}
