import 'package:base_core/domain/network/api_impl.dart';

abstract class RemoteRepository {
  void login(
    APIImpl apiImpl, {
    key = APIImpl.keyCommon,
    required Map<String, dynamic> body,
  });
}
