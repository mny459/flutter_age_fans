import 'dart:async';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:j_net/core/j_net_adapter.dart';
import 'package:j_net/core/j_net_error.dart';
import 'package:j_net/request/j_base_request.dart';
import 'package:logging/logging.dart';

import 'cookie_util.dart';

/// Dio适配器
class AgeDioAdapter extends JNetAdapter {
  final _log = Logger('Http');
  final _dio = Dio();
  late CookieJar cookieJar;

  AgeDioAdapter() {
    initCookie();
  }

  void initCookie() async {
    if (!kIsWeb) {
      cookieJar = PersistCookieJar(
        storage: FileStorage(await CookieUtil.getCookiePath()),
      );
      _dio.interceptors.add(CookieManager(cookieJar));
    }

    _dio.interceptors.add(ApiInterceptor());
  }

  @override
  Future<JNetResponse<T>> send<T>(JNetRequest request) async {
    dynamic response, options = Options(headers: request.header);
    var error;
    try {
      if (request.httpMethod == HttpMethod.GET) {
        response = await _dio.get(request.url(), options: options);
      } else if (request.httpMethod == HttpMethod.POST) {
        response = await _dio.post(request.url(),
            data: FormData.fromMap(request.params), options: options);
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
      _log.warning('age net error - ${error.toString()}');
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
        statusCode: response.statusCode!,
        statusMessage: response.statusMessage!,
        extra: response);
  }
}

/// 玩Android API
class ApiInterceptor extends InterceptorsWrapper {
  final _log = Logger('Http');

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _log.info('request url > ${options.baseUrl}${options.path}');
    if (options.queryParameters.isNotEmpty) {
      _log.info('queryParameters: ${options.queryParameters}');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _log.info(
        'response data < ${response.data} from ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }
}
