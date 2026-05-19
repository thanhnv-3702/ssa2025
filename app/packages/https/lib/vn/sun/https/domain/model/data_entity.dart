import 'msg_entity.dart';

abstract class DataEntity<T> extends MsgEntity {
  T? data;

  DataEntity(this.data, super.success, super.msg, super.code);
}
