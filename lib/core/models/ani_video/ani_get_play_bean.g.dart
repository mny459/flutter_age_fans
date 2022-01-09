// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ani_get_play_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AniGetPlayBean _$AniGetPlayBeanFromJson(Map<String, dynamic> json) =>
    AniGetPlayBean(
      json['ServerTime'] as int,
      json['Location'] as String,
      json['Location_2'] as String,
      json['Host'] as String,
      json['UrlPath'] as String,
    );

Map<String, dynamic> _$AniGetPlayBeanToJson(AniGetPlayBean instance) =>
    <String, dynamic>{
      'ServerTime': instance.serverTime,
      'Location': instance.location,
      'Location_2': instance.location2,
      'Host': instance.host,
      'UrlPath': instance.urlPath,
    };
