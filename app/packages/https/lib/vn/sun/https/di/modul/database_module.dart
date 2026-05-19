import 'package:base_core/resources.dart';
import 'package:database/vn.neon.database/db/db.dart';
import 'package:database/vn.neon.database/db/db_generated.dart';
import 'package:database/vn.neon.database/db/db_dao.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:https/vn/sun/https/data/local/repository/local_repository_impl.dart';
import 'package:https/vn/sun/https/domain/repository/local_repository.dart';

class DatabaseModule {
  Future<AppFloorDatabase> providesCurrenciesDB() {
    return $FloorAppFloorDatabase.databaseBuilder(dotenv.env[dbName] ?? dbNameError).build();
  }

  DBDao provideDataDao(AppFloorDatabase db) => db.dbDao;

  LocalRepository provideLocalRepository(DBDao currenciesDao) {
    return LocalRepositoryImpl(currenciesDao);
  }
}
