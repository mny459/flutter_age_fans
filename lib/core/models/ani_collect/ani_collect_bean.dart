import 'dart:core';

import 'package:flutter_age_fans/core/models/ani_pre/ani_pre_bean.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ani_collect_bean.g.dart';

@JsonSerializable()
class AniCollectionBean {
  @JsonKey(name: "Status")
  int status;
  @JsonKey(name: "Message")
  String message;
  @JsonKey(name: "Data")
  CollectionListBean? data;

  AniCollectionBean(this.status, this.message, this.data);

  factory AniCollectionBean.fromJson(Map<String, dynamic> json) => _$AniCollectionBeanFromJson(json);

  Map<String, dynamic> toJson() => _$AniCollectionBeanToJson(this);
}

@JsonSerializable()
class CollectionListBean {
  @JsonKey(name: "List")
  List<AniPreBean> list;
  @JsonKey(name: "Allsize")
  int allSize;

  CollectionListBean(this.list, this.allSize);

  factory CollectionListBean.fromJson(Map<String, dynamic> json) => _$CollectionListBeanFromJson(json);

  Map<String, dynamic> toJson() => _$CollectionListBeanToJson(this);
}

@JsonSerializable()
class CollectionBean {
  @JsonKey(name: "AID")
  String aid;
  @JsonKey(name: "Time")
  int time;
  @JsonKey(name: "UpTime")
  int upTime;
  @JsonKey(name: "Title")
  String title;
  @JsonKey(name: "NewTitle")
  String newTitle;
  @JsonKey(name: "PicSmall")
  String picSmall;
  @JsonKey(name: "Href")
  String href;

  CollectionBean(this.aid, this.time, this.upTime, this.title, this.newTitle, this.picSmall, this.href);

  factory CollectionBean.fromJson(Map<String, dynamic> json) => _$CollectionBeanFromJson(json);

  Map<String, dynamic> toJson() => _$CollectionBeanToJson(this);
}

