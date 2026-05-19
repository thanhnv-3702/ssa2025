import 'package:floor/floor.dart';

import 'entity/db_entity.dart';

@dao
abstract class DBDao {
  @Query('SELECT data FROM DBEntity')
  Future<dynamic> getQuestions();

  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<void> addData(DBEntity item);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> replaceData(DBEntity item);
}
