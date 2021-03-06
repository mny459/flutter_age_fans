import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_age_fans/core/constant/routers.dart';
import 'package:flutter_age_fans/core/services/navigation/navigation_helper.dart';
import 'package:flutter_age_fans/ui/widgets/stateful/ani_controller/better_player_material_controls.dart';
import 'package:logging/logging.dart';
import 'package:orientation/orientation.dart';

class AniPlayView extends StatefulWidget {
  final String url;

  const AniPlayView(this.url, {Key? key}) : super(key: key);

  @override
  State<AniPlayView> createState() => _AniPlayViewState();
}

class _AniPlayViewState extends State<AniPlayView> {
  final _logger = Logger('_AniPlayViewState');

  @override
  void initState() {
    super.initState();
    OrientationPlugin.forceOrientation(DeviceOrientation.landscapeLeft);
  }

  @override
  void dispose() {
    OrientationPlugin.forceOrientation(DeviceOrientation.portraitUp);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BetterPlayer.network(
        Uri.decodeFull(widget.url),
        betterPlayerConfiguration: BetterPlayerConfiguration(
          autoPlay: true,
          fit: BoxFit.contain,
          fullScreenByDefault: true,
          allowedScreenSleep: false,
          aspectRatio: 16 / 9,
          controlsConfiguration: BetterPlayerControlsConfiguration(
            showControlsOnInitialize: false,
            playerTheme: BetterPlayerTheme.custom,
            customControlsBuilder: (controller, onPlayerVisibilityChanged) {
              return AniPlayerControls(
                onControlsVisibilityChanged: onPlayerVisibilityChanged,
                controlsConfiguration:
                    controller.betterPlayerControlsConfiguration,
                onQuite: onQuite,
              );
            },
          ),
        ),
      ),
    );
  }

  void onQuite() {
    NavigationHelper.popToPage(context, RouterName.aniDetail);
  }
}
