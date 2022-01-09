import 'package:flutter_age_fans/core/models/ani_pre/ani_bean.dart';
import 'package:json_annotation/json_annotation.dart';
import 'ani_home_bean.dart';

part 'ani_home_all_info_bean.g.dart';

@JsonSerializable()
class AniHomeAllInfoBean{

  AniHomeBean homeBean;
  List<AniBean> banners;

  AniHomeAllInfoBean(this.homeBean, this.banners);

  factory AniHomeAllInfoBean.fromJson(Map<String, dynamic> json) =>
      _$AniHomeAllInfoBeanFromJson(json);

  Map<String, dynamic> toJson() => _$AniHomeAllInfoBeanToJson(this);
}
