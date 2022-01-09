import 'package:flutter/material.dart';
import 'package:flutter_age_fans/generated/l10n.dart';

class ConfirmDialog extends StatelessWidget {
  final VoidCallback onDenied;
  final VoidCallback onConfirmed;
  final String title;
  final String description;
  final String? buttonTitle;

  const ConfirmDialog({
    Key? key,
    required this.title,
    required this.description,
    required this.onDenied,
    required this.onConfirmed,
    this.buttonTitle,
  })  : super(key: key);

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);

    return WillPopScope(
      onWillPop: () async {
        if (onDenied != null) {
          onDenied();
        }
        return false;
      },
      child: AlertDialog(
        title: Text(title),
        content: Text(description),
        actions: <Widget>[
          // DialogAction(
          //   child: Text(local.cancel),
          //   onPressed: () {
          //     onDenied();
          //   },
          // ),
          // PlatformDialogAction(
          //   cupertino: (_, __) =>
          //       CupertinoDialogActionData(isDestructiveAction: true),
          //   child: Text(buttonTitle ?? local.confirm),
          //   onPressed: () {
          //     onConfirmed();
          //   },
          // ),
        ],
      ),
    );
  }
}
