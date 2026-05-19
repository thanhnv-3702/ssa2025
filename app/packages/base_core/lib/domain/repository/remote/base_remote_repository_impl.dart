import '../../network/api.dart';
import '../base_repository.dart';

class BaseRemoteRepositoryImpl implements BaseRepository {
  final API api;

  BaseRemoteRepositoryImpl(this.api);
}
