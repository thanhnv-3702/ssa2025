import 'dart:convert';

import 'base_dto.dart';

AccountDto accountDtoFromMap(String str) => AccountDto.fromJson(json.decode(str));

String accountDtoToMap(AccountDto data) => json.encode(data.toJson());

/// Account data model (inner data structure)
class AccountData {
  final String? accessToken;
  final String? tokenType;
  final int? expiresIn;
  final int? userId;
  final String? userRole;
  final String? username;
  final String? refreshToken; // Optional, may not be in response
  final String? registrationKey;
  final String? email;
  final String? displayName;

  AccountData({
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
  });

  AccountData copyWith({
    String? accessToken,
    String? tokenType,
    int? expiresIn,
    int? userId,
    String? userRole,
    String? username,
    String? refreshToken,
    String? registrationKey,
    String? email,
    String? displayName,
  }) =>
      AccountData(
        accessToken: accessToken ?? this.accessToken,
        tokenType: tokenType ?? this.tokenType,
        expiresIn: expiresIn ?? this.expiresIn,
        userId: userId ?? this.userId,
        userRole: userRole ?? this.userRole,
        username: username ?? this.username,
        refreshToken: refreshToken ?? this.refreshToken,
        registrationKey: registrationKey ?? this.registrationKey,
        email: email ?? this.email,
        displayName: displayName ?? this.displayName,
      );

  factory AccountData.fromJson(Map<String, dynamic> json) => AccountData(
        accessToken: json['access_token'],
        tokenType: json['token_type'],
        expiresIn: json['expires_in'],
        userId: json['user_id'],
        userRole: json['user_role'],
        username: json['username'],
        refreshToken: json['refresh_token'], // Optional
        registrationKey: json['registration_key'], // Optional
        email: json['email'],
        displayName: json['display_name'] ?? json['displayName'],
      );

  Map<String, dynamic> toJson() => {
        'access_token': accessToken,
        'token_type': tokenType,
        'expires_in': expiresIn,
        'user_id': userId,
        'user_role': userRole,
        'username': username,
        'registration_key': registrationKey,
        if (refreshToken != null) 'refresh_token': refreshToken,
        if (email != null) 'email': email,
        if (displayName != null) 'display_name': displayName,
      };
}

/// Account DTO with BaseDto structure
///
/// Response structure:
/// {
///   "code": "200",
///   "message": "Success",
///   "message_id": [],
///   "data": {
///     "access_token": "...",
///     "token_type": "...",
///     ...
///   }
/// }
class AccountDto extends BaseDto<AccountData> {
  AccountDto({
    super.code,
    super.message,
    required super.messageId,
    super.data,
  });

  /// Factory constructor from full API response
  ///
  /// Handles two response formats:
  /// 1. Success case (only data):
  ///    {
  ///      "data": {
  ///        "access_token": "...",
  ///        ...
  ///      }
  ///    }
  ///
  /// 2. Error case (with code, message, message_id):
  ///    {
  ///      "code": "400",
  ///      "message": "ABC",
  ///      "message_id": ["error_01"],
  ///      "data": "{}"
  ///    }
  factory AccountDto.fromJson(Map<String, dynamic> jsonTxt) {
    // Check if this is a success case (only has data, no code/message/message_id)
    final hasErrorFields =
        jsonTxt.containsKey('code') || jsonTxt.containsKey('message') || jsonTxt.containsKey('message_id');

    // Parse data field - can be Map or String (JSON string)
    AccountData? accountData;
    if (jsonTxt['data'] != null) {
      if (jsonTxt['data'] is Map) {
        accountData = AccountData.fromJson(jsonTxt['data'] as Map<String, dynamic>);
      } else if (jsonTxt['data'] is String) {
        final dataString = jsonTxt['data'] as String;
        // Skip empty JSON strings like "{}"
        if (dataString.isNotEmpty && dataString != '{}') {
          try {
            final dataMap = json.decode(dataString) as Map<String, dynamic>;
            accountData = AccountData.fromJson(dataMap);
          } catch (e) {
            // If parsing fails, accountData remains null
          }
        }
      }
    }

    // If success case (no error fields), return with default success values
    if (!hasErrorFields) {
      return AccountDto(
        code: '200',
        message: 'Success',
        messageId: [],
        data: accountData,
      );
    }

    // Error case - parse error fields
    return AccountDto(
      code: BaseDto.parseCode(jsonTxt),
      message: BaseDto.parseMessage(jsonTxt),
      messageId: BaseDto.parseMessageId(jsonTxt),
      data: accountData,
    );
  }

  /// Factory constructor from data only (for backward compatibility)
  /// This is useful when you already have the data object
  factory AccountDto.fromData(AccountData data) {
    return AccountDto(
      code: '200',
      message: 'Success',
      messageId: [],
      data: data,
    );
  }

  /// Legacy method: Create AccountDto from old format (data only)
  /// @deprecated Use fromJson instead
  factory AccountDto.fromMap(Map<String, dynamic> json) {
    // If it looks like old format (has access_token directly), parse as data
    if (json.containsKey('access_token') || json.containsKey('accessToken')) {
      return AccountDto.fromData(AccountData.fromJson(json));
    }
    // Otherwise, treat as full response
    return AccountDto.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    final map = super.toJson();
    // Override data serialization
    if (data != null) {
      map['data'] = data!.toJson();
    }
    return map;
  }

  /// Legacy method: Convert to map (returns data only)
  /// @deprecated Use toJson instead
  Map<String, dynamic> toMap() {
    return data?.toJson() ?? {};
  }

  /// Convenience getters to access data fields directly
  String? get accessToken => data?.accessToken;

  String? get tokenType => data?.tokenType;

  int? get expiresIn => data?.expiresIn;

  int? get userId => data?.userId;

  String? get userRole => data?.userRole;

  String? get username => data?.username;

  String? get refreshToken => data?.refreshToken;

  String? get registrationKey => data?.registrationKey;

  /// Copy with method
  AccountDto copyWith({
    String? code,
    String? message,
    List<String>? messageId,
    AccountData? data,
  }) {
    return AccountDto(
      code: code ?? this.code,
      message: message ?? this.message,
      messageId: messageId ?? this.messageId,
      data: data ?? this.data,
    );
  }
}
