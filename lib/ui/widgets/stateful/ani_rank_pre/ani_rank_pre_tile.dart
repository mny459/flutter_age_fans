import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_age_fans/core/constant/ani_color.dart';
import 'package:flutter_age_fans/core/extension/string_extension.dart';
import 'package:flutter_age_fans/core/models/ani_rank/ani_rank_bean.dart';
import 'package:flutter_age_fans/core/services/navigation/navigation_helper.dart';
import 'package:flutter_age_fans/ui/shared/ui_helper.dart';
import 'package:stacked/stacked.dart';
import 'ani_rank_pre_tile_view_model.dart';

class AniRankPreTile extends StatelessWidget {
  final AniRankPreBean aniPre;

  const AniRankPreTile({Key? key, required this.aniPre}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AniRankPreTileViewModel>.nonReactive(
      viewModelBuilder: () => AniRankPreTileViewModel(),
      onModelReady: (model) => model.init(aniPre),
      builder: (context, model, child) => const AniRankPreItem(),
    );
  }
}

class AniRankPreItem extends ViewModelWidget<AniRankPreTileViewModel> {
  const AniRankPreItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, AniRankPreTileViewModel model) {
    final data = model.aniPre;
    return GestureDetector(
      onTap: () => NavigationHelper.navDetailView(data.aid),
      child: Container(
        height: 46,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Container(
                height: 26,
                width: 32,
                margin: const EdgeInsets.only(right: 16),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: data.no <= 10
                            ? AniColor.colorBorder
                            : AniColor.colorBorder1),
                    borderRadius: BorderRadius.zero),
                child: Text(
                  data.no.toString(),
                  style: TextStyle(
                      color: data.no <= 10
                          ? AniColor.colorFE0101
                          : AniColor.textMainColor,
                      fontSize: 14),
                )),
            Expanded(
              child: Text(
                data.title.joinChar,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AniColor.textSecondColor,
                  fontSize: 14,
                ),
              ),
            ),
            UIHelper.horizontalSpace(8),
            Text(
              data.cCnt.toString(),
              style: const TextStyle(
                fontSize: 12,
                color: AniColor.textFourthColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
