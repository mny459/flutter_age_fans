import 'dart:ui';

import 'package:clipboard/clipboard.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:extended_image/extended_image.dart';
import 'package:extended_text/extended_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_age_fans/core/constant/ani_color.dart';
import 'package:flutter_age_fans/core/helper/NetworkImageHelper.dart';
import 'package:flutter_age_fans/core/models/ani_detail/ani_detail.dart';
import 'package:flutter_age_fans/core/services/navigation/navigation_helper.dart';
import 'package:flutter_age_fans/generated/l10n.dart';
import 'package:flutter_age_fans/ui/shared/ui_helper.dart';
import 'package:flutter_age_fans/ui/widgets/stateful/ani_catalog_title/ani_catalog_title.dart';
import 'package:flutter_age_fans/ui/widgets/stateful/anime_pre/ani_pre_tile.dart';
import 'package:flutter_age_fans/ui/widgets/stateless/state_view.dart';
import 'package:logging/logging.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'ani_detail_view_model.dart';

class AniDetailView extends StatelessWidget {
  final String cid;

  const AniDetailView(this.cid, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
    return ViewModelBuilder<AniDetailViewModel>.reactive(
      viewModelBuilder: () => AniDetailViewModel(),
      onModelReady: (model) => model.init(cid),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(title: Text(local.detail)),
        body: StateView(
          loadingOrError: model.aniDetail == null,
          hasError: model.hasError,
          child: _AniDetail(),
          onRetry: () {
            model.loadAniInfo();
          },
        ),
      ),
    );
  }
}

class _AniDetail extends ViewModelWidget<AniDetailViewModel> {
  final _logger = Logger('_AniDetail');

  @override
  Widget build(BuildContext context, AniDetailViewModel model) {
    var onlineEpisode = model.aniDetail!.aniInfo.onlineEpisode;
    // _logger.severe('_AniDetail ${onlineEpisode.length}');
    onlineEpisode.removeWhere((element) {
      // _logger.severe('_AniDetail ${element.length} ${element.toString()}');
      return element.isEmpty;
    });
    // _logger.severe('_AniDetail ${onlineEpisode.length}');
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: _BasicInfo(),
        ),
        SliverToBoxAdapter(
          child: _OnlineRes(
              onlineEpisode, int.parse(model.aniDetail!.aniInfo.defPlayIndex)),
        ),
        SliverToBoxAdapter(
          child: _PanRes(),
        ),
        SliverToBoxAdapter(
          child: _RelativeAni(),
        ),
        SliverToBoxAdapter(
          child: _RecommendAni(),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: 20),
        ),
      ],
    );
  }
}

class _BasicInfo extends ViewModelWidget<AniDetailViewModel> {
  final _logger = Logger('_BasicInfo');

