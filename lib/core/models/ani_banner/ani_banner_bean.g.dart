// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ani_banner_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AniBannerBean _$AniBannerBeanFromJson(Map<String, dynamic> json) =>
    AniBannerBean(
      (json['banners'] as List<dynamic>)
          .map((e) => AniBean.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AniBannerBeanToJson(AniBannerBean instance) =>
    <String, dynamic>{
      'banners': instance.banners,
    };
