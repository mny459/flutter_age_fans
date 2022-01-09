import 'package:flutter/material.dart';
import 'package:flutter_age_fans/core/constant/ani_color.dart';
import 'package:flutter_age_fans/generated/l10n.dart';
import 'package:flutter_age_fans/ui/widgets/stateful/anime_pre/ani_pre_tile.dart';
import 'package:flutter_age_fans/ui/widgets/stateless/state_view.dart';
import 'package:logging/logging.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';
import 'ani_collection_view_model.dart';

class AniCollectionView extends StatelessWidget {
  const AniCollectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
    return ViewModelBuilder<AniCollectionViewModel>.reactive(
      viewModelBuilder: () => AniCollectionViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text(local.mineCollect),
        ),
        body: StateView(
          loadingOrError: model.collectionList.isEmpty,
          hasError: model.hasError,
          child: _CollectionList(),
          onRetry: () {
            model.refresh();
          },
        ),
      ),
    );
  }
}

class _CollectionList extends ViewModelWidget<AniCollectionViewModel> {
  final _logger = Logger('_AniDetail');

  @override
  Widget build(BuildContext context, AniCollectionViewModel model) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(6),
      decoration: const BoxDecoration(
          color: AniColor.surfaceColor,
          borderRadius: BorderRadius.all(Radius.circular(6))),
      child: SmartRefresher(
        controller: model.refreshController,
        enablePullDown: true,
        enablePullUp: model.collectionList.isNotEmpty,
        onRefresh: () => model.refresh(),
        onLoading: () => model.loadMore(),
        header: const ClassicHeader(),
        footer: const ClassicFooter(),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
            childAspectRatio: 9 / 16,
          ),
          itemBuilder: (context, index) {
            final data = model.collectionList[index];
            return AniPreTile(key: Key(data.aid), aniPre: data);
          },
          itemCount: model.collectionList.length,
        ),
      ),
    );
  }
}
