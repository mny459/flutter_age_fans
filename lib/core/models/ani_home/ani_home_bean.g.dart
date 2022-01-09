// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ani_home_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AniHomeBean _$AniHomeBeanFromJson(Map<String, dynamic> json) => AniHomeBean(
      (json['AniPreUP'] as List<dynamic>)
          .map((e) => AniPreBean.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['AniPreEvDay'] as List<dynamic>)
          .map((e) => AniPreBean.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['XinfansInfo'] as List<dynamic>)
          .map((e) => XinFansInfoBean.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AniHomeBeanToJson(AniHomeBean instance) =>
    <String, dynamic>{
      'AniPreUP': instance.aniPreUP,
      'AniPreEvDay': instance.aniPreEvDay,
      'XinfansInfo': instance.xinfansInfo,
    };

XinFansInfoBean _$XinFansInfoBeanFromJson(Map<String, dynamic> json) =>
    XinFansInfoBean(
      json['isnew'] as bool,
      json['id'] as String,
      json['wd'] as int,
      json['name'] as String,
      json['mtime'] as String,
      json['namefornew'] as String,
    );

Map<String, dynamic> _$XinFansInfoBeanToJson(XinFansInfoBean instance) =>
    <String, dynamic>{
      'isnew': instance.isNew,
      'id': instance.id,
      'wd': instance.wd,
      'name': instance.name,
      'mtime': instance.mTime,
      'namefornew': instance.nameForNew,
    };
