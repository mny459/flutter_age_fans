import 'package:flutter/material.dart';
import 'package:flutter_age_fans/core/constant/ani_color.dart';
import 'package:flutter_age_fans/generated/l10n.dart';
import 'package:flutter_age_fans/ui/shared/theme_helper.dart';
import 'package:flutter_age_fans/ui/shared/ui_helper.dart';
import 'package:flutter_age_fans/ui/widgets/stateful/ani_catalog_title/ani_catalog_title.dart';
import 'package:flutter_age_fans/ui/widgets/stateful/ani_rank_pre/ani_rank_pre_tile.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/style/picker_style.dart';
import 'package:logging/logging.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';
import 'ani_rank_view_model.dart';

class AniRankView extends StatelessWidget {
  const AniRankView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AniRankViewModel>.reactive(
      viewModelBuilder: () => AniRankViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
        body: _RankList(),
      ),
    );
  }
}

class _RankList extends ViewModelWidget<AniRankViewModel> {
  final _logger = Logger('_RankList');

  @override
  Widget build(BuildContext context, AniRankViewModel model) {
    final locale = S.of(context);
    return SmartRefresher(
      controller: model.refreshController,
      enablePullDown: true,
      onRefresh: () => model.refresh(),
      header: const ClassicHeader(),
      child: CustomScrollView(
        slivers: [
          UIHelper.sliverVerticalSpace(10),
          SliverToBoxAdapter(
            child: Container(
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: const BoxDecoration(
                    color: AniColor.surfaceColor,
                    borderRadius: BorderRadius.all(Radius.circular(6))),
                child: Row(
                  children: [
                    SizedBox(
                      width: 98,
                      child: Text(
                        locale.publicShowYear,
                        style: const TextStyle(
                            fontSize: 14, color: AniColor.textFourthColor),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _logger.severe('${model.years.length}');
                          Pickers.showSinglePicker(
                            context,
                            data: model.years,
                            selectData: model.years[model.yearIndex],
                            onConfirm: (_, position) {
                              model.changeYear(position);
                            },
                            pickerStyle: PickerStyle(
                              backgroundColor: ThemeHelper.backgroundColor(),
                              textColor: ThemeHelper.onSurfaceColor(),
                              cancelButton: Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Text(
                                  locale.cancel,
                                  style: const TextStyle(
                                      color: AniColor.textFourthColor),
                                ),
                              ),
                              commitButton: Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: Text(
                                  locale.confirm,
                                  style: const TextStyle(
                                      color: AniColor.colorFF5F00),
                                ),
                              ),
                              headDecoration:  BoxDecoration(
                                color: ThemeHelper.backgroundColor(),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                ),
                              ),
                            ),
                          );
                        },
                        child: Text(
                          model.yearIndex == 0
                              ? locale.hintSelectPublicShowYear
                              : model.year,
                          style: const TextStyle(
                              fontSize: 14, color: AniColor.textFourthColor),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
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
                    locale.aniRankList,
                    start: const Icon(
                      Icons.bar_chart_rounded,
                      color: AniColor.textFourthColor,
                      size: 18,
                    ),
                    rightInfo: TextSpan(
                      text: '${locale.first} ',
                      style: const TextStyle(
                          fontSize: 14, color: AniColor.textFourthColor),
                      children: [
                        TextSpan(
                          text: '${model.rankCount}',
                          style: const TextStyle(color: AniColor.colorFF5F00),
                        ),
                        TextSpan(text: ' ${locale.section}'),
                      ],
                    ),
                  ),
                  UIHelper.horizontalDivider()
                ],
              ),
            ),
          ),
          SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final data = model.rankList[index];
                final divider = index != model.rankList.length
                    ? UIHelper.horizontalDivider(indent: 8, endIndent: 8)
                    : const Spacer();
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: AniColor.surfaceColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(
                          index == model.rankList.length - 1 ? 6 : 0),
                      bottomRight: Radius.circular(
                          index == model.rankList.length - 1 ? 6 : 0),
                    ),
                  ),
                  child: Column(
                    children: [
                      AniRankPreTile(key: Key(data.aid), aniPre: data),
                      divider
                    ],
                  ),
                );
              },
              childCount: model.rankList.length,
            ),
            itemExtent: 47,
          ),
          UIHelper.sliverVerticalSpace(16)
        ],
      ),
    );
  }
}