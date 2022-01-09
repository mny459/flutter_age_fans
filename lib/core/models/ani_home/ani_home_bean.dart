import 'package:flutter_age_fans/core/models/ani_pre/ani_pre_bean.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ani_home_bean.g.dart';

@JsonSerializable()
class AniHomeBean {
  @JsonKey(name: "AniPreUP")
  List<AniPreBean> aniPreUP;
  @JsonKey(name: "AniPreEvDay")
  List<AniPreBean> aniPreEvDay;
  @JsonKey(name: "XinfansInfo")
  List<XinFansInfoBean> xinfansInfo;
  // String Tip;

  AniHomeBean(this.aniPreUP, this.aniPreEvDay, this.xinfansInfo);

  factory AniHomeBean.fromJson(Map<String, dynamic> json) => _$AniHomeBeanFromJson(json);

  Map<String, dynamic> toJson() => _$AniHomeBeanToJson(this);
}

@JsonSerializable()
class XinFansInfoBean {
  @JsonKey(name: "isnew")
  bool isNew;
  @JsonKey(name: "id")
  String id;
  @JsonKey(name: "wd")
  int wd;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "mtime")
  String mTime;
  @JsonKey(name: "namefornew")
  String nameForNew;

  XinFansInfoBean(this.isNew, this.id, this.wd, this.name, this.mTime, this.nameForNew);

  factory XinFansInfoBean.fromJson(Map<String, dynamic> json) => _$XinFansInfoBeanFromJson(json);

  Map<String, dynamic> toJson() => _$XinFansInfoBeanToJson(this);
}

