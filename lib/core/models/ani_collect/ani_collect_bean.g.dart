// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ani_collect_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AniCollectionBean _$AniCollectionBeanFromJson(Map<String, dynamic> json) =>
    AniCollectionBean(
      json['Status'] as int,
      json['Message'] as String,
      json['Data'] == null
          ? null
          : CollectionListBean.fromJson(json['Data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AniCollectionBeanToJson(AniCollectionBean instance) =>
    <String, dynamic>{
      'Status': instance.status,
      'Message': instance.message,
      'Data': instance.data,
    };

CollectionListBean _$CollectionListBeanFromJson(Map<String, dynamic> json) =>
    CollectionListBean(
      (json['List'] as List<dynamic>)
          .map((e) => AniPreBean.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['Allsize'] as int,
    );

Map<String, dynamic> _$CollectionListBeanToJson(CollectionListBean instance) =>
    <String, dynamic>{
      'List': instance.list,
      'Allsize': instance.allSize,
    };

CollectionBean _$CollectionBeanFromJson(Map<String, dynamic> json) =>
    CollectionBean(
      json['AID'] as String,
      json['Time'] as int,
      json['UpTime'] as int,
      json['Title'] as String,
      json['NewTitle'] as String,
      json['PicSmall'] as String,
      json['Href'] as String,
    );

Map<String, dynamic> _$CollectionBeanToJson(CollectionBean instance) =>
    <String, dynamic>{
      'AID': instance.aid,
      'Time': instance.time,
      'UpTime': instance.upTime,
      'Title': instance.title,
      'NewTitle': instance.newTitle,
      'PicSmall': instance.picSmall,
      'Href': instance.href,
    };
