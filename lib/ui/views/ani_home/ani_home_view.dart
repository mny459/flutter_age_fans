import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_age_fans/core/constant/ani_color.dart';
import 'package:flutter_age_fans/core/helper/NetworkImageHelper.dart';
import 'package:flutter_age_fans/core/models/ani_home/ani_home_bean.dart';
import 'package:flutter_age_fans/core/services/navigation/navigation_helper.dart';
import 'package:flutter_age_fans/generated/l10n.dart';
import 'package:flutter_age_fans/ui/shared/ui_helper.dart';
import 'package:flutter_age_fans/ui/widgets/stateful/ani_catalog_title/ani_catalog_title.dart';
import 'package:flutter_age_fans/ui/widgets/stateful/ani_weekday_update/ani_rank_pre_tile.dart';
import 'package:flutter_age_fans/ui/widgets/stateful/anime_pre/ani_pre_tile.dart';
import 'package:flutter_age_fans/ui/widgets/stateless/state_view.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:logging/logging.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';

import 'ani_home_view_model.dart';

class AniHomeView extends StatelessWidget {
  const AniHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AniHomeViewModel>.reactive(
      viewModelBuilder: () => AniHomeViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
        body: StateView(
          loadingOrError: model.homeInfo == null,
          hasError: model.hasError,
          child: _HomeInfo(),
          onRetry: () {
            model.refresh();
          },
        ),
      ),
    );
  }
}

class _HomeInfo extends ViewModelWidget<AniHomeViewModel> {
  final _logger = Logger('_HomeInfo');

  @override
  Widget build(BuildContext context, AniHomeViewModel model) {
    return SmartRefresher(
      controller: model.refreshController,
      enablePullDown: true,
      enablePullUp: false,
      onRefresh: () => model.refresh(),
      header: const ClassicHeader(),
      footer: const ClassicFooter(),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _BannerInfo()),
          SliverToBoxAdapter(child: _WeekdayUpdate(model.xinFansInfoMap)),
          SliverToBoxAdapter(child: _DailyRecommend()),
          SliverToBoxAdapter(child: _RecentUpdate()),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }
}

class _BannerInfo extends ViewModelWidget<AniHomeViewModel> {
  final _logger = Logger('_BannerInfo');
  final _swiperController = SwiperController();

  @override
  Widget build(BuildContext context, AniHomeViewModel model) {
    final banners = model.banners;
    _logger.severe('Banner Count ${banners.length}');

    return Container(
      margin: const EdgeInsets.all(8),
      child: PhysicalModel(
        clipBehavior: Clip.antiAlias,
        color: AniColor.surfaceColor,
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        child: SizedBox(
          height: (UIHelper.screenWidth - 2 * 8) / 2 + 14,
          child: Swiper(
            outer: true,
            controller: _swiperController,
            itemCount: banners.length,
            itemBuilder: (_, index) {
              return GestureDetector(
                onTap: () {
                  NavigationHelper.navDetailView(banners[index].aid);
                },
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ExtendedImage.network(
                        banners[index].picUrl,
                        fit: BoxFit.cover,
                        loadStateChanged: (state) {
                          return NetworkImageHelper.handleErrorLoadState(state);
                        },
                      ),
                    ),
                    Positioned(
                      child: Container(
                        child: Text(
                          banners[index].title,
                          style: const TextStyle(
                              fontSize: 16, color: AniColor.textMainColor),
                        ),
                        alignment: Alignment.center,
                        height: 37,
                        color: const Color(0x99404040),
                      ),
                      left: 0,
                      right: 0,
                      bottom: 0,
                    )
                  ],
                ),
              );
            },
            autoplay: true,
            loop: true,
            pagination: const SwiperPagination(
              margin: EdgeInsets.symmetric(vertical: 2),
            ),
          ),
        ),
      ),
    );
  }
}

class _WeekdayUpdate extends StatefulWidget {
  final Map<String, List<XinFansInfoBean>> _weekdayInfo;

  const _WeekdayUpdate(this._weekdayInfo);

