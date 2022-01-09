import 'dart:math';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_age_fans/core/constant/ani_color.dart';
import 'package:flutter_age_fans/core/extension/string_extension.dart';
import 'package:flutter_age_fans/core/helper/NetworkImageHelper.dart';
import 'package:flutter_age_fans/core/models/ani_pre/ani_pre_bean.dart';
import 'package:flutter_age_fans/core/services/navigation/navigation_helper.dart';
import 'package:logging/logging.dart';
import 'package:stacked/stacked.dart';
import 'ani_pre_tile_view_model.dart';

class AniPreTile extends StatelessWidget {
  final AniPreBean aniPre;

  const AniPreTile({Key? key, required this.aniPre}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AniPreTileViewModel>.nonReactive(
      viewModelBuilder: () => AniPreTileViewModel(),
      onModelReady: (model) => model.init(aniPre),
      builder: (context, model, child) => _AniPreItem(),
    );
  }
}

class _AniPreItem extends ViewModelWidget<AniPreTileViewModel> {
  final _logger = Logger('_AniPreItem');

  _AniPreItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, AniPreTileViewModel model) {
    final data = model.aniPre;
    var picSmall = data.picSmall;
    if (!picSmall.startsWith('http')) {
      picSmall = 'https:$picSmall';
    }
    // _logger.severe('${data.title} ${data.picSmall} $picSmall');
    return GestureDetector(
      onTap: () => NavigationHelper.navDetailView(data.aid),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: 3 / 4,
              child: Stack(
                children: [
                  Positioned.fill(
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
                    bottom: 8,
                    left: 4,
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 6.0),
                          decoration: const BoxDecoration(
                              color: AniColor.colorA6000000,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14))),
                          child: Text(
                            data.newTitle.joinChar,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              height: 1,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 8),
            child: Text(
              data.title.joinChar,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 14, color: AniColor.textFourthColor),
            ),
          ),
        ],
      ),
    );
  }
}
