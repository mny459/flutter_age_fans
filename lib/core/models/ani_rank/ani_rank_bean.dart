import 'package:json_annotation/json_annotation.dart';

part 'ani_rank_bean.g.dart';

@JsonSerializable()
class AniRankBean {
  @JsonKey(name: "Year")
  int year;
  @JsonKey(name: "AniRankPre")
  List<AniRankPreBean> aniRankPre;
  // @JsonKey(name: "PageCtrl")
  // dynamic PageCtrl;
  @JsonKey(name: "AllCnt")
  int allCnt;

  AniRankBean(this.year, this.aniRankPre,  this.allCnt);

  factory AniRankBean.fromJson(Map<String, dynamic> json) => _$AniRankBeanFromJson(json);

  Map<String, dynamic> toJson() => _$AniRankBeanToJson(this);
}

@JsonSerializable()
class AniRankPreBean {
  @JsonKey(name: "AID")
  String aid;
  @JsonKey(name: "Href")
  String href;
  @JsonKey(name: "NewTitle")
  String newTitle;
  @JsonKey(name: "PicSmall")
  String picSmall;
  @JsonKey(name: "Title")
  String title;
  @JsonKey(name: "CCnt")
  int cCnt;
  @JsonKey(name: "NO")
  int no;

  AniRankPreBean(this.aid, this.href, this.newTitle, this.picSmall, this.title, this.cCnt, this.no);

  factory AniRankPreBean.fromJson(Map<String, dynamic> json) => _$AniRankPreBeanFromJson(json);

  Map<String, dynamic> toJson() => _$AniRankPreBeanToJson(this);
}

