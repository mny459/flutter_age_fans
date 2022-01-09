import 'package:flutter_age_fans/core/utils/host_intercept_utils.dart';
import 'package:logging/logging.dart';
import 'package:stacked/stacked.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewModel extends BaseViewModel {
  final Logger _logger = Logger('WanWeb');
  WebViewController? _controller;
  double _progress = 0;

  double get progress => _progress;

  void initWebViewController(WebViewController controller) {
    _controller = controller;
  }

  void upgradeProgress(int progress) {
    _progress = progress / 100.0;
    // _logger.info('load progress $_progress');
    notifyListeners();
  }

  NavigationDecision navigationDelegate(NavigationRequest navigation) {
    var host = Uri.parse(navigation.url).host;
    var inWhiteHost = HostInterceptUtils.isWhiteHost(host);
    _logger.fine('host $host inWhiteHost $inWhiteHost navigation $navigation');
    if (inWhiteHost) {
      return NavigationDecision.navigate;
    }
    return NavigationDecision.prevent;
  }
}
