// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommend_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendBean _$RecommendBeanFromJson(Map<String, dynamic> json) =>
    RecommendBean(
      (json['AniPre'] as List<dynamic>)
          .map((e) => AniPreBean.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['AllCnt'] as int,
    );

Map<String, dynamic> _$RecommendBeanToJson(RecommendBean instance) =>
    <String, dynamic>{
      'AniPre': instance.aniPre,
      'AllCnt': instance.allCnt,
    };
