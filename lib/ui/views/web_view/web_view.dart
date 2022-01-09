import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'web_view_model.dart';

class WanWeb extends StatelessWidget {
  final _logger = Logger('WanWeb');
  final String? url;

  WanWeb({Key? key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WebViewModel>.nonReactive(
      viewModelBuilder: () => WebViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                Selector<WebViewModel, double>(
                    builder: (_, progress, child) {
                      return Visibility(
                          visible: progress != 1.0,
                          child:
                              LinearProgressIndicator(value: model.progress));
                    },
                    selector: (_, model) => model.progress),
                Expanded(
                  child: WebView(
                    initialUrl: url,
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (controller) {
                      model.initWebViewController(controller);
                    },
                    onProgress: (progress) {
                      model.upgradeProgress(progress);
                    },
                    navigationDelegate: (navigation) {
                      return model.navigationDelegate(navigation);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
