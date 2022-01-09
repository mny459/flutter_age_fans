import 'package:json_annotation/json_annotation.dart';

part 'ani_video_bean.g.dart';

@JsonSerializable()
class AniVideoBean {
  @JsonKey(name: "purl")
  String pUrl;
  @JsonKey(name: "purlf")
  String pUrlF;
  @JsonKey(name: "vurl")
  String vUrl;
  @JsonKey(name: "playid")
  String playId;
  @JsonKey(name: "vurl_bak")
  String vUrlBak;
  @JsonKey(name: "purl_mp4")
  String pUrlMp4;
  @JsonKey(name: "ex")
  String ex;

  AniVideoBean(this.pUrl, this.pUrlF, this.vUrl, this.playId, this.vUrlBak, this.pUrlMp4, this.ex);

  factory AniVideoBean.fromJson(Map<String, dynamic> json) => _$AniVideoBeanFromJson(json);

  Map<String, dynamic> toJson() => _$AniVideoBeanToJson(this);
}

