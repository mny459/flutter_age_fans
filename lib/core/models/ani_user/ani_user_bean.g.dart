// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ani_user_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AniUserBean _$AniUserBeanFromJson(Map<String, dynamic> json) => AniUserBean(
      json['Status'] as int,
      json['Message'] as String,
      json['Username'] as String,
      json['Sign_k'] as String,
      json['Sign_t'] as int,
    );

Map<String, dynamic> _$AniUserBeanToJson(AniUserBean instance) =>
    <String, dynamic>{
      'Status': instance.status,
      'Message': instance.message,
      'Username': instance.username,
      'Sign_k': instance.signK,
      'Sign_t': instance.signT,
    };
