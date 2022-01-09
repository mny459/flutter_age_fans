import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_age_fans/core/utils/fps_monitor_utils.dart';
import 'package:logging/logging.dart';
import 'package:flutter_age_fans/core/services/connectivity/connectivity_service.dart';
import 'package:flutter_age_fans/core/services/stoppable_service.dart';
import 'package:flutter_age_fans/locator.dart';

/// A manager to start/stop [StoppableService]s when the app goes/returns into/from the background
class LifeCycleManager extends StatefulWidget {
  final Widget? child;

  const LifeCycleManager({Key? key, this.child}) : super(key: key);

  @override
  _LifeCycleManagerState createState() => _LifeCycleManagerState();
}

class _LifeCycleManagerState extends State<LifeCycleManager>
    with WidgetsBindingObserver {
  final _log = Logger('LifeCycleManager');
  final servicesToManage = <StoppableService?>[
    locator<ConnectivityService>(),
  ];

  @override
  Widget build(BuildContext context) {
    return widget.child!;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    SchedulerBinding.instance?.addTimingsCallback(FpsMonitorUtils.onReportTimings);
  }

  @override
  void dispose() {
    SchedulerBinding.instance?.removeTimingsCallback(FpsMonitorUtils.onReportTimings);
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    _log.fine('App life cycle change to $state');
    servicesToManage.forEach((service) {
      if (state == AppLifecycleState.resumed) {
        service!.start();
      } else {
        service!.stop();
      }
    });
  }
}
