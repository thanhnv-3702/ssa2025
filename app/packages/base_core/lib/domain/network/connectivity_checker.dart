import 'dart:async';

abstract class ConnectivityChecker {
  Future<bool> hasInternet();
}
