enum HttpMethod { GET, POST, DELETE }

///基础请求
abstract class JNetRequest {
  // curl -X GET "http://api.devio.org/uapi/test/test?requestPrams=11" -H "accept: */*"
  // curl -X GET "https://api.devio.org/uapi/test/test/1
  final params = <String, dynamic>{};
  final header = <String, dynamic>{};

  var pathParams;
  var useHttps = true;

  String get authority {
    return 'api.devio.org';
  }

  HttpMethod get httpMethod;

  String get path;

  bool get needLogin;

  String url() {
    Uri uri;
    var pathStr = path;
    // 拼接path参数
    if (pathParams != null) {
      if (path.endsWith('/')) {
        pathStr = '$path$pathParams';
      } else {
        pathStr = '$path/$pathParams';
      }
    }
    // http和https切换
    if (useHttps) {
      uri = Uri.https(
          authority,
          pathStr,
          params.isEmpty || httpMethod != HttpMethod.GET
              ? null
              : params.map((key, value) => MapEntry(key, value.toString())));
    } else {
      uri = Uri.http(
          authority,
          pathStr,
          params.isEmpty || httpMethod != HttpMethod.GET
              ? null
              : params.map((key, value) => MapEntry(key, value.toString())));
    }
    return uri.toString();
  }

  ///添加参数
  JNetRequest addParam(String key, dynamic value) {
    params[key] = value;
    return this;
  }

  ///添加header
  JNetRequest addHeader(String key, dynamic value) {
    header[key] = value;
    return this;
  }
}
