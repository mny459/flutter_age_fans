import 'package:flutter_age_fans/core/models/ani_pre/ani_pre_bean.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recommend_bean.g.dart';

@JsonSerializable()
class RecommendBean {
  @JsonKey(name: "AniPre")
  List<AniPreBean> aniPre;

  // dynamic PageCtrl;
  @JsonKey(name: "AllCnt")
  int allCnt;

  // String tip;

  RecommendBean(this.aniPre, this.allCnt);

  factory RecommendBean.fromJson(Map<String, dynamic> json) =>
      _$RecommendBeanFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendBeanToJson(this);
}
