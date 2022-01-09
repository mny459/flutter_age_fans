// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ani_pre_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AniPreBean _$AniPreBeanFromJson(Map<String, dynamic> json) => AniPreBean(
      json['AID'] as String,
      json['Title'] as String,
      json['NewTitle'] as String,
      json['PicSmall'] as String,
      json['Href'] as String,
    );

Map<String, dynamic> _$AniPreBeanToJson(AniPreBean instance) =>
    <String, dynamic>{
      'AID': instance.aid,
      'Title': instance.title,
      'NewTitle': instance.newTitle,
      'PicSmall': instance.picSmall,
      'Href': instance.href,
    };
