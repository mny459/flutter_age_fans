import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_age_fans/core/constant/ani_color.dart';
import 'package:flutter_age_fans/core/helper/NetworkImageHelper.dart';
import 'package:flutter_age_fans/core/services/navigation/navigation_helper.dart';
import 'package:flutter_age_fans/generated/l10n.dart';
import 'package:flutter_age_fans/ui/views/ani_catalog/ani_catalog_view.dart';
import 'package:flutter_age_fans/ui/views/ani_rank/ani_rank_view.dart';
import 'package:flutter_age_fans/ui/views/ani_update/ani_update_view.dart';
import 'package:flutter_age_fans/ui/views/ani_home/ani_home_view.dart';
import 'package:flutter_age_fans/ui/views/ani_recommend/ani_recommend_view.dart';
import 'package:flutter_age_fans/ui/views/ani_main/main_view_model.dart';
import 'package:flutter_age_fans/ui/widgets/stateful/lazy_index_stack.dart';
import 'package:stacked/stacked.dart';

class MainView extends StatelessWidget {
  final _views = <Widget>[
    const AniHomeView(),
    const AniCatalogView(),
    const AniRecommendView(),
    const AniUpdateView(),
    const AniRankView(),
  ];

  MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => MainViewModel(),
      onModelReady: (model) {
        model.init();
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            S.of(context).appName,
          ),
          leading: GestureDetector(
            onTap: () => NavigationHelper.navSearch(),
            child: const Icon(CupertinoIcons.search),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () => NavigationHelper.navLoginView(),
            )
          ],
        ),
        body: LazyIndexedStack(
          reuse: true,
          index: model.index,
          itemCount: _views.length,
          itemBuilder: (_, index) => _views[index],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: model.index,
          items: List.generate(
              model.navList.length,
              (index) => BottomNavigationBarItem(
                    icon: ExtendedImage.network(
                      model.navList[index].icon,
                      width: 24,
                      height: 24,
                      fit: BoxFit.cover,
                      cache: true,
                      color: model.index == index
                          ? AniColor.colorFF5F00
                          : AniColor.textMainColor,
                      loadStateChanged: (state) {
                        return NetworkImageHelper.handleEmptyLoadState(state);
                      },
                    ),
                    label: model.navList[index].title,
                  )),
          onTap: model.changeTab,
        ),
      ),
    );
  }
}
