import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:flutter_age_fans/core/models/snack_bar_request/confirm_snack_bar_request.dart';
import 'package:flutter_age_fans/core/models/snack_bar_request/snack_bar_request.dart';
import 'package:flutter_age_fans/core/models/snack_bar_response/snack_bar_response.dart';
import 'package:flutter_age_fans/core/services/navigation/navigation_service.dart';
import 'package:flutter_age_fans/core/services/snackbar/snack_bar_service.dart';
import 'package:flutter_age_fans/locator.dart';

/// A service that is responsible for returning future snackbar
class SnackBarServiceImpl implements SnackBarService {
  final _log = Logger('SnackBarServiceImpl');

  Completer<SnackBarResponse>? _snackBarCompleter;
  @override
  Future<SnackBarResponse> showSnackBar(SnackBarRequest request) {
    _snackBarCompleter = Completer<SnackBarResponse>();

    if (request is ConfirmSnackBarRequest) {
      _log.finer('showConfirmSnackBar');
      _showConfirmSnackBar(request);
    }

    return _snackBarCompleter!.future;
  }

  @override
  void completeSnackBar(SnackBarResponse response) {
    locator<NavigationService>().pop();
    _snackBarCompleter!.complete(response);
    _snackBarCompleter = null;
  }

  void _showConfirmSnackBar(ConfirmSnackBarRequest request) {
    final _navigationService = locator<NavigationService>();
    var context = _navigationService.navigatorKey.currentContext!;
    final style = TextStyle(color: Theme.of(context).accentColor);

    // GetBar(
    //   message: local.translate(request.message),
    //   margin: const EdgeInsets.all(8),
    //   dismissDirection: SnackDismissDirection.HORIZONTAL,
    //   borderRadius: 8,
    //   mainButton: FlatButton(
    //     onPressed: () {
    //       completeSnackBar(ConfirmSnackBarResponse((a) => a..confirmed = true));
    //       if (request.onPressed != null) {
    //         request.onPressed();
    //       }
    //     },
    //     child: Text(
    //       local.translate(request.buttonText),
    //       style: style,
    //     ),
    //   ),
    // ).show();
  }
}
