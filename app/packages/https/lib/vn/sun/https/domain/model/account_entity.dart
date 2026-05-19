import 'package:https/vn/sun/https/data/dto/account_dto.dart';

class AccountEntity {
  final String? accessToken;
  final String? tokenType;
  final int? expiresIn;
  final int? userId;
  final String? userRole;
  final String? username;
  final String? refreshToken;
  final String? registrationKey;
  final String? email;
  final String? displayName;

  AccountEntity(
    this.accessToken,
    this.tokenType,
    this.expiresIn,
    this.userId,
    this.userRole,
    this.username,
    this.refreshToken,
    this.registrationKey,
    this.email,
    this.displayName,
  );

  static AccountEntity toEntity(AccountDto? dto) {
    return AccountEntity(
      dto?.accessToken,
      dto?.tokenType,
      dto?.expiresIn,
      dto?.userId,
      dto?.userRole,
      dto?.username,
      dto?.refreshToken,
      dto?.registrationKey,
      dto?.data?.email,
      dto?.data?.displayName,
    );
  }

  Map<String, dynamic> toMap() => {
        'access_token': accessToken,
        'token_type': tokenType,
        'expires_in': expiresIn,
        'user_id': userId,
        'user_role': userRole,
        'username': username,
        'registration_key': registrationKey,
        if (refreshToken != null) 'refresh_token': refreshToken,
      };
}
