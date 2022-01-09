// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_alert_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmAlertRequest _$ConfirmAlertRequestFromJson(Map<String, dynamic> json) =>
    ConfirmAlertRequest(
      json['title'] as String,
      json['description'] as String,
      json['buttonTitle'] as String,
    );

Map<String, dynamic> _$ConfirmAlertRequestToJson(
        ConfirmAlertRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'buttonTitle': instance.buttonTitle,
    };
