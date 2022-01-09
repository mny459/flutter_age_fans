import 'package:flutter_age_fans/core/models/ani_pre/ani_bean.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ani_banner_bean.g.dart';

@JsonSerializable()
class AniBannerBean{
  List<AniBean> banners;

  AniBannerBean(this.banners);

  factory AniBannerBean.fromJson(Map<String, dynamic> json) =>
      _$AniBannerBeanFromJson(json);

  Map<String, dynamic> toJson() => _$AniBannerBeanToJson(this);
}
