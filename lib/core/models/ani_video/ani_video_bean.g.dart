// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ani_video_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AniVideoBean _$AniVideoBeanFromJson(Map<String, dynamic> json) => AniVideoBean(
      json['purl'] as String,
      json['purlf'] as String,
      json['vurl'] as String,
      json['playid'] as String,
      json['vurl_bak'] as String,
      json['purl_mp4'] as String,
      json['ex'] as String,
    );

Map<String, dynamic> _$AniVideoBeanToJson(AniVideoBean instance) =>
    <String, dynamic>{
      'purl': instance.pUrl,
      'purlf': instance.pUrlF,
      'vurl': instance.vUrl,
      'playid': instance.playId,
      'vurl_bak': instance.vUrlBak,
      'purl_mp4': instance.pUrlMp4,
      'ex': instance.ex,
    };
