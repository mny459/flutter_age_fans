// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ani_search_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AniSearchBean _$AniSearchBeanFromJson(Map<String, dynamic> json) =>
    AniSearchBean(
      (json['AniPreL'] as List<dynamic>)
          .map((e) => AniPreLBean.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['KeyWord'] as String,
      json['SeaCnt'] as int,
    );

Map<String, dynamic> _$AniSearchBeanToJson(AniSearchBean instance) =>
    <String, dynamic>{
      'AniPreL': instance.aniPreL,
      'KeyWord': instance.keyWord,
      'SeaCnt': instance.seaCnt,
    };
