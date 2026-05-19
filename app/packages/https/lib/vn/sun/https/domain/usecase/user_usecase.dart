import 'package:base_core/domain/repository/resource.dart';
import 'package:base_core/domain/usecase/base_api_usecase.dart';
import 'package:https/vn/sun/https/data/dto/account_dto.dart';
import 'package:https/vn/sun/https/domain/model/account_entity.dart';
import 'package:https/vn/sun/https/domain/repository/remote_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserCase extends BaseAPIUseCase {
  final RemoteRepository remoteRepo;

  UserCase(this.remoteRepo);

  void login(Map<String, dynamic> body, Function(dynamic) callBack) {
    execAPI(
      callBack,
      () => remoteRepo.login(
        apiCall<AccountDto>(callBack, (data) => callBack(Success(AccountEntity.toEntity(data)))),
        body: body,
      ),
    );
  }

  /// SAA Google OAuth — POST `/apis/default/api/login` with `provider` + `id_token`.
  void loginWithGoogle({
    required String idToken,
    String? email,
    String? displayName,
    String? googleAccessToken,
    required Function(dynamic) callBack,
  }) {
    login(
      {
        'provider': 'google',
        'id_token': idToken,
        if (email != null) 'email': email,
        if (displayName != null) 'display_name': displayName,
        if (googleAccessToken != null) 'access_token': googleAccessToken,
      },
      callBack,
    );
  }
}
