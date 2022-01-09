
import 'package:flutter_age_fans/core/models/alert_request/alert_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'confirm_alert_request.g.dart';

@JsonSerializable()
class ConfirmAlertRequest extends AlertRequest {
  String title;

  String description;

  String buttonTitle;

  ConfirmAlertRequest(this.title, this.description, this.buttonTitle);

  factory ConfirmAlertRequest.fromJson(Map<String, dynamic> json) =>
      _$ConfirmAlertRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmAlertRequestToJson(this);
}
