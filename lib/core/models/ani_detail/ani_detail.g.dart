// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ani_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AniDetail _$AniDetailFromJson(Map<String, dynamic> json) => AniDetail(
      AniInfoBean.fromJson(json['AniInfo'] as Map<String, dynamic>),
      (json['AniPreRel'] as List<dynamic>)
          .map((e) => AniPreBean.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['AniPreSim'] as List<dynamic>)
          .map((e) => AniPreBean.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AniDetailToJson(AniDetail instance) => <String, dynamic>{
      'AniInfo': instance.aniInfo,
      'AniPreRel': instance.aniPreRel,
      'AniPreSim': instance.aniPreSim,
    };

AniInfoBean _$AniInfoBeanFromJson(Map<String, dynamic> json) => AniInfoBean(
      json['AID'] as String,
      json['R地区'] as String,
      json['R动画种类'] as String,
      json['R动画名称'] as String,
      json['R原版名称'] as String,
      json['R其它名称'] as String,
      json['R字母索引'] as String,
      json['R原作'] as String,
      json['R制作公司'] as String,
      json['R首播时间'] as String,
      json['R播放状态'] as String,
      json['R剧情类型'] as String,
      json['R在线播放'] as String,
      json['R在线播放2'] as String,
      json['R在线播放3'] as String,
      json['R在线播放4'] as String,
      json['R新番标题'] as String,
      json['R网盘资源'] as String,
      json['R视频尺寸'] as String,
      json['R资源类型'] as String,
      json['R备用'] as String,
      json['R系列'] as String,
      json['R官方网站'] as String,
      json['R标签'] as String,
      json['R更新时间'] as String,
      json['R标题V2'] as String,
      json['R推荐星级'] as int,
      json['R封面图'] as String,
      json['R封面图小'] as String,
      json['R简介'] as String,
      json['DEF_PLAYINDEX'] as String,
      json['R更新时间unix'] as num,
      json['R更新时间str'] as String,
      json['R更新时间str2'] as String,
      json['R简介_br'] as String,
      (json['R标签2'] as List<dynamic>).map((e) => e as String).toList(),
      (json['R剧情类型2'] as List<dynamic>).map((e) => e as String).toList(),
      (json['R在线播放All'] as List<dynamic>)
          .map((e) => (e as List<dynamic>)
              .map((e) => OnlineEpisodeBean.fromJson(e as Map<String, dynamic>))
              .toList())
          .toList(),
      (json['R网盘资源2'] as List<dynamic>)
          .map((e) => ResPanBean.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['R首播年份'] as String,
      json['R首播季度'] as String,
      json['RankCnt'] as num,
      json['CommentCnt'] as num,
      json['CollectCnt'] as num,
      json['ModifiedTime'] as num,
      json['LastModified'] as String,
      json['FilePath'] as String,
    );

Map<String, dynamic> _$AniInfoBeanToJson(AniInfoBean instance) =>
    <String, dynamic>{
      'AID': instance.aid,
      'R地区': instance.area,
      'R动画种类': instance.aniType,
      'R动画名称': instance.aniName,
      'R原版名称': instance.originName,
      'R其它名称': instance.otherName,
      'R字母索引': instance.wordIndex,
      'R原作': instance.originalWork,
      'R制作公司': instance.company,
      'R首播时间': instance.premiereTime,
      'R播放状态': instance.playStatus,
      'R剧情类型': instance.plotType,
      'R在线播放': instance.online,
      'R在线播放2': instance.online2,
      'R在线播放3': instance.online3,
      'R在线播放4': instance.online4,
      'R新番标题': instance.newAnimTitle,
      'R网盘资源': instance.resPan,
      'R视频尺寸': instance.videoSize,
      'R资源类型': instance.resType,
      'R备用': instance.backup,
      'R系列': instance.serial,
      'R官方网站': instance.officialWebsite,
      'R标签': instance.tag,
      'R更新时间': instance.updateTime,
      'R标题V2': instance.titleV2,
      'R推荐星级': instance.recommendStar,
      'R封面图': instance.pic,
      'R封面图小': instance.picSmall,
      'R简介': instance.intro,
      'DEF_PLAYINDEX': instance.defPlayIndex,
      'R更新时间unix': instance.updateTimeUnix,
      'R更新时间str': instance.updateTimeStr,
      'R更新时间str2': instance.updateTimeStr2,
      'R简介_br': instance.introBr,
      'R标签2': instance.tag2,
      'R剧情类型2': instance.plotType2,
      'R在线播放All': instance.onlineEpisode,
      'R网盘资源2': instance.resPan2,
      'R首播年份': instance.premiereYear,
      'R首播季度': instance.premiereQuarter,
      'RankCnt': instance.rankCnt,
      'CommentCnt': instance.commentCnt,
      'CollectCnt': instance.collectCnt,
      'ModifiedTime': instance.modifiedTime,
      'LastModified': instance.lastModified,
      'FilePath': instance.filePath,
    };

ResPanBean _$ResPanBeanFromJson(Map<String, dynamic> json) => ResPanBean(
      json['Title'] as String,
      json['Link'] as String,
      json['ExCode'] as String,
    );

Map<String, dynamic> _$ResPanBeanToJson(ResPanBean instance) =>
    <String, dynamic>{
      'Title': instance.title,
      'Link': instance.link,
      'ExCode': instance.exCode,
    };

OnlineEpisodeBean _$OnlineEpisodeBeanFromJson(Map<String, dynamic> json) =>
    OnlineEpisodeBean(
      json['Title'] as String,
      json['Title_l'] as String,
      json['PlayId'] as String,
      json['PlayVid'] as String,
      json['EpName'] as String,
      json['EpPic'] as String,
      json['Ex'] as String,
    );

Map<String, dynamic> _$OnlineEpisodeBeanToJson(OnlineEpisodeBean instance) =>
    <String, dynamic>{
      'Title': instance.title,
      'Title_l': instance.titleL,
      'PlayId': instance.playId,
      'PlayVid': instance.playVid,
      'EpName': instance.epName,
      'EpPic': instance.epPic,
      'Ex': instance.ex,
    };
