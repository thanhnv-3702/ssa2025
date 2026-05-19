import 'package:base_core/domain/network/connectivity_checker.dart';
import 'package:base_core/domain/network/connectivity_checker_impl.dart';
import 'package:database/vn.neon.database/db/db.dart';
import 'package:database/vn.neon.database/db/db_dao.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:https/vn/sun/https/di/modul/data_source_module.dart';
import 'package:https/vn/sun/https/domain/repository/local_repository.dart';
import 'package:https/vn/sun/https/domain/repository/remote_repository.dart';
import 'package:https/vn/sun/https/domain/usecase/db_usecase.dart';
import 'package:https/vn/sun/https/domain/usecase/user_usecase.dart';
import 'package:injectable/injectable.dart';

import '../data/remote/app_api.dart';
import '../di/modul/database_module.dart';

Future<GetIt> initGetIt(
  GetIt getIt, {
  String? environment,
  EnvironmentFilter? environmentFilter,
}) async {
  final gh = GetItHelper(getIt, environment, environmentFilter);
  gh.singleton<DataSourceModule>(() => DataSourceModule());
  gh.singleton<DatabaseModule>(() => DatabaseModule());
  final dataSourceModule = gh<DataSourceModule>();
  final databaseModule = gh<DatabaseModule>();

  //network
  gh.singleton<ConnectivityChecker>(() => ConnectivityCheckerImpl());
  gh.singleton<Dio>(() => dataSourceModule.providesDio());
  //database
  await gh.factoryAsync<AppFloorDatabase>(() => databaseModule.providesCurrenciesDB(), preResolve: true);

  gh.singleton<AppAPI>(() => dataSourceModule.providesAppAPI(gh<Dio>()));
  gh.singleton<DBDao>(() => databaseModule.provideDataDao(gh<AppFloorDatabase>()));

  //repository
  gh.singleton<LocalRepository>(() => databaseModule.provideLocalRepository(gh<DBDao>()));
  gh.singleton<RemoteRepository>(() => dataSourceModule.provideRemoteRepository(gh<AppAPI>()));

  //usecase
  gh.singleton<DBUseCase>(() => DBUseCase(gh<LocalRepository>()));
  gh.singleton<UserCase>(() => UserCase(gh<RemoteRepository>()));
  return getIt;
}
