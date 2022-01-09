import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_age_fans/core/constant/ani_color.dart';
import 'package:flutter_age_fans/core/extension/string_extension.dart';
import 'package:flutter_age_fans/core/helper/NetworkImageHelper.dart';
import 'package:flutter_age_fans/core/models/ani_catalog/ani_catalog_bean.dart';
import 'package:flutter_age_fans/core/services/navigation/navigation_helper.dart';
import 'package:flutter_age_fans/ui/shared/ui_helper.dart';
import 'package:stacked/stacked.dart';

import 'ani_catalog_tile_view_model.dart';

class AniCatalogTile extends StatelessWidget {
  final AniPreLBean aniPre;

  const AniCatalogTile({Key? key, required this.aniPre}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AniPreTileViewModel>.nonReactive(
      viewModelBuilder: () => AniPreTileViewModel(),
      onModelReady: (model) => model.init(aniPre),
      builder: (context, model, child) => const AniCatalogItem(),
    );
  }
}

class AniCatalogItem extends ViewModelWidget<AniPreTileViewModel> {
  const AniCatalogItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, AniPreTileViewModel model) {
    final data = model.aniPre;
    var picSmall = data.picSmall;
    if (!picSmall.startsWith('http')) {
      picSmall = 'https:$picSmall';
    }
    return GestureDetector(
      onTap: () => NavigationHelper.navDetailView(data.aid),
      child: Container(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 198,
              child: AspectRatio(
                aspectRatio: 3 / 4,
                child: Stack(
                  children: [
                    Positioned.fill(
                      top: 4,
                      child: ExtendedImage.network(
                        picSmall,
                        cache: true,
                        fit: BoxFit.cover,
                        loadStateChanged: (state) {
                          return NetworkImageHelper.handleErrorLoadState(state);
                        },
                      ),
                    ),
                    Positioned(
                      right: 4,
                      bottom: 4,
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 6.0),
                          decoration: const BoxDecoration(
                              color: AniColor.colorA6000000,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14))),
                          child: Text(
                            data.newAnimTitle.joinChar,
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
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.aniName.joinChar,
                      style: const TextStyle(
                        fontSize: 16,
                        color: AniColor.colorD0E0F0,
                      ),
                    ),
                    UIHelper.verticalSpace(10),
                    Text.rich(
                      TextSpan(
                          text: "动画种类：",
                          style: const TextStyle(
                              fontSize: 14, color: AniColor.color808081),
                          children: [
                            TextSpan(
                                text: data.aniType.joinChar,
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: AniColor.textFourthColor))
                          ]),
                    ),
                    Text.rich(
                      TextSpan(
                          text: "播放装填：",
                          style: const TextStyle(
                              fontSize: 14, color: AniColor.color808081),
                          children: [
                            TextSpan(
                                text: data.playStatus.joinChar,
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: AniColor.textFourthColor))
                          ]),
                    ),
                    Text.rich(
                      TextSpan(
                          text: "原作：",
                          style: const TextStyle(
                              fontSize: 14, color: AniColor.color808081),
                          children: [
                            TextSpan(
                                text: data.originName.joinChar,
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: AniColor.textFourthColor))
                          ]),
                    ),
                    Text.rich(
                      TextSpan(
                          text: "剧情类型：",
                          style: const TextStyle(
                              fontSize: 14, color: AniColor.color808081),
                          children: [
                            TextSpan(
                                text: data.plotTypeStr(),
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: AniColor.textFourthColor))
                          ]),
                    ),
                    UIHelper.verticalSpace(14),
                    Container(
                        height: 32,
                        width: 80,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            color: AniColor.color1989FA,
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                        child: const Text(
                          "点击播放",
                          style: TextStyle(
                            fontSize: 12,
                            color: AniColor.textMainColor,
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
