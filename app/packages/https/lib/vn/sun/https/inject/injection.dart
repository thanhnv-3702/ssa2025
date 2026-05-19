import 'package:get_it/get_it.dart';

import 'injection_config.dart';

final getIt = GetIt.instance;
Future<void> configureDependencies(String env) async {
  await initGetIt(getIt);
}
