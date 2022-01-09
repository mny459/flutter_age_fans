import 'package:flutter/material.dart';
import 'package:flutter_age_fans/core/constant/ani_color.dart';
import 'package:flutter_age_fans/generated/l10n.dart';
import 'package:flutter_age_fans/ui/shared/ui_helper.dart';
import 'package:flutter_age_fans/ui/widgets/stateful/ani_catalog/ani_catalog_tile.dart';
import 'package:flutter_age_fans/ui/widgets/stateful/ani_catalog_title/ani_catalog_title.dart';
import 'package:flutter_age_fans/ui/widgets/stateless/state_view.dart';
import 'package:logging/logging.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';

import 'ani_catalog_view_model.dart';

class AniCatalogView extends StatelessWidget {
  const AniCatalogView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AniCatalogViewModel>.reactive(
      viewModelBuilder: () => AniCatalogViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
        body: StateView(
          loadingOrError: model.options.isEmpty,
          hasError: model.hasError,
          child: _AniCatalogList(),
          onRetry: () {
            model.refresh();
          },
        ),
      ),
    );
  }
}

class _AniCatalogList extends ViewModelWidget<AniCatalogViewModel> {
  final _logger = Logger('_AniCatalogList');

  @override
  Widget build(BuildContext context, AniCatalogViewModel model) {
    var locale = S.of(context);
    return SmartRefresher(
      controller: model.refreshController,
      enablePullDown: true,
      enablePullUp: true,
      onRefresh: () => model.refresh(),
      onLoading: () => model.loadMore(),
      header: const ClassicHeader(),
      footer: const ClassicFooter(),
      child: CustomScrollView(
        slivers: [
          UIHelper.sliverVerticalSpace(10),
          SliverToBoxAdapter(
            child: _AniCatalogSearchOptions(),
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
              child: AniCatalogTitle(
                locale.recentUpdate,
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
                      text: '${model.allCount}',
                      style: const TextStyle(color: AniColor.colorFF5F00),
                    ),
                    TextSpan(text: ' ${locale.section}'),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final data = model.aniList[index];
                  return Container(
                      decoration: BoxDecoration(
                        color: AniColor.surfaceColor,
                        borderRadius: index + 1 == model.aniList.length
                            ? const BorderRadius.only(
                                bottomLeft: Radius.circular(6),
                                bottomRight: Radius.circular(6),
                              )
                            : BorderRadius.zero,
                      ),
                      child: AniCatalogTile(key: Key(data.aid), aniPre: data));
                },
                childCount: model.aniList.length,
              ),
            ),
          ),
          UIHelper.sliverHorizontalSpace(16),
        ],
      ),
    );
  }
}

class _AniCatalogSearchOptions extends ViewModelWidget<AniCatalogViewModel> {
  final _logger = Logger('_AniCatalogList');

  @override
  Widget build(BuildContext context, AniCatalogViewModel model) {
    final locale = S.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: const BoxDecoration(
          color: AniColor.surfaceColor,
          borderRadius: BorderRadius.all(Radius.circular(6))),
      child: Column(
        children: [
          _AniCatalogSearchOption(
            locale.region,
            model.getOptions(model.labelsRegion),
            model.getOptionIndex(model.labelsRegion),
            (index) {
              model.changeSearchOption(model.labelsRegion, index);
            },
          ),
          _AniCatalogSearchOption(
            locale.genre,
            model.getOptions(model.labelsGenre),
            model.getOptionIndex(model.labelsGenre),
            (index) {
              model.changeSearchOption(model.labelsGenre, index);
            },
          ),
          _AniCatalogSearchOption(
            locale.letter,
            model.getOptions(model.labelsLetter),
            model.getOptionIndex(model.labelsLetter),
            (index) {
              model.changeSearchOption(model.labelsLetter, index);
            },
          ),
          _AniCatalogSearchOption(
            locale.year,
            model.getOptions(model.labelsYear),
            model.getOptionIndex(model.labelsYear),
            (index) {
              model.changeSearchOption(model.labelsYear, index);
            },
          ),
          _AniCatalogSearchOption(
            locale.season,
            model.getOptions(model.labelsSeason),
            model.getOptionIndex(model.labelsSeason),
            (index) {
              model.changeSearchOption(model.labelsSeason, index);
            },
          ),
          _AniCatalogSearchOption(
            locale.status,
            model.getOptions(model.labelsStatus),
            model.getOptionIndex(model.labelsStatus),
            (index) {
              model.changeSearchOption(model.labelsStatus, index);
            },
          ),
          _AniCatalogSearchOption(
            locale.type,
            model.getOptions(model.labelsLabel),
            model.getOptionIndex(model.labelsLabel),
            (index) {
              model.changeSearchOption(model.labelsLabel, index);
            },
          ),
          _AniCatalogSearchOption(
            locale.resources,
            model.getOptions(model.labelsResource),
            model.getOptionIndex(model.labelsResource),
            (index) {
              model.changeSearchOption(model.labelsResource, index);
            },
          ),
          _AniCatalogSearchOption(
            locale.order,
            model.getOptions(model.labelsOrder),
            model.getOptionIndex(model.labelsOrder),
            (index) {
              model.changeSearchOption(model.labelsOrder, index);
            },
          ),
        ],
      ),
    );
  }
}

typedef OnOptionClicked = Function(int);

class _AniCatalogSearchOption extends StatelessWidget {
  final String optionName;
  final List<String> options;
  final int selectedOption;
  final OnOptionClicked onOptionClicked;

  const _AniCatalogSearchOption(
    this.optionName,
    this.options,
    this.selectedOption,
    this.onOptionClicked,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 60,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            alignment: Alignment.centerRight,
            child: Text(
              optionName,
              style: const TextStyle(
                  color: AniColor.textFourthColor, fontSize: 14),
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: options.length,
              itemBuilder: (_, index) {
                return GestureDetector(
                  onTap: () {
                    onOptionClicked.call(index);
                  },
                  child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        options[index],
                        style: TextStyle(
                          fontSize: 14,
                          color: index == selectedOption
                              ? AniColor.colorSelectedOption
                              : AniColor.textThirdColor,
                        ),
                      )),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
