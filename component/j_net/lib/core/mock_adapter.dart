import 'package:j_net/request/j_base_request.dart';

import 'j_net_adapter.dart';

///测试适配器，mock数据
class MockAdapter extends JNetAdapter {
  @override
  Future<JNetResponse<T>> send<T>(JNetRequest request) {
    return Future<JNetResponse>.delayed(Duration(milliseconds: 1000), () {
      return JNetResponse(
          data: {"code": 0, "message": 'success'}, statusCode: 403);
    }) as Future<JNetResponse<T>>;
  }
}
