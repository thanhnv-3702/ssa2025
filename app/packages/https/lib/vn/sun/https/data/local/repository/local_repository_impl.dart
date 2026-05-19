import 'dart:convert';

import 'package:base_core/common/config.dart';
import 'package:database/vn.neon.database/db/db_dao.dart';
import 'package:database/vn.neon.database/db/entity/db_entity.dart';
import 'package:https/vn/sun/https/data/dto/saved_data_dto.dart';
import 'package:https/vn/sun/https/domain/repository/local_repository.dart';

class LocalRepositoryImpl implements LocalRepository {
  final DBDao dbDao;

  LocalRepositoryImpl(this.dbDao);

  Future<SavedDataDto?> get() async {
    final data = await dbDao.getQuestions();
    if (data == null) return null;
    final rs = SavedDataDto.fromJson(await jsonToObject(data));
    return Future(() => rs);
  }

  Future<void> addData(SavedDataDto q) {
    throw dbDao.addData(DBEntity('/savedData/${q.key?.replaceAll(' ', '')}', json.encode(q)));
  }
}
