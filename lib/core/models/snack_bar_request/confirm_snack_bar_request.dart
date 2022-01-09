import 'package:json_annotation/json_annotation.dart';

import 'snack_bar_request.dart';

part 'confirm_snack_bar_request.g.dart';

@JsonSerializable()
class ConfirmSnackBarRequest extends SnackBarRequest{
  String message;

  String buttonText;

  // void Function() onPressed;

  ConfirmSnackBarRequest(this.message, this.buttonText);

  factory ConfirmSnackBarRequest.fromJson(Map<String, dynamic> json) =>
      _$ConfirmSnackBarRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmSnackBarRequestToJson(this);
}
