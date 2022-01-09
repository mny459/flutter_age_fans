import 'package:flutter/material.dart';
import 'package:flutter_age_fans/core/constant/ani_color.dart';
import 'package:flutter_age_fans/generated/l10n.dart';
import 'package:flutter_age_fans/ui/shared/ui_helper.dart';
import 'package:flutter_age_fans/ui/widgets/stateful/ani_catalog_title/ani_catalog_title.dart';
import 'package:flutter_age_fans/ui/widgets/stateful/anime_pre/ani_pre_tile.dart';
import 'package:logging/logging.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';

import 'ani_recommend_view_model.dart';

class AniRecommendView extends StatelessWidget {
  const AniRecommendView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RecommendViewModel>.reactive(
      viewModelBuilder: () => RecommendViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
        body: _RecommendList(),
      ),
    );
  }
}

class _RecommendList extends ViewModelWidget<RecommendViewModel> {
  final _logger = Logger('_RecommendList');

  @override
  Widget build(BuildContext context, RecommendViewModel model) {
    final locale = S.of(context);
    return SmartRefresher(
      controller: model.refreshController,
      enablePullDown: true,
      enablePullUp: model.recommendList.isNotEmpty,
      onRefresh: () => model.refresh(),
      onLoading: () => model.loadMore(),
      header: const ClassicHeader(),
      footer: const ClassicFooter(),
      child: CustomScrollView(
        slivers: [
          UIHelper.sliverVerticalSpace(10),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: const BoxDecoration(
                color: AniColor.surfaceColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6),
                  topRight: Radius.circular(6),
                ),
              ),
              child: Column(
                children: [
                  AniCatalogTitle(
                    locale.recommendList,
                    start: const Icon(
                      Icons.list_alt,
                      color: AniColor.textFourthColor,
                      size: 18,
                    ),
                    rightInfo: TextSpan(
                      text: '${locale.total} ',
                      style: const TextStyle(
                          fontSize: 14, color: AniColor.textFourthColor),
                      children: [
                        TextSpan(
                          text: '${model.recommendCount}',
                          style: const TextStyle(color: AniColor.colorFF5F00),
                        ),
                        TextSpan(text: ' ${locale.section}'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          UIHelper.sliverHorizontalDivider(),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                childAspectRatio: 9 / 16,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final data = model.recommendList[index];
                  return Container(
                      decoration: BoxDecoration(
                        color: AniColor.surfaceColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(
                              index == model.recommendList.length - 1 ? 6 : 0),
                          bottomRight: Radius.circular(
                              index == model.recommendList.length - 1 ? 6 : 0),
                        ),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: AniPreTile(key: Key(data.aid), aniPre: data));
                },
                childCount: model.recommendList.length,
              ),
            ),
          ),
          UIHelper.sliverVerticalSpace(16),
        ],
      ),
    );
  }
}