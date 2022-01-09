library j_net;

import 'core/dio_adapter.dart';
import 'core/j_interceptor.dart';
import 'core/j_net_adapter.dart';
import 'core/j_net_error.dart';
import 'request/j_base_request.dart';

///1.支持网络库插拔设计，且不干扰业务层
///2.基于配置请求请求，简洁易用
///3.Adapter设计，扩展性强
///4.统一异常和返回处理
class JNet {
  JErrorInterceptor? _hiErrorInterceptor;

  static JNet? _instance;

  JNet._();

  static JNet getInstance() {
    _instance ??= JNet._();
    return _instance!;
  }

  JNetAdapter _adapter = DioAdapter();

  void setAdapter(JNetAdapter adapter) {
    _adapter = adapter;
  }

  Future fire(JNetRequest request) async {
    JNetResponse? response;
    var error;
    try {
      response = await send(request);
    } on JNetError catch (e) {
      error = e;
      response = e.data;
      _log(e.message);
    } catch (e) {
      //其它异常
      error = e;
      _log(e);
    }
    if (response == null) {
      _log(error);
    }
    var result = response!.data;
    _log(result);
    var status = response.statusCode;
    var hiError;
    switch (status) {
      case 200:
        return result;
        break;
      case 401:
        hiError = NeedLogin();
        break;
      case 403:
        hiError = NeedAuth(result.toString(), data: result);
        break;
      default:
        hiError = JNetError(status, result.toString(), data: result);
        break;
    }
    //交给拦截器处理错误
    if (_hiErrorInterceptor != null) {
      _hiErrorInterceptor!(hiError);
    }
    throw hiError;
  }

  Future<JNetResponse<T>> send<T>(JNetRequest request) async {
    ///使用Dio发送请求
    return _adapter.send(request);
  }

  void setErrorInterceptor(JErrorInterceptor interceptor) {
    _hiErrorInterceptor = interceptor;
  }

  void _log(log) {
    print('JNet:' + log.toString());
  }
}
