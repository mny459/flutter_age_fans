import 'dart:async';
import 'package:better_player/src/configuration/better_player_controls_configuration.dart';
import 'package:better_player/src/controls/better_player_clickable_widget.dart';
import 'package:better_player/src/controls/better_player_controls_state.dart';
import 'package:better_player/src/controls/better_player_material_progress_bar.dart';
import 'package:better_player/src/controls/better_player_multiple_gesture_detector.dart';
import 'package:better_player/src/controls/better_player_progress_colors.dart';
import 'package:better_player/src/core/better_player_controller.dart';
import 'package:better_player/src/core/better_player_utils.dart';
import 'package:better_player/src/video_player/video_player.dart';

import 'package:flutter/material.dart';
import 'package:flutter_age_fans/core/constant/ani_color.dart';
import 'package:logging/logging.dart';

class AniPlayerControls extends StatefulWidget {
  ///Callback used to send information if player bar is hidden or not
  final Function(bool visbility) onControlsVisibilityChanged;
  final Function onQuite;

  ///Controls config
  final BetterPlayerControlsConfiguration controlsConfiguration;

  const AniPlayerControls({
    Key? key,
    required this.onControlsVisibilityChanged,
    required this.controlsConfiguration,
    required this.onQuite,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BetterPlayerMaterialControlsState();
  }
}

class _BetterPlayerMaterialControlsState
    extends BetterPlayerControlsState<AniPlayerControls> {
  final _logger = Logger("_BetterPlayerMaterialControlsState");
  VideoPlayerValue? _latestValue;
  double? _latestVolume;
  Timer? _hideTimer;
  Timer? _initTimer;
  Timer? _showAfterExpandCollapseTimer;
  bool _displayTapped = false;
  bool _wasLoading = false;
  VideoPlayerController? _controller;
  BetterPlayerController? _betterPlayerController;
  StreamSubscription? _controlsVisibilityStreamSubscription;

  BetterPlayerControlsConfiguration get _controlsConfiguration =>
      widget.controlsConfiguration;

  @override
  VideoPlayerValue? get latestValue => _latestValue;

  @override
  BetterPlayerController? get betterPlayerController => _betterPlayerController;

  @override
  BetterPlayerControlsConfiguration get betterPlayerControlsConfiguration =>
      _controlsConfiguration;

  @override
  Widget build(BuildContext context) {
    return buildLTRDirectionality(_buildMainWidget());
  }

  ///Builds main widget of the controls.
  Widget _buildMainWidget() {
    _wasLoading = isLoading(_latestValue);
    if (_latestValue?.hasError == true) {
      return Container(
        color: Colors.black,
        child: _buildErrorWidget(),
      );
    }
    return GestureDetector(
      onTap: () {
        if (BetterPlayerMultipleGestureDetector.of(context) != null) {
          BetterPlayerMultipleGestureDetector.of(context)!.onTap?.call();
        }
        controlsNotVisible
            ? cancelAndRestartTimer()
            : changePlayerControlsNotVisible(true);
      },
      onDoubleTap: () {
        if (BetterPlayerMultipleGestureDetector.of(context) != null) {
          BetterPlayerMultipleGestureDetector.of(context)!.onDoubleTap?.call();
        }
        cancelAndRestartTimer();
      },
      onLongPress: () {
        if (BetterPlayerMultipleGestureDetector.of(context) != null) {
          BetterPlayerMultipleGestureDetector.of(context)!.onLongPress?.call();
        }
      },
      child: AbsorbPointer(
        absorbing: controlsNotVisible,
        child: Stack(
          children: [
            Positioned(top: 0, left: 0, right: 0, child: _buildTopBar()),
            Expanded(
              child: _wasLoading
                  ? Center(child: _buildLoadingWidget())
                  : const SizedBox(),
            ),
            Positioned(bottom: 0, left: 0, right: 0, child: _buildBottomBar()),
            // _buildNextVideoWidget(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

  void _dispose() {
    _controller?.removeListener(_updateState);
    _hideTimer?.cancel();
    _initTimer?.cancel();
    _showAfterExpandCollapseTimer?.cancel();
    _controlsVisibilityStreamSubscription?.cancel();
  }

  @override
  void didChangeDependencies() {
    final _oldController = _betterPlayerController;
    _betterPlayerController = BetterPlayerController.of(context);
    _controller = _betterPlayerController!.videoPlayerController;
    _latestValue = _controller!.value;

    if (_oldController != _betterPlayerController) {
      _dispose();
      _initialize();
    }

    super.didChangeDependencies();
  }

  Widget _buildErrorWidget() {
    const textStyle = TextStyle(color: AniColor.textFourthColor);
    _logger.severe('error on ');
    return Stack(
      children: [
        Positioned(
          left: 16,
          top: 16,
          child: IconButton(
              onPressed: () {
                widget.onQuite.call();
              },
              icon: const Icon(Icons.close, color: AniColor.textFourthColor)),
        ),
        Positioned.fill(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.warning,
                color: _controlsConfiguration.iconsColor,
                size: 42,
              ),
              // Text(
              //   Uri.decodeFull(_betterPlayerController!.betterPlayerDataSource!.url),
              //   style: textStyle,
              // ),
              Text(
                "${_betterPlayerController!.videoPlayerController!.value.errorDescription}",
                style: textStyle,
              ),
              if (_controlsConfiguration.enableRetry)
                TextButton(
                  onPressed: () {
                    _betterPlayerController!.retryDataSource();
                  },
                  child: Text(
                    _betterPlayerController!.translations.generalRetry,
                    style: textStyle.copyWith(fontWeight: FontWeight.bold),
                  ),
                )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTopBar() {
    if (!betterPlayerController!.controlsEnabled) {
      return const SizedBox();
    }

    return AnimatedOpacity(
      opacity: controlsNotVisible ? 0.0 : 1.0,
      duration: _controlsConfiguration.controlsHideTime,
      onEnd: _onPlayerHide,
      child: SizedBox(
        height: _controlsConfiguration.controlBarHeight,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildMoreButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildMoreButton() {
    return BetterPlayerMaterialClickableWidget(
      onTap: () {
        widget.onQuite.call();
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(
          Icons.close,
          color: _controlsConfiguration.iconsColor,
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    if (!betterPlayerController!.controlsEnabled) {
      return const SizedBox();
    }
    return AnimatedOpacity(
      opacity: controlsNotVisible ? 0.0 : 1.0,
      duration: _controlsConfiguration.controlsHideTime,
      onEnd: _onPlayerHide,
      child: SizedBox(
        height: _controlsConfiguration.controlBarHeight,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildPlayPause(_controller!),
            Expanded(child: _buildProgressBar()),
            _buildPosition(),
            _buildExpandButton()
          ],
        ),
      ),
    );
  }

  Widget _buildExpandButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: BetterPlayerMaterialClickableWidget(
        onTap: _onExpandCollapse,
        child: AnimatedOpacity(
          opacity: controlsNotVisible ? 0.0 : 1.0,
          duration: _controlsConfiguration.controlsHideTime,
          child: Container(
            height: _controlsConfiguration.controlBarHeight,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Center(
              child: Icon(
                _betterPlayerController!.isFullScreen
                    ? _controlsConfiguration.fullscreenDisableIcon
                    : _controlsConfiguration.fullscreenEnableIcon,
                color: _controlsConfiguration.iconsColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHitAreaClickableButton(
      {Widget? icon, required void Function() onClicked}) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 80.0, maxWidth: 80.0),
      child: BetterPlayerMaterialClickableWidget(
        onTap: onClicked,
        child: Align(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(48),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Stack(
                children: [icon!],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSkipButton() {
    return _buildHitAreaClickableButton(
      icon: Icon(
        _controlsConfiguration.skipBackIcon,
        size: 24,
        color: _controlsConfiguration.iconsColor,
      ),
      onClicked: skipBack,
    );
  }

  Widget _buildForwardButton() {
    return _buildHitAreaClickableButton(
      icon: Icon(
        _controlsConfiguration.skipForwardIcon,
        size: 24,
        color: _controlsConfiguration.iconsColor,
      ),
      onClicked: skipForward,
    );
  }

  Widget _buildReplayButton(VideoPlayerController controller) {
    final bool isFinished = isVideoFinished(_latestValue);
    return _buildHitAreaClickableButton(
      icon: isFinished
          ? Icon(
              Icons.replay,
              size: 42,
              color: _controlsConfiguration.iconsColor,
            )
          : Icon(
              controller.value.isPlaying
                  ? _controlsConfiguration.pauseIcon
                  : _controlsConfiguration.playIcon,
              size: 42,
              color: _controlsConfiguration.iconsColor,
            ),
      onClicked: () {
        if (isFinished) {
          if (_latestValue != null && _latestValue!.isPlaying) {
            if (_displayTapped) {
              changePlayerControlsNotVisible(true);
            } else {
              cancelAndRestartTimer();
            }
          } else {
            _onPlayPause();
            changePlayerControlsNotVisible(true);
          }
        } else {
          _onPlayPause();
        }
      },
    );
  }

  Widget _buildPlayPause(VideoPlayerController controller) {
    return BetterPlayerMaterialClickableWidget(
      key: const Key("better_player_material_controls_play_pause_button"),
      onTap: _onPlayPause,
      child: Container(
        height: double.infinity,
        margin: const EdgeInsets.only(left: 12, right: 12),
        child: Icon(
          controller.value.isPlaying
              ? _controlsConfiguration.pauseIcon
              : _controlsConfiguration.playIcon,
          color: _controlsConfiguration.iconsColor,
        ),
      ),
    );
  }

  Widget _buildPosition() {
    final position =
        _latestValue != null ? _latestValue!.position : Duration.zero;
    final duration = _latestValue != null && _latestValue!.duration != null
        ? _latestValue!.duration!
        : Duration.zero;

    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: RichText(
        text: TextSpan(
            text: BetterPlayerUtils.formatDuration(position),
            style: TextStyle(
              fontSize: 10.0,
              color: _controlsConfiguration.textColor,
              decoration: TextDecoration.none,
            ),
            children: <TextSpan>[
              TextSpan(
                text: ' / ${BetterPlayerUtils.formatDuration(duration)}',
                style: TextStyle(
                  fontSize: 10.0,
                  color: _controlsConfiguration.textColor,
                  decoration: TextDecoration.none,
                ),
              )
            ]),
      ),
    );
  }

  @override
  void cancelAndRestartTimer() {
    _hideTimer?.cancel();
    _startHideTimer();

    changePlayerControlsNotVisible(false);
    _displayTapped = true;
  }

  Future<void> _initialize() async {
    _controller!.addListener(_updateState);

    _updateState();

    if ((_controller!.value.isPlaying) ||
        _betterPlayerController!.betterPlayerConfiguration.autoPlay) {
      _startHideTimer();
    }

    if (_controlsConfiguration.showControlsOnInitialize) {
      _initTimer = Timer(const Duration(milliseconds: 200), () {
        changePlayerControlsNotVisible(false);
      });
    }

    _controlsVisibilityStreamSubscription =
        _betterPlayerController!.controlsVisibilityStream.listen((state) {
      changePlayerControlsNotVisible(!state);
      if (!controlsNotVisible) {
        cancelAndRestartTimer();
      }
    });
  }

  void _onExpandCollapse() {
    changePlayerControlsNotVisible(true);
    _betterPlayerController!.toggleFullScreen();
    _showAfterExpandCollapseTimer =
        Timer(_controlsConfiguration.controlsHideTime, () {
      setState(() {
        cancelAndRestartTimer();
      });
    });
  }

  void _onPlayPause() {
    bool isFinished = false;

    if (_latestValue?.position != null && _latestValue?.duration != null) {
      isFinished = _latestValue!.position >= _latestValue!.duration!;
    }

    if (_controller!.value.isPlaying) {
      changePlayerControlsNotVisible(false);
      _hideTimer?.cancel();
      _betterPlayerController!.pause();
    } else {
      cancelAndRestartTimer();

      if (!_controller!.value.initialized) {
      } else {
        if (isFinished) {
          _betterPlayerController!.seekTo(const Duration());
        }
        _betterPlayerController!.play();
        _betterPlayerController!.cancelNextVideoTimer();
      }
    }
  }

  void _startHideTimer() {
    if (_betterPlayerController!.controlsAlwaysVisible) {
      return;
    }
    _hideTimer = Timer(const Duration(milliseconds: 3000), () {
      changePlayerControlsNotVisible(true);
    });
  }

  void _updateState() {
    if (mounted) {
      if (!controlsNotVisible ||
          isVideoFinished(_controller!.value) ||
          _wasLoading ||
          isLoading(_controller!.value)) {
        setState(() {
          _latestValue = _controller!.value;
          if (isVideoFinished(_latestValue) &&
              _betterPlayerController?.isLiveStream() == false) {
            changePlayerControlsNotVisible(false);
          }
        });
      }
    }
  }

  Widget _buildProgressBar() {
    return BetterPlayerMaterialVideoProgressBar(
      _controller,
      _betterPlayerController,
      onDragStart: () {
        _hideTimer?.cancel();
      },
      onDragEnd: () {
        _startHideTimer();
      },
      onTapDown: () {
        cancelAndRestartTimer();
      },
      colors: BetterPlayerProgressColors(
          playedColor: _controlsConfiguration.progressBarPlayedColor,
          handleColor: _controlsConfiguration.progressBarHandleColor,
          bufferedColor: _controlsConfiguration.progressBarBufferedColor,
          backgroundColor: _controlsConfiguration.progressBarBackgroundColor),
    );
  }

  void _onPlayerHide() {
    _betterPlayerController!.toggleControlsVisibility(!controlsNotVisible);
    widget.onControlsVisibilityChanged(!controlsNotVisible);
  }

  Widget? _buildLoadingWidget() {
    if (_controlsConfiguration.loadingWidget != null) {
      return Container(
        color: _controlsConfiguration.controlBarColor,
        child: _controlsConfiguration.loadingWidget,
      );
    }

    return CircularProgressIndicator(
      valueColor:
          AlwaysStoppedAnimation<Color>(_controlsConfiguration.loadingColor),
    );
  }
}
