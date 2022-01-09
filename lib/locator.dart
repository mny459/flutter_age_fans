import 'package:flutter_age_fans/core/data_sources/age_fans/age_fans_remote_data_source.dart';
import 'package:flutter_age_fans/core/repositories/age_fans_repository/age_fans_repository.dart';
import 'package:flutter_age_fans/core/repositories/age_fans_repository/age_fans_repository_impl.dart';
import 'package:flutter_age_fans/core/services/cache/cache_service.dart';
import 'package:flutter_age_fans/core/services/cache/cache_service_impl.dart';
import 'package:flutter_age_fans/core/services/http/age_dio_adapter.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_age_fans/core/services/connectivity/connectivity_service.dart';
import 'package:flutter_age_fans/core/services/connectivity/connectivity_service_impl.dart';
import 'package:flutter_age_fans/core/services/dialog/dialog_service.dart';
import 'package:flutter_age_fans/core/services/dialog/dialog_service_impl.dart';
import 'package:flutter_age_fans/core/services/key_storage/key_storage_service.dart';
import 'package:flutter_age_fans/core/services/key_storage/key_storage_service_impl.dart';
import 'package:flutter_age_fans/core/services/navigation/navigation_service.dart';
import 'package:flutter_age_fans/core/services/navigation/navigation_service_impl.dart';
import 'package:flutter_age_fans/core/services/snackbar/snack_bar_service.dart';
import 'package:flutter_age_fans/core/services/snackbar/snack_bar_service_impl.dart';
import 'package:j_net/j_net.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  JNet.getInstance().setAdapter(AgeDioAdapter());

  locator.registerLazySingleton<NavigationService>(
    () => NavigationServiceImpl(),
  );
  locator.registerLazySingleton<ConnectivityService>(
    () => ConnectivityServiceImpl(),
  );
  locator.registerLazySingleton<DialogService>(() => DialogServiceImpl());
  locator.registerLazySingleton<SnackBarService>(() => SnackBarServiceImpl());
  locator.registerLazySingleton<CacheService>(() => CacheServiceImpl());

  locator
      .registerLazySingleton<AgeFansRepository>(() => AgeFansRepositoryImpl());
  locator.registerLazySingleton<AgeFansRemoteDataSource>(
      () => AgeFansRemoteDataSourceImpl());

  await _setupSharedPreferences();
}

Future<void> _setupSharedPreferences() async {
  final instance = await KeyStorageServiceImpl.getInstance();
  locator.registerLazySingleton<KeyStorageService>(() => instance!);
}
