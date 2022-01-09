// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ani_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AniBean _$AniBeanFromJson(Map<String, dynamic> json) => AniBean(
      json['AID'] as String,
      json['Title'] as String,
      json['NewTitle'] as String,
      json['PicUrl'] as String,
    );

Map<String, dynamic> _$AniBeanToJson(AniBean instance) => <String, dynamic>{
      'AID': instance.aid,
      'Title': instance.title,
      'NewTitle': instance.newTitle,
      'PicUrl': instance.picUrl,
    };
