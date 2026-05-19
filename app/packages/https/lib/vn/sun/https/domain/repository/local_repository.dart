import 'package:base_core/domain/repository/base_repository.dart';
import 'package:https/vn/sun/https/data/dto/saved_data_dto.dart';

abstract class LocalRepository extends BaseRepository{
  void addData(SavedDataDto q);
}
