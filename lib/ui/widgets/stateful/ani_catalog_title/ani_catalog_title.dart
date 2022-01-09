import 'package:flutter/material.dart';
import 'package:flutter_age_fans/core/constant/ani_color.dart';
import 'package:flutter_age_fans/ui/shared/ui_helper.dart';

class AniCatalogTitle extends StatelessWidget {
  final Widget? start;
  final String title;
  InlineSpan? rightInfo;

  // final Icon leftIcon;

  AniCatalogTitle(this.title, {Key? key, this.start, this.rightInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      height: 44,
      child: Row(
        children: [
          start ?? UIHelper.horizontalSpace(8),
          start != null
              ? UIHelper.horizontalSpace(4)
              : UIHelper.horizontalSpace(0),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                  fontSize: 14, color: AniColor.textFourthColor),
              // style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          rightInfo == null ? Container() : Text.rich(rightInfo!)
        ],
      ),
    );
  }
}
