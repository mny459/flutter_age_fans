import 'package:json_annotation/json_annotation.dart';

part 'ani_user_bean.g.dart';

@JsonSerializable()
class AniUserBean {
  @JsonKey(name: "Status")
  int status;
  @JsonKey(name: "Message")
  String message;
  @JsonKey(name: "Username")
  String username;
  @JsonKey(name: "Sign_k")
  String signK;
  @JsonKey(name: "Sign_t")
  int signT;

  AniUserBean(this.status, this.message, this.username, this.signK, this.signT);

  factory AniUserBean.fromJson(Map<String, dynamic> json) =>
      _$AniUserBeanFromJson(json);

  Map<String, dynamic> toJson() => _$AniUserBeanToJson(this);
}
