import 'package:json_annotation/json_annotation.dart';

part 'ani_get_play_bean.g.dart';

@JsonSerializable()
class AniGetPlayBean {
  @JsonKey(name: "ServerTime")
  int serverTime;
  @JsonKey(name: "Location")
  String location;
  @JsonKey(name: "Location_2")
  String location2;
  @JsonKey(name: "Host")
  String host;
  @JsonKey(name: "UrlPath")
  String urlPath;

  AniGetPlayBean(this.serverTime, this.location, this.location2, this.host, this.urlPath);

  factory AniGetPlayBean.fromJson(Map<String, dynamic> json) => _$AniGetPlayBeanFromJson(json);

  Map<String, dynamic> toJson() => _$AniGetPlayBeanToJson(this);
}

