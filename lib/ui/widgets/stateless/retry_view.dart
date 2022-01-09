import 'package:flutter/material.dart';
import 'package:flutter_age_fans/core/constant/ani_color.dart';
import 'package:flutter_age_fans/ui/shared/ui_helper.dart';
import 'package:flutter_age_fans/ui/widgets/stateless/primary_button.dart';

class RetryView extends StatelessWidget {
  String errorMessage = '';
  final Function? onRetry;

  RetryView(this.onRetry, {this.errorMessage = 'Oops,出现了一点小意外', Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            errorMessage,
            style: const TextStyle(fontSize: 14, color: AniColor.textMainColor),
          ),
          UIHelper.verticalSpace(24),
          SizedBox(
            width: 200,
            child: PrimaryButton(
              content: '重试',
              onPressed: () {
                onRetry?.call();
              },
            ),
          )
        ],
      ),
    );
  }
}
