import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_age_fans/core/constant/ani_color.dart';
import 'package:flutter_age_fans/core/services/navigation/navigation_helper.dart';
import 'package:flutter_age_fans/generated/l10n.dart';
import 'package:flutter_age_fans/ui/shared/ui_helper.dart';
import 'package:flutter_age_fans/ui/views/mine/mine_view_model.dart';
import 'package:stacked/stacked.dart';

class MineView extends StatelessWidget {

  const MineView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
    return ViewModelBuilder<MineViewModel>.nonReactive(
      viewModelBuilder: () => MineViewModel(),
      builder: (context, model, child) => Column(
        children: [
          MineListItem(
            Icons.history_outlined,
            local.historyRecord,
            () => NavigationHelper.navSettingsView(),
          ),
          UIHelper.horizontalDivider(indent: 10, endIndent: 10),
          MineListItem(
            Icons.comment_outlined,
            local.mineComment,
            () => NavigationHelper.navSettingsView(),
          ),
          UIHelper.horizontalDivider(indent: 10, endIndent: 10),
          MineListItem(
            Icons.favorite_outline,
            local.mineCollect,
            () => NavigationHelper.navCollectionView(),
          ),
          UIHelper.horizontalDivider(indent: 10, endIndent: 10),
          MineListItem(
            Icons.lock_outline,
            local.changePassword,
            () => NavigationHelper.navSettingsView(),
          ),
          UIHelper.verticalSpace(10),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => model.quitLogin(),
            child: Container(
              color: AniColor.surfaceColor,
              height: 44,
              width: double.infinity,
              alignment: Alignment.center,
              child: Text(
                local.quitLogin,
                style: const TextStyle(
                    fontSize: 14, color: AniColor.textFourthColor),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MineListItem extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final Function onTap;

  const MineListItem(this.leadingIcon, this.title, this.onTap, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap.call();
      },
      child: Container(
        height: 44,
        color: AniColor.surfaceColor,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(leadingIcon, size: 16, color: AniColor.textFourthColor),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  title,
                  style: const TextStyle(
                      color: AniColor.textFourthColor, fontSize: 14, height: 1),
                ),
              ),
            ),
            const Icon(
              CupertinoIcons.right_chevron,
              size: 16,
              color: AniColor.textFourthColor,
            )
          ],
        ),
      ),
    );
  }
}
