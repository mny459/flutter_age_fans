import 'dart:async';

import 'package:flutter_age_fans/generated/l10n.dart';
import 'package:logging/logging.dart';
import 'package:flutter_age_fans/core/models/alert_request/alert_request.dart';
import 'package:flutter_age_fans/core/models/alert_request/confirm_alert_request.dart';
import 'package:flutter_age_fans/core/models/alert_response/alert_response.dart';
import 'package:flutter_age_fans/core/services/dialog/dialog_service.dart';
import 'package:flutter_age_fans/core/services/navigation/navigation_service.dart';
import 'package:flutter_age_fans/locator.dart';

/// A service that is responsible for returning future dialogs
class DialogServiceImpl implements DialogService {
  final _log = Logger('DialogServiceImpl');

  Completer<AlertResponse>? _dialogCompleter;

  @override
  Future<AlertResponse> showDialog(AlertRequest request) {
    _dialogCompleter = Completer<AlertResponse>();

    if (request is ConfirmAlertRequest) {
      _log.finer('showConfirmAlert');
      _showConfirmAlert(request);
    }

    return _dialogCompleter!.future;
  }

  @override
  void completeDialog(AlertResponse response) {
    locator<NavigationService>().pop();
    _dialogCompleter!.complete(response);
    _dialogCompleter = null;
  }

  void _showConfirmAlert(ConfirmAlertRequest request) {
    final _navigationService = locator<NavigationService>();
    var context = _navigationService.navigatorKey.currentContext!;
    final local = S.of(context);

    // showPlatformDialog(
    //   context: context,
    //   builder: (context) => ConfirmDialog(
    //     title: local!.translate(request.title)!,
    //     description: local.translate(request.description)!,
    //     buttonTitle: local.translate(request.buttonTitle),
    //     onConfirmed: () {
    //       if (!_dialogCompleter!.isCompleted) {
    //         completeDialog(ConfirmAlertResponse((a) => a..confirmed = true));
    //       }
    //     },
    //     onDenied: () {
    //       if (!_dialogCompleter!.isCompleted) {
    //         completeDialog(ConfirmAlertResponse((a) => a..confirmed = false));
    //       }
    //     },
    //   ),
    // );
  }
}
