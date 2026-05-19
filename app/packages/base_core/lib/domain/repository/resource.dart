import '../../resources.dart';

class Resource<T> {
  T? data;
  dynamic error;
  int? code;
  String? message;
  String? key;

  Resource(code);
}

class Loading<T> extends Resource<T> {
  Loading() : super(codeLoading);
}

class Notify<String> extends Resource<String> {
  Notify(msg) : super(codeNotify) {
    message = msg;
  }
}

class Success<T> extends Resource<T> {
  Success(T? data) : super(codeOK) {
    this.data = data;
  }
}

class Failed<T, E> extends Resource<T> {
  Failed(E error, int code, {String? key}) : super(code) {
    this.error = error;
    message = error.toString();
    this.key = key;
  }
}

class Exception<T, E> extends Resource<T> {
  Exception(E error) : super(codeException) {
    this.error = error;
    message = error.toString();
  }
}
