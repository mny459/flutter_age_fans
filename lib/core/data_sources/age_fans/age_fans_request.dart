import 'package:j_net/request/j_base_request.dart';

abstract class AgeFansRequest extends JNetRequest {
  @override
  String get authority => 'api.agefans.app';

  @override
  HttpMethod get httpMethod => HttpMethod.GET;

  @override
  bool get needLogin => false;
}

class AgeFansMainRequest extends AgeFansRequest {
  @override
  String get authority => "spa-1259460662.cos.accelerate.myqcloud.com";

  @override
  String get path => "/agefans/api/age.json";
}

class AgeFansRecommendRequest extends AgeFansRequest {
  final int page;

  AgeFansRecommendRequest(this.page) {
    addParam('page', page);
    addParam('size', 30);
  }

  @override
  String get path => '/v2/recommend';
}

class AgeFansUpdateRequest extends AgeFansRequest {
  final int page;

  AgeFansUpdateRequest(this.page) {
    addParam('page', page);
    addParam('size', 30);
  }

  @override
  String get path => '/v2/update';
}

class AgeFansDetailRequest extends AgeFansRequest {
  final String cid;

  AgeFansDetailRequest(this.cid);

  @override
  String get path => '/v2/detail/$cid';
}

class AgeFansRankRequest extends AgeFansRequest {
  final int page;
  final String value;

  AgeFansRankRequest(this.page, {this.value = ''}) {
    addParam('page', page);
    addParam('size', 75);
    addParam('value', value);
  }

  @override
  String get path => '/v2/rank';
}

class AgeFansHomeRequest extends AgeFansRequest {
  AgeFansHomeRequest() {
    addParam('update', 12);
    addParam('recommend', 12);
  }

  // /v2/home-list?update=12&recommend=12
  @override
  String get path => '/v2/home-list';
}

class AgeFansSearchRequest extends AgeFansRequest {
  AgeFansSearchRequest(String query, int page) {
    addParam('query', query);
    addParam('page', page);
  }

  // /v2/search?query=1&page=1
  @override
  String get path => '/v2/search';
}

class AgeFansLoginRequest extends AgeFansRequest {
  AgeFansLoginRequest(String username, String password) {
    addParam('username', username);
    addParam('password', password);
    addHeader('content-type', 'application/x-www-form-urlencoded');
  }

  @override
  HttpMethod get httpMethod => HttpMethod.POST;

  // /v2/search?query=1&page=1
  @override
  String get path => '/v2/accounts/login/';
}

class AgeFansRegisterRequest extends AgeFansRequest {
  AgeFansRegisterRequest(String username, String password) {
    addParam('username', username);
    addParam('password1', password);
    addParam('password2', password);
    addHeader('content-type', 'application/x-www-form-urlencoded');
  }

  @override
  HttpMethod get httpMethod => HttpMethod.POST;

  // /v2/search?query=1&page=1
  @override
  String get path => '/v2/accounts/signup/';
}

class AgeFansSlipicRequest extends AgeFansRequest {
  AgeFansSlipicRequest();

  @override
  String get path => '/v2/slipic';
}

class AgeFansCatalogRequest extends AgeFansRequest {
  AgeFansCatalogRequest(
    int page,
    String genre,
    String label,
    String letter,
    String order,
    String region,
    String resource,
    String season,
    String status,
    String year,
  ) {
    addParam('page', page);
    addParam('genre', genre);
    addParam('label', label);
    addParam('letter', letter);
    addParam('order', order);
    addParam('region', region);
    addParam('resource', resource);
    addParam('season', season);
    addParam('status', status);
    addParam('year', year);
    addParam('size', 10);
  }

  @override
  String get path => '/v2/catalog';
}

class AgeFansGetVideoRequest extends AgeFansRequest {
  AgeFansGetVideoRequest();

  @override
  String get path => '/v2/_getplay';
}

// https://play.agefans.vip:8443/_getplay2_m5?playid=&vid=&kt=&kp=
class AgeFansVideoRequest extends AgeFansRequest {
  String host;
  String urlPath;

  @override
  String get authority => host;

  AgeFansVideoRequest(
    this.host,
    this.urlPath,
    String playId,
    String vid,
    int kt,
    String kp,
  ) {
    addParam('playid', playId);
    addParam('vid', vid);
    addParam('kt', kt);
    addParam('kp', kp);
  }

  @override
  String get path => urlPath;
}

class AgeFansCollectionListRequest extends AgeFansRequest {
  AgeFansCollectionListRequest(
    int pageIndex,
    int pageSize,
    String username,
    String signT,
    String signK,
  ) {
    addParam('pageindex', pageIndex);
    addParam('pagesize', pageSize);
    addParam('username', username);
    addParam('sign_t', signT);
    addParam('sign_k', signK);
  }

  @override
  String get path => '/v2/collect_get';
}

class AgeFansAddOrDelCollectionRequest extends AgeFansRequest {
  final bool add;

  AgeFansAddOrDelCollectionRequest(
    this.add,
    String aid,
    String username,
    String signT,
    String signK,
  ) {
    addParam('aid', aid);
    addParam('username', username);
    addParam('sign_t', signT);
    addParam('sign_k', signK);
  }

  @override
  String get path => add ? '/v2/collect_add' : '/v2/collect_del';
}
