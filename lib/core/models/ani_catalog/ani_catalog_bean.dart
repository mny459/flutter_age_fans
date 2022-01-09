import 'package:json_annotation/json_annotation.dart';

part 'ani_catalog_bean.g.dart';

@JsonSerializable()
class AniCatalogBean {
  @JsonKey(name: "Labels_region")
  List<String> labelsRegion;
  @JsonKey(name: "Labels_genre")
  List<String> labelsGenre;
  @JsonKey(name: "Labels_letter")
  List<String> labelsLetter;
  @JsonKey(name: "Labels_year")
  List<String> labelsYear;
  @JsonKey(name: "Labels_season")
  List<String> labelsSeason;
  @JsonKey(name: "Labels_status")
  List<String> labelsStatus;
  @JsonKey(name: "Labels_label")
  List<String> labelsLabel;
  @JsonKey(name: "Labels_resource")
  List<String> labelsResource;
  @JsonKey(name: "Labels_order")
  List<String> labelsOrder;
  @JsonKey(name: "AniPreL")
  List<AniPreLBean> aniPreL;

  // @JsonKey(name: "PageCtrl")
  // dynamic PageCtrl;
  @JsonKey(name: "WebTitle")
  String webTitle;
  @JsonKey(name: "AllCnt")
  int allCnt;

  AniCatalogBean(
    this.labelsRegion,
    this.labelsGenre,
    this.labelsLetter,
    this.labelsYear,
    this.labelsSeason,
    this.labelsStatus,
    this.labelsLabel,
    this.labelsResource,
    this.labelsOrder,
    this.aniPreL,
    this.webTitle,
    this.allCnt,
  );

  factory AniCatalogBean.fromJson(Map<String, dynamic> json) =>
      _$AniCatalogBeanFromJson(json);

  Map<String, dynamic> toJson() => _$AniCatalogBeanToJson(this);
}

@JsonSerializable()
class AniPreLBean {
  @JsonKey(name: "AID")
  String aid;
  @JsonKey(name: "R动画名称")
  String aniName;
  @JsonKey(name: "R动画种类")
  String aniType;
  @JsonKey(name: "R原版名称")
  String originName;
  @JsonKey(
    name: "R其它名称",
    defaultValue: '',
  )
  String otherName;
  @JsonKey(name: "R首播时间")
  String premiereTime;
  @JsonKey(name: "R播放状态")
  String playStatus;
  @JsonKey(name: "R原作")
  String originalWork;
  @JsonKey(name: "R剧情类型")
  List<String> plotType;
  @JsonKey(name: "R制作公司")
  String company;
  @JsonKey(name: "R简介")
  String intro;
  @JsonKey(name: "R封面图小")
  String picSmall;
  @JsonKey(name: "R新番标题")
  String newAnimTitle;

  AniPreLBean(
      this.aid,
      this.aniName,
      this.aniType,
      this.originName,
      this.otherName,
      this.premiereTime,
      this.playStatus,
      this.originalWork,
      this.plotType,
      this.company,
      this.intro,
      this.picSmall,
      this.newAnimTitle);

  factory AniPreLBean.fromJson(Map<String, dynamic> json) =>
      _$AniPreLBeanFromJson(json);

  Map<String, dynamic> toJson() => _$AniPreLBeanToJson(this);

  String plotTypeStr() {
    var result = '';
    for (var value in plotType) {
      result += '$value ';
    }
    return result.trim();
  }
}
