import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_age_fans/core/constant/ani_color.dart';
import 'package:flutter_age_fans/generated/l10n.dart';
import 'package:flutter_age_fans/ui/shared/ui_helper.dart';
import 'package:flutter_age_fans/ui/widgets/stateful/ani_catalog/ani_catalog_tile.dart';
import 'package:flutter_age_fans/ui/widgets/stateful/ani_catalog_title/ani_catalog_title.dart';
import 'package:logging/logging.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';

import 'search_view_model.dart';

class SearchView extends StatelessWidget {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var locale = S.of(context);
    return ViewModelBuilder<SearchViewModel>.reactive(
      viewModelBuilder: () => SearchViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: AniColor.surfaceColor,
          title: TextField(
            controller: controller,
            onSubmitted: (query) {
              model.search(word: query);
            },
            onChanged: (text) {
              model.onTextChanged(text);
            },
            style: const TextStyle(
              fontSize: 14,
              color: AniColor.textFourthColor,
            ),
            cursorColor: Colors.white,
            decoration: InputDecoration(
              hintText: locale.hintSearch,
              border: InputBorder.none,
              hintStyle: theme.textTheme.subtitle1!
                  .copyWith(color: AniColor.textFourthColor),
            ),
          ),
          actions: [
            IconButton(
                icon: const Icon(
                  CupertinoIcons.search,
                  color: AniColor.textFourthColor,
                ),
                onPressed: () {
                  model.search();
                })
          ],
        ),
        body: _SearchResultList(),
        // body: Container(color: Colors.orange),
      ),
    );
  }
}

class _SearchResultList extends ViewModelWidget<SearchViewModel> {
  final _logger = Logger('_Articles');

  @override
  Widget build(BuildContext context, SearchViewModel model) {
    final locale = S.of(context);
    return SmartRefresher(
      controller: model.refreshController,
      enablePullDown: true,
      enablePullUp: model.aniList.isNotEmpty,
      onRefresh: () => model.refresh(),
      onLoading: () => model.loadMore(),
      header: const ClassicHeader(),
      footer: const ClassicFooter(),
      child: CustomScrollView(
        slivers: [
          UIHelper.sliverVerticalSpace(6),
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
                locale.searchResult(model.keyWord),
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
          UIHelper.sliverHorizontalDivider(),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 8),
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
                    child: AniCatalogTile(key: Key(data.aid), aniPre: data),
                  );
                },
                childCount: model.aniList.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
