import 'package:json_annotation/json_annotation.dart';

part 'ani_bean.g.dart';

@JsonSerializable()
class AniBean {
  @JsonKey(name: "AID")
  String aid;
  @JsonKey(name: "Title")
  String title;
  @JsonKey(name: "NewTitle")
  String newTitle;
  @JsonKey(name: "PicUrl")
  String picUrl;

  AniBean(this.aid, this.title, this.newTitle, this.picUrl);

  factory AniBean.fromJson(Map<String, dynamic> json) =>
      _$AniBeanFromJson(json);

  Map<String, dynamic> toJson() => _$AniBeanToJson(this);
}
