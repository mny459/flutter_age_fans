
import 'package:flutter_age_fans/core/models/alert_response/alert_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'confirm_alert_response.g.dart';

@JsonSerializable()
class ConfirmAlertResponse extends AlertResponse {
  bool confirmed;

  ConfirmAlertResponse(this.confirmed);

  factory ConfirmAlertResponse.fromJson(Map<String, dynamic> json) =>
      _$ConfirmAlertResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmAlertResponseToJson(this);
}
