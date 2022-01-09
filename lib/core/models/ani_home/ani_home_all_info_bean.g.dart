// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ani_home_all_info_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AniHomeAllInfoBean _$AniHomeAllInfoBeanFromJson(Map<String, dynamic> json) =>
    AniHomeAllInfoBean(
      AniHomeBean.fromJson(json['homeBean'] as Map<String, dynamic>),
      (json['banners'] as List<dynamic>)
          .map((e) => AniBean.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AniHomeAllInfoBeanToJson(AniHomeAllInfoBean instance) =>
    <String, dynamic>{
      'homeBean': instance.homeBean,
      'banners': instance.banners,
    };
