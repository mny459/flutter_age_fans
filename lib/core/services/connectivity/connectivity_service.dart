import 'package:flutter_age_fans/core/enums/connectivity_status.dart';
import 'package:flutter_age_fans/core/services/stoppable_service.dart';

abstract class ConnectivityService implements StoppableService {
  Stream<ConnectivityStatus> get connectivity$;

  Future<bool> get isConnected;
}
