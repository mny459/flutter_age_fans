// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_snack_bar_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmSnackBarRequest _$ConfirmSnackBarRequestFromJson(
        Map<String, dynamic> json) =>
    ConfirmSnackBarRequest(
      json['message'] as String,
      json['buttonText'] as String,
    );

Map<String, dynamic> _$ConfirmSnackBarRequestToJson(
        ConfirmSnackBarRequest instance) =>
    <String, dynamic>{
      'message': instance.message,
      'buttonText': instance.buttonText,
    };
