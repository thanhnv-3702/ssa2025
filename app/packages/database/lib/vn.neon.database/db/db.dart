import 'package:floor/floor.dart';

import 'db_dao.dart';
import 'entity/db_entity.dart';

@Database(version: 1, entities: [DBEntity])
abstract class AppFloorDatabase extends FloorDatabase {
  DBDao get dbDao;
}
