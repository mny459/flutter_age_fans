import 'package:flutter_age_fans/core/models/snack_bar_response/snack_bar_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'confirm_snack_bar_response.g.dart';

@JsonSerializable()
class ConfirmSnackBarResponse extends SnackBarResponse {
  bool confirmed;

  ConfirmSnackBarResponse(this.confirmed);

  factory ConfirmSnackBarResponse.fromJson(Map<String, dynamic> json) =>
      _$ConfirmSnackBarResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmSnackBarResponseToJson(this);
}
