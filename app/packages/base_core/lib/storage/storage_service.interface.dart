abstract class IStorageService {
  Future<void> setToken({required String userToken});

  Future<void> setPrivateToken({required String privateToken});

  String? getToken();

  Future<bool> setString(String key, String value);

  Future<bool> setBool(String key, bool value);

  Future<bool> setList(String key, List<String> value);

  Future<bool> setInt(String key, int value);

  String? getString(String key);

  bool getBool(String key, {bool defaultValue = false});

  bool checkKey(String key);

  List<String> getList(String key, {List<String>? defaultValue});

  int? getInt(String key);

  Future<bool> remove(String key);

  void removeToken();

  Future<bool> clear();

  String getPrivateToken();

  Future clearAll();
}
