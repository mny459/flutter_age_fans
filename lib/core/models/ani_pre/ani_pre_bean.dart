import 'package:json_annotation/json_annotation.dart';

part 'ani_pre_bean.g.dart';

@JsonSerializable()
class AniPreBean {
  @JsonKey(name: "AID")
  String aid;
  @JsonKey(name: "Title")
  String title;
  @JsonKey(name: "NewTitle")
  String newTitle;
  @JsonKey(name: "PicSmall")
  String picSmall;
  @JsonKey(name: "Href")
  String href;

  AniPreBean(this.aid, this.title, this.newTitle, this.picSmall, this.href);

  factory AniPreBean.fromJson(Map<String, dynamic> json) =>
      _$AniPreBeanFromJson(json);

  Map<String, dynamic> toJson() => _$AniPreBeanToJson(this);
}
