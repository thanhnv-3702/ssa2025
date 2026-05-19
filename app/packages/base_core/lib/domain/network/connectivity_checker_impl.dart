import 'dart:async';
import 'dart:io';

import 'package:base_core/common/config.dart';
import 'package:base_core/res/extension.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:stacked/stacked.dart';

import 'connectivity_checker.dart';

class ConnectivityCheckerImpl with ListenableServiceMixin implements ConnectivityChecker {
  static const String tag = 'ConnectivityChecker';

  static final List<InternetAddress> _chinaDns = [
    InternetAddress('114.114.114.114'), // China Telecom – fastest in mainland
    InternetAddress('223.5.5.5'), // Alibaba DNS
    InternetAddress('119.29.29.29'), // Tencent DNS
  ];

  static final List<InternetAddress> _globalDns = [
    InternetAddress('8.8.8.8'), // Google
    InternetAddress('1.1.1.1'), // Cloudflare
  ];

  static const List<String> _httpEndpoints = [
    'https://www.baidu.com/hws', // China – always works
    'https://clients3.google.com/generate_204',
    'https://connectivitycheck.gstatic.com/generate_204',
  ];

  /// Returns true if the device has real internet access
  @override
  Future<bool> hasInternet() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    logger.d('[$tag] Network connectivityResult is fine ? $connectivityResult');
    if (connectivityResult.firstWhereOrNull(
          (v) =>
              v == ConnectivityResult.other ||
              v == ConnectivityResult.mobile ||
              v == ConnectivityResult.wifi ||
              v == ConnectivityResult.vpn,
        ) ==
        null) {
      logger.d('[$tag] Network connectivityResult is fine ? false');
      return false;
    }
    if (await _tryDnsSockets(_chinaDns)) {
      logger.d('[$tag] Network _tryDnsSockets _chinaDns is fine ? true');
      return true;
    }
    if (await _tryDnsSockets(_globalDns)) {
      logger.d('[$tag] Network _tryDnsSockets _globalDns is fine ? true');
      return true;
    }
    return await _tryHttpEndpoints();
  }

  Future<bool> _tryDnsSockets(List<InternetAddress> addresses) async {
    for (final addr in addresses) {
      try {
        final socket = await Socket.connect(addr, 53, timeout: const Duration(seconds: 3));
        socket.destroy();
        return true;
      } catch (_) {
        continue;
      }
    }
    return false;
  }

  Future<bool> _tryHttpEndpoints() async {
    final client = HttpClient()
      ..connectionTimeout = const Duration(seconds: 5)
      ..idleTimeout = const Duration(seconds: 5);

    for (final url in _httpEndpoints) {
      try {
        final req = await client.headUrl(Uri.parse(url));
        final resp = await req.close();
        if (resp.statusCode ~/ 100 == 2 || resp.statusCode == 204) {
          client.close();
          logger.d('[$tag] Network is fine ? true');
          return true;
        }
      } catch (_) {
        continue;
      }
    }
    client.close();
    logger.d('[$tag] Network _tryHttpEndpoints is fine ? false');
    return false;
  }
}
