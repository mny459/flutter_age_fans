import 'package:flutter_age_fans/core/models/ani_catalog/ani_catalog_bean.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ani_search_bean.g.dart';

@JsonSerializable()
class AniSearchBean {
  @JsonKey(name: "AniPreL")
  List<AniPreLBean> aniPreL;

  // List<PageCtrlBean> PageCtrl;
  @JsonKey(name: "KeyWord")
  String keyWord;
  @JsonKey(name: "SeaCnt")
  int seaCnt;

  // @JsonKey(name: "Year")
  // String Tip;

  AniSearchBean(this.aniPreL, this.keyWord, this.seaCnt);

  factory AniSearchBean.fromJson(Map<String, dynamic> json) =>
      _$AniSearchBeanFromJson(json);

  Map<String, dynamic> toJson() => _$AniSearchBeanToJson(this);
}
