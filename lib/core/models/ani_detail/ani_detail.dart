import 'package:flutter_age_fans/core/models/ani_pre/ani_pre_bean.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ani_detail.g.dart';

@JsonSerializable()
class AniDetail {
  @JsonKey(name: "AniInfo")
  AniInfoBean aniInfo;
  @JsonKey(name: "AniPreRel")
  List<AniPreBean> aniPreRel;
  @JsonKey(name: "AniPreSim")
  List<AniPreBean> aniPreSim;

  // String Tip;

  AniDetail(this.aniInfo, this.aniPreRel, this.aniPreSim);

  factory AniDetail.fromJson(Map<String, dynamic> json) =>
      _$AniDetailFromJson(json);

  Map<String, dynamic> toJson() => _$AniDetailToJson(this);
}

@JsonSerializable()
class AniInfoBean {
  @JsonKey(name: "AID")
  String aid;
  @JsonKey(name: "R地区")
  String area;
  @JsonKey(name: "R动画种类")
  String aniType;
  @JsonKey(name: "R动画名称")
  String aniName;
  @JsonKey(name: "R原版名称")
  String originName;
  @JsonKey(name: "R其它名称")
  String otherName;
  @JsonKey(name: "R字母索引")
  String wordIndex;
  @JsonKey(name: "R原作")
  String originalWork;
  @JsonKey(name: "R制作公司")
  String company;
  @JsonKey(name: "R首播时间")
  String premiereTime;
  @JsonKey(name: "R播放状态")
  String playStatus;
  @JsonKey(name: "R剧情类型")
  String plotType;
  @JsonKey(name: "R在线播放")
  String online;
  @JsonKey(name: "R在线播放2")
  String online2;
  @JsonKey(name: "R在线播放3")
  String online3;
  @JsonKey(name: "R在线播放4")
  String online4;
  @JsonKey(name: "R新番标题")
  String newAnimTitle;
  @JsonKey(name: "R网盘资源")
  String resPan;
  @JsonKey(name: "R视频尺寸")
  String videoSize;
  @JsonKey(name: "R资源类型")
  String resType;
  @JsonKey(name: "R备用")
  String backup;
  @JsonKey(name: "R系列")
  String serial;
  @JsonKey(name: "R官方网站")
  String officialWebsite;
  @JsonKey(name: "R标签")
  String tag;
  @JsonKey(name: "R更新时间")
  String updateTime;
  @JsonKey(name: "R标题V2")
  String titleV2;
  @JsonKey(name: "R推荐星级")
  int recommendStar;
  @JsonKey(name: "R封面图")
  String pic;
  @JsonKey(name: "R封面图小")
  String picSmall;
  @JsonKey(name: "R简介")
  String intro;
  @JsonKey(name: "DEF_PLAYINDEX")
  String defPlayIndex;
  @JsonKey(name: "R更新时间unix")
  num updateTimeUnix;
  @JsonKey(name: "R更新时间str")
  String updateTimeStr;
  @JsonKey(name: "R更新时间str2")
  String updateTimeStr2;
  @JsonKey(name: "R简介_br")
  String introBr;
  @JsonKey(name: "R标签2")
  List<String> tag2;
  @JsonKey(name: "R剧情类型2")
  List<String> plotType2;
  @JsonKey(name: "R在线播放All")
  List<List<OnlineEpisodeBean>> onlineEpisode;
  @JsonKey(name: "R网盘资源2")
  List<ResPanBean> resPan2;
  @JsonKey(name: "R首播年份")
  String premiereYear;
  @JsonKey(name: "R首播季度")
  String premiereQuarter;
  @JsonKey(name: "RankCnt")
  num rankCnt;
  @JsonKey(name: "CommentCnt")
  num commentCnt;
  @JsonKey(name: "CollectCnt")
  num collectCnt;
  @JsonKey(name: "ModifiedTime")
  num modifiedTime;
  @JsonKey(name: "LastModified")
  String lastModified;
  @JsonKey(name: "FilePath")
  String filePath;

  AniInfoBean(
      this.aid,
      this.area,
      this.aniType,
      this.aniName,
      this.originName,
      this.otherName,
      this.wordIndex,
      this.originalWork,
      this.company,
      this.premiereTime,
      this.playStatus,
      this.plotType,
      this.online,
      this.online2,
      this.online3,
      this.online4,
      this.newAnimTitle,
      this.resPan,
      this.videoSize,
      this.resType,
      this.backup,
      this.serial,
      this.officialWebsite,
      this.tag,
      this.updateTime,
      this.titleV2,
      this.recommendStar,
      this.pic,
      this.picSmall,
      this.intro,
      this.defPlayIndex,
      this.updateTimeUnix,
      this.updateTimeStr,
      this.updateTimeStr2,
      this.introBr,
      this.tag2,
      this.plotType2,
      this.onlineEpisode,
      this.resPan2,
      this.premiereYear,
      this.premiereQuarter,
      this.rankCnt,
      this.commentCnt,
      this.collectCnt,
      this.modifiedTime,
      this.lastModified,
      this.filePath);

  factory AniInfoBean.fromJson(Map<String, dynamic> json) =>
      _$AniInfoBeanFromJson(json);

  Map<String, dynamic> toJson() => _$AniInfoBeanToJson(this);
}

@JsonSerializable()
class ResPanBean {
  @JsonKey(name: "Title")
  String title;
  @JsonKey(name: "Link")
  String link;
  @JsonKey(name: "ExCode")
  String exCode;

  ResPanBean(this.title, this.link, this.exCode);

  factory ResPanBean.fromJson(Map<String, dynamic> json) =>
      _$ResPanBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ResPanBeanToJson(this);
}

@JsonSerializable()
class OnlineEpisodeBean {
  @JsonKey(name: "Title")
  String title;
  @JsonKey(name: "Title_l")
  String titleL;
  @JsonKey(name: "PlayId")
  String playId;
  @JsonKey(name: "PlayVid")
  String playVid;
  @JsonKey(name: "EpName")
  String epName;
  @JsonKey(name: "EpPic")
  String epPic;
  @JsonKey(name: "Ex")
  String ex;

  OnlineEpisodeBean(this.title, this.titleL, this.playId, this.playVid,
      this.epName, this.epPic, this.ex);

  factory OnlineEpisodeBean.fromJson(Map<String, dynamic> json) =>
      _$OnlineEpisodeBeanFromJson(json);

  Map<String, dynamic> toJson() => _$OnlineEpisodeBeanToJson(this);
}
