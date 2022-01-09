// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ani_rank_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AniRankBean _$AniRankBeanFromJson(Map<String, dynamic> json) => AniRankBean(
      json['Year'] as int,
      (json['AniRankPre'] as List<dynamic>)
          .map((e) => AniRankPreBean.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['AllCnt'] as int,
    );

Map<String, dynamic> _$AniRankBeanToJson(AniRankBean instance) =>
    <String, dynamic>{
      'Year': instance.year,
      'AniRankPre': instance.aniRankPre,
      'AllCnt': instance.allCnt,
    };

AniRankPreBean _$AniRankPreBeanFromJson(Map<String, dynamic> json) =>
    AniRankPreBean(
      json['AID'] as String,
      json['Href'] as String,
      json['NewTitle'] as String,
      json['PicSmall'] as String,
      json['Title'] as String,
      json['CCnt'] as int,
      json['NO'] as int,
    );

Map<String, dynamic> _$AniRankPreBeanToJson(AniRankPreBean instance) =>
    <String, dynamic>{
      'AID': instance.aid,
      'Href': instance.href,
      'NewTitle': instance.newTitle,
      'PicSmall': instance.picSmall,
      'Title': instance.title,
      'CCnt': instance.cCnt,
      'NO': instance.no,
    };
