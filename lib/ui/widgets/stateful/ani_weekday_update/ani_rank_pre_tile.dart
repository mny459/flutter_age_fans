import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_age_fans/core/constant/ani_color.dart';
import 'package:flutter_age_fans/core/models/ani_home/ani_home_bean.dart';
import 'package:flutter_age_fans/core/services/navigation/navigation_helper.dart';
import 'package:stacked/stacked.dart';
import 'ani_rank_pre_tile_view_model.dart';

class AniWeekdayUpdateTile extends StatelessWidget {
  final XinFansInfoBean info;

  const AniWeekdayUpdateTile({Key? key, required this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AniWeekdayUpdateTileViewModel>.nonReactive(
      viewModelBuilder: () => AniWeekdayUpdateTileViewModel(),
      onModelReady: (model) => model.init(info),
      builder: (context, model, child) => const AniWeekdayUpdateItem(),
    );
  }
}

class AniWeekdayUpdateItem extends ViewModelWidget<AniWeekdayUpdateTileViewModel> {
  const AniWeekdayUpdateItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, AniWeekdayUpdateTileViewModel model) {
    final data = model.aniPre;
    return GestureDetector(
      onTap: () => NavigationHelper.navDetailView(data.id),
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Expanded(
              child: Text(
                data.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AniColor.textSecondColor,
                  fontSize: 14,
                ),
              ),
            ),
            Text(
              data.nameForNew,
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
