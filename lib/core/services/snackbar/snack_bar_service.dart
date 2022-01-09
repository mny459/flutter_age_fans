import 'package:flutter_age_fans/core/models/snack_bar_request/snack_bar_request.dart';
import 'package:flutter_age_fans/core/models/snack_bar_response/snack_bar_response.dart';

abstract class SnackBarService {
  Future<SnackBarResponse> showSnackBar(SnackBarRequest alertRequest);

  void completeSnackBar(SnackBarResponse response);
}
