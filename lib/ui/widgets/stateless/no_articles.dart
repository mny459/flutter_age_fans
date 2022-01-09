import 'package:flutter/widgets.dart';
import 'package:flutter_age_fans/generated/l10n.dart';

class NoArticles extends StatelessWidget {
  const NoArticles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);

    return const Center(
      child: Text(''),
    );
  }
}
