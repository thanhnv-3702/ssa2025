import 'package:floor/floor.dart';

@entity
class DBEntity {
  @primaryKey
  final String path;
  final String data;

  DBEntity(this.path, this.data);

  Map<String, dynamic> toMap() {
    return {
      'path': path,
      'data': data,
    };
  }

  static List<DBEntity> copyFrom(Map<String, String> map) {
    return map.entries.map((entry) => DBEntity(entry.key, entry.value)).toList();
  }

  @override
  String toString() {
    return 'sun.ntity{path: $path, name: $data}';
  }
}
//QuotesEntity
