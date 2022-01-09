// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainBean _$MainBeanFromJson(Map<String, dynamic> json) => MainBean(
      LaunchBean.fromJson(json['launch'] as Map<String, dynamic>),
      json['appversion'] as String,
      json['url'] as String,
      json['about'] as String,
      (json['nav'] as List<dynamic>)
          .map((e) => NavBean.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MainBeanToJson(MainBean instance) => <String, dynamic>{
      'launch': instance.launch,
      'appversion': instance.appVersion,
      'url': instance.url,
      'about': instance.about,
      'nav': instance.nav,
    };

NavBean _$NavBeanFromJson(Map<String, dynamic> json) => NavBean(
      json['title'] as String,
      json['icon'] as String,
      json['url'] as String,
    );

Map<String, dynamic> _$NavBeanToJson(NavBean instance) => <String, dynamic>{
      'title': instance.title,
      'icon': instance.icon,
      'url': instance.url,
    };

LaunchBean _$LaunchBeanFromJson(Map<String, dynamic> json) => LaunchBean(
      (json['pic'] as List<dynamic>).map((e) => e as String).toList(),
      json['url'] as String,
    );

Map<String, dynamic> _$LaunchBeanToJson(LaunchBean instance) =>
    <String, dynamic>{
      'pic': instance.pic,
      'url': instance.url,
    };
