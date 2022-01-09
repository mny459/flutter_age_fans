import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_age_fans/core/constant/animations.dart';

class CenterLoadingAnimation extends StatelessWidget {
  const CenterLoadingAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: LoadingAnimation(),
    );
  }
}

class LoadingAnimation extends StatelessWidget {

  const LoadingAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 50,
      child: FlareActor(
        Animations.loader,
        animation: Animations.loader_name,
      ),
    );
  }
}