  @override
  _WeekdayUpdateState createState() => _WeekdayUpdateState();
}

class _WeekdayUpdateState extends State<_WeekdayUpdate>
    with SingleTickerProviderStateMixin {
  final _logger = Logger('_WeekdayUpdateState');
  TabController? _tabController;
  var _index = 0;

  @override
  void initState() {
    super.initState();
    final tabController = TabController(
        initialIndex: _index, length: widget._weekdayInfo.length, vsync: this);
    tabController.addListener(() {
      setState(() {
        _index = tabController.index;
      });
    });
    _tabController = tabController;
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _tabController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = 45.0 * widget._weekdayInfo.values.elementAt(_index).length;
    // _logger.severe(
    //     '_index = $_index height $height ${widget._weekdayInfo.values.elementAt(_index).length}');
    final locale = S.of(context);
    return Container(
      height: height + 44 + 44 + 8,
      margin: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
          color: AniColor.surfaceColor,
          borderRadius: BorderRadius.all(Radius.circular(6))),
      child: Column(
        children: [
          AniCatalogTitle(
            locale.weeklyUpdate,
            start: const Icon(
              Icons.date_range,
              color: AniColor.textFourthColor,
              size: 18,
            ),
          ),
          TabBar(
            labelStyle: const TextStyle(fontSize: 14),
            controller: _tabController,
            labelPadding: EdgeInsets.zero,
            onTap: (index) {
              // setState(() {
              //   _index = index;
              // });
            },
            tabs: List.generate(
              widget._weekdayInfo.length,
              (index) => Tab(
                iconMargin: EdgeInsets.zero,
                height: 44,
                text: widget._weekdayInfo.keys.toList()[index],
              ),
            ),
          ),
          UIHelper.horizontalDivider(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: List.generate(
                widget._weekdayInfo.length,
                (index) {
                  final list = widget._weekdayInfo.values.toList()[index];
                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 8),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final item = list[index];
                      return AniWeekdayUpdateTile(info: item);
                    },
                    separatorBuilder: (_, index) =>
                        UIHelper.horizontalDivider(indent: 8, endIndent: 8),
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

class _DailyRecommend extends ViewModelWidget<AniHomeViewModel> {
  final _logger = Logger('_DailyRecommend');

  @override
  Widget build(BuildContext context, AniHomeViewModel model) {
    final recommendList = model.homeInfo!.aniPreEvDay;
    final locale = S.of(context);
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
          color: AniColor.surfaceColor,
          borderRadius: BorderRadius.all(Radius.circular(6))),
      child: Column(
        children: [
          AniCatalogTitle(
            locale.dailyRecommend,
            start: const Icon(
              Icons.recommend,
              color: AniColor.textFourthColor,
              size: 18,
            ),
          ),
          UIHelper.horizontalDivider(),
          GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 9 / 16,
            ),
            itemBuilder: (context, index) {
              final data = recommendList[index];
              return AniPreTile(key: Key(data.aid), aniPre: data);
            },
            itemCount: recommendList.length,
          ),
        ],
      ),
    );
  }
}

class _RecentUpdate extends ViewModelWidget<AniHomeViewModel> {
  final _logger = Logger('_Articles');

  @override
  Widget build(BuildContext context, AniHomeViewModel model) {
    final lastUpdateList = model.homeInfo!.aniPreUP;
    final locale = S.of(context);
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
          color: AniColor.surfaceColor,
          borderRadius: BorderRadius.all(Radius.circular(6))),
      child: Column(
        children: [
          AniCatalogTitle(
            locale.recentUpdate,
            start: const Icon(
              Icons.local_fire_department_outlined,
              color: AniColor.textFourthColor,
              size: 18,
            ),
          ),
          UIHelper.horizontalDivider(),
          GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 9 / 16,
            ),
            itemBuilder: (context, index) {
              final data = lastUpdateList[index];
              return AniPreTile(key: Key(data.aid), aniPre: data);
            },
            itemCount: lastUpdateList.length,
          ),
        ],
      ),
    );
  }
}
