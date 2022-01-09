// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ani_catalog_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AniCatalogBean _$AniCatalogBeanFromJson(Map<String, dynamic> json) =>
    AniCatalogBean(
      (json['Labels_region'] as List<dynamic>).map((e) => e as String).toList(),
      (json['Labels_genre'] as List<dynamic>).map((e) => e as String).toList(),
      (json['Labels_letter'] as List<dynamic>).map((e) => e as String).toList(),
      (json['Labels_year'] as List<dynamic>).map((e) => e as String).toList(),
      (json['Labels_season'] as List<dynamic>).map((e) => e as String).toList(),
      (json['Labels_status'] as List<dynamic>).map((e) => e as String).toList(),
      (json['Labels_label'] as List<dynamic>).map((e) => e as String).toList(),
      (json['Labels_resource'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      (json['Labels_order'] as List<dynamic>).map((e) => e as String).toList(),
      (json['AniPreL'] as List<dynamic>)
          .map((e) => AniPreLBean.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['WebTitle'] as String,
      json['AllCnt'] as int,
    );

Map<String, dynamic> _$AniCatalogBeanToJson(AniCatalogBean instance) =>
    <String, dynamic>{
      'Labels_region': instance.labelsRegion,
      'Labels_genre': instance.labelsGenre,
      'Labels_letter': instance.labelsLetter,
      'Labels_year': instance.labelsYear,
      'Labels_season': instance.labelsSeason,
      'Labels_status': instance.labelsStatus,
      'Labels_label': instance.labelsLabel,
      'Labels_resource': instance.labelsResource,
      'Labels_order': instance.labelsOrder,
      'AniPreL': instance.aniPreL,
      'WebTitle': instance.webTitle,
      'AllCnt': instance.allCnt,
    };

AniPreLBean _$AniPreLBeanFromJson(Map<String, dynamic> json) => AniPreLBean(
      json['AID'] as String,
      json['R动画名称'] as String,
      json['R动画种类'] as String,
      json['R原版名称'] as String,
      json['R其它名称'] as String? ?? '',
      json['R首播时间'] as String,
      json['R播放状态'] as String,
      json['R原作'] as String,
      (json['R剧情类型'] as List<dynamic>).map((e) => e as String).toList(),
      json['R制作公司'] as String,
      json['R简介'] as String,
      json['R封面图小'] as String,
      json['R新番标题'] as String,
    );

Map<String, dynamic> _$AniPreLBeanToJson(AniPreLBean instance) =>
    <String, dynamic>{
      'AID': instance.aid,
      'R动画名称': instance.aniName,
      'R动画种类': instance.aniType,
      'R原版名称': instance.originName,
      'R其它名称': instance.otherName,
      'R首播时间': instance.premiereTime,
      'R播放状态': instance.playStatus,
      'R原作': instance.originalWork,
      'R剧情类型': instance.plotType,
      'R制作公司': instance.company,
      'R简介': instance.intro,
      'R封面图小': instance.picSmall,
      'R新番标题': instance.newAnimTitle,
    };