  @override
  Widget build(BuildContext context, AniDetailViewModel model) {
    final locale = S.of(context);
    final data = model.aniDetail!.aniInfo;
    var picSmall = data.picSmall;
    if (!picSmall.startsWith('http')) {
      picSmall = 'https:$picSmall';
    }
    return Container(
      margin: const EdgeInsets.all(10),
      child: PhysicalModel(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: AniColor.surfaceColor,
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        child: Column(
          children: [
            // 头部信息
            SizedBox(
              height: 190,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ExtendedImage.network(
                      picSmall,
                      cache: true,
                      fit: BoxFit.cover,
                      loadStateChanged: (state) {
                        return NetworkImageHelper.handleEmptyLoadState(state);
                      },
                    ),
                  ),
                  ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 9, sigmaY: 9),
                      child: Container(
                        height: 200,
                        color: Colors.white.withAlpha(0),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      AspectRatio(
                        aspectRatio: 3 / 4,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: ExtendedImage.network(
                                picSmall,
                                cache: true,
                                fit: BoxFit.cover,
                                loadStateChanged: (state) {
                                  return NetworkImageHelper
                                      .handleErrorLoadState(state);
                                },
                              ),
                            ),
                            Positioned(
                              right: 4,
                              bottom: 8,
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 6.0),
                                  decoration: const BoxDecoration(
                                      color: AniColor.colorA6000000,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(14))),
                                  child: Text(
                                    data.newAnimTitle,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      height: 1,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.aniName.joinChar(),
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: AniColor.textFourthColor),
                              ),
                              UIHelper.verticalSpace(8),
                              Text(
                                "${data.area} · ${data.aniType} · ${data.originalWork}"
                                    .joinChar(),
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: AniColor.textMainColor),
                              ),
                              UIHelper.verticalSpace(6),
                              Text(
                                "${locale.originName}：${data.originName}"
                                    .joinChar(),
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: AniColor.textMainColor),
                              ),
                              UIHelper.verticalSpace(6),
                              Text(
                                "${locale.premiereTime}：${data.premiereTime}"
                                    .joinChar(),
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: AniColor.textMainColor),
                              ),
                              UIHelper.verticalSpace(6),
                              Text(
                                "${locale.plotType}：${data.plotType}"
                                    .joinChar(),
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: AniColor.textMainColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // 评论、收藏
            SizedBox(
              height: 42,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.local_fire_department_outlined,
                          size: 14,
                          color: AniColor.textFourthColor,
                        ),
                        UIHelper.horizontalSpace(2),
                        Text(
                          '${data.rankCnt}',
                          style: const TextStyle(
                              fontSize: 14,
                              color: AniColor.textFourthColor,
                              height: 1),
                        ),
                      ],
                    ),
                  ),
                  UIHelper.verticalDivider(),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.comment,
                          size: 14,
                          color: AniColor.textFourthColor,
                        ),
                        UIHelper.horizontalSpace(2),
                        Text(
                          '${data.commentCnt}',
                          style: const TextStyle(
                              fontSize: 14,
                              color: AniColor.textFourthColor,
                              height: 1),
                        ),
                      ],
                    ),
                  ),
                  UIHelper.verticalDivider(),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        model.collect();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.star_border_outlined,
                            size: 14,
                            color: AniColor.textFourthColor,
                          ),
                          UIHelper.horizontalSpace(2),
                          Text(
                            '${data.collectCnt}',
                            style: const TextStyle(
                                fontSize: 14,
                                color: AniColor.textFourthColor,
                                height: 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            UIHelper.horizontalDivider(),
            Container(
              padding: const EdgeInsets.all(10),
              child: ExpandableText(
                data.intro,
                prefixText: "${locale.intro}: ",
                expandText: '展开',
                collapseText: '收起',
                maxLines: 4,
                prefixStyle: const TextStyle(
                    color: AniColor.textMainColor, fontSize: 14),
                style: const TextStyle(color: AniColor.colorB1B1B1),
                linkStyle: const TextStyle(
                  fontSize: 14,
                  color: AniColor.colorFF5F00,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _OnlineRes extends StatefulWidget {
  final List<List<OnlineEpisodeBean>> _onLineList;
  final int defPlayIndex;

  const _OnlineRes(this._onLineList, this.defPlayIndex);

  @override
  _OnlineResState createState() => _OnlineResState();
}

class _OnlineResState extends State<_OnlineRes>
    with SingleTickerProviderStateMixin {
  final _logger = Logger('_OnlineResState');
  TabController? _tabController;
  var _index = 0;

  @override
  void initState() {
    super.initState();
    // _index = widget.defPlayIndex;
    _logger.severe('${widget.defPlayIndex}');
    _tabController = TabController(
        initialIndex: _index, length: widget._onLineList.length, vsync: this)
      ..addListener(() {
        setState(() {
          _index = _tabController?.index ?? 0;
        });
      });
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _tabController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = S.of(context);
    var height = 0.0;
    height = (widget._onLineList[_index].length / 3).ceil() * 44 + 20 + 44;
    // _logger.severe(
    //     '${widget._onLineList[_index].length} ---- ${(widget._onLineList[_index].length / 3).ceil()}');
    return Container(
      height: height,
      margin: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
          color: AniColor.surfaceColor,
          borderRadius: BorderRadius.all(Radius.circular(6))),
      child: Column(
        children: [
          TabBar(
            isScrollable: widget._onLineList.length > 3,
            controller: _tabController,
            tabs: List.generate(
              widget._onLineList.length,
              (index) {
                return SizedBox(
                  height: 44,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.play_circle_outline, size: 14),
                      UIHelper.horizontalSpace(2),
                      Text('${locale.playList}${index + 1}')
                    ],
                  ),
                );
              },
            ),
            labelStyle: const TextStyle(
              fontSize: 14,
              color: AniColor.textMainColor,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: List.generate(
                widget._onLineList.length,
                (index) {
                  final list = widget._onLineList[index];
                  return GridView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisExtent: 34,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                    itemBuilder: (context, index) {
                      var bean = list[index];
                      return GestureDetector(
                        onTap: () {
                          context
                              .read<AniDetailViewModel>()
                              .play(bean.playId, bean.playVid);
                        },
                        child: Container(
                          height: 26,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(color: AniColor.textMainColor),
                              color: AniColor.surfaceColor,
                              borderRadius: BorderRadius.zero),
                          child: Text(
                            bean.title.joinChar(),
                            style: const TextStyle(
                                color: AniColor.textMainColor, fontSize: 12),
                          ),
                        ),
                      );
                    },
                    itemCount: list.length,
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _PanRes extends ViewModelWidget<AniDetailViewModel> {
  final _logger = Logger('_PanRes');

  @override
  Widget build(BuildContext context, AniDetailViewModel model) {
    // [TV 01-10+OVA 720P]\\n 链接：https://pan.baidu.com/s/1CagWjuZ4Rd3HBoHW2WKWzA 密码：0913
    final data = model.aniDetail!.aniInfo.resPan2;
    _logger.severe(data);
    Widget resWidget;
    if (data.isNotEmpty) {
      resWidget = Column(
        children: List.generate(data.length, (index) {
          final item = data[index];
          return InkWell(
            onTap: () async {
              FlutterClipboard.controlC(item.exCode).then((value) async {
                const delay = Duration(milliseconds: 1500);
                showToast(S.of(context).hintCopyPanCode, duration: delay);
                await Future.delayed(delay);
                NavigationHelper.navSystemBrowser(item.link);
              });
            },
            child: Container(
                height: 48,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AniColor.textFourthColor,
                      ),
                    ),
                    Text(
                      S.of(context).panCode(item.exCode),
                      style: const TextStyle(
                        fontSize: 14,
                        color: AniColor.textSecondColor,
                      ),
                    ),
                  ],
                )),
          );
        }),
      );
    } else {
      resWidget = Container(
        height: 48,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              model.aniDetail!.aniInfo.resPan,
              style: const TextStyle(
                fontSize: 14,
                color: AniColor.textFourthColor,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
          color: AniColor.surfaceColor,
          borderRadius: BorderRadius.all(Radius.circular(6))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AniCatalogTitle(
            S.of(context).panRes,
            start: const Icon(
              Icons.computer,
              color: AniColor.textFourthColor,
              size: 18,
            ),
          ),
          UIHelper.horizontalDivider(),
          resWidget
        ],
      ),
    );
  }
}

class _RelativeAni extends ViewModelWidget<AniDetailViewModel> {
  final _logger = Logger('_RelativeAni');

  @override
  Widget build(BuildContext context, AniDetailViewModel model) {
    final data = model.aniDetail!.aniPreRel;
    if (data.isEmpty) {
      return UIHelper.verticalSpace(0);
    }
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: AniColor.surfaceColor,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Column(
        children: [
          AniCatalogTitle(
            S.of(context).relativeAni,
            start: const Icon(
              Icons.list_alt_outlined,
              color: AniColor.textFourthColor,
              size: 18,
            ),
          ),
          UIHelper.horizontalDivider(),
          Column(
            children: List.generate(
              data.length,
              (index) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        NavigationHelper.navDetailView(data[index].aid);
                      },
                      child: Container(
                        height: 44,
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                data[index].title,
                                style: const TextStyle(
                                  color: AniColor.textSecondColor,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const Icon(
                              CupertinoIcons.right_chevron,
                              color: AniColor.textFourthColor,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                    index != data.length - 1
                        ? UIHelper.horizontalDivider()
                        : UIHelper.verticalSpace(0)
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _RecommendAni extends ViewModelWidget<AniDetailViewModel> {
  final _logger = Logger('_RecommendAni');

  @override
  Widget build(BuildContext context, AniDetailViewModel model) {
    final data = model.aniDetail!.aniPreSim;
    _logger.severe('${data.length}');
    if (data.isEmpty) {
      return UIHelper.verticalSpace(0);
    }
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: AniColor.surfaceColor,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Column(
        children: [
          AniCatalogTitle(
            S.of(context).guessYouLike,
            start: const Icon(
              Icons.favorite_border,
              color: AniColor.textFourthColor,
              size: 18,
            ),
          ),
          UIHelper.horizontalDivider(),
          GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 9 / 16,
            ),
            itemBuilder: (context, index) {
              return AniPreTile(key: Key(data[index].aid), aniPre: data[index]);
            },
            itemCount: data.length,
          ),
        ],
      ),
    );
  }
}
