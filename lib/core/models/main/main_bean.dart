import 'package:json_annotation/json_annotation.dart';

part 'main_bean.g.dart';

@JsonSerializable()
class MainBean {
  LaunchBean launch;
  @JsonKey(name: "appversion")
  String appVersion;
  String url;
  String about;
  List<NavBean> nav;

  MainBean(this.launch, this.appVersion, this.url, this.about, this.nav);

  factory MainBean.fromJson(Map<String, dynamic> json) =>
      _$MainBeanFromJson(json);

  Map<String, dynamic> toJson() => _$MainBeanToJson(this);
}

@JsonSerializable()
class NavBean {
  String title;
  String icon;
  String url;

  NavBean(this.title, this.icon, this.url);

  factory NavBean.fromJson(Map<String, dynamic> json) =>
      _$NavBeanFromJson(json);

  Map<String, dynamic> toJson() => _$NavBeanToJson(this);
}

@JsonSerializable()
class LaunchBean {
  List<String> pic;
  String url;

  LaunchBean(this.pic, this.url);

  factory LaunchBean.fromJson(Map<String, dynamic> json) =>
      _$LaunchBeanFromJson(json);

  Map<String, dynamic> toJson() => _$LaunchBeanToJson(this);
}
