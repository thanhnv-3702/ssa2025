import 'package:base_core/domain/network/api_impl.dart';
import 'package:https/vn/sun/https/data/remote/app_api.dart';
import 'package:https/vn/sun/https/domain/repository/remote_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class RemoteRepositoryImpl implements RemoteRepository {
  final AppAPI api;

  RemoteRepositoryImpl(this.api);

  @override
  void login(APIImpl apiImpl, {key = APIImpl.keyCommon, required Map<String, dynamic> body}) async {
    apiImpl.execApiTask(exe: () async => await api.login(body: body), key: key);
  }
}
