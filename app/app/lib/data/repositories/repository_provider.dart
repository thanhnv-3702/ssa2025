import 'package:saa2025/config/api_config.dart';
import 'package:saa2025/data/repositories/awards_repository.dart';
import 'package:saa2025/data/repositories/awards_repository_mock.dart';
import 'package:saa2025/data/repositories/awards_repository_remote.dart';
import 'package:saa2025/data/repositories/kudos_repository.dart';
import 'package:saa2025/data/repositories/kudos_repository_mock.dart';
import 'package:saa2025/data/repositories/kudos_repository_remote.dart';
import 'package:saa2025/data/repositories/notifications_repository.dart';
import 'package:saa2025/data/repositories/notifications_repository_mock.dart';
import 'package:saa2025/data/repositories/notifications_repository_remote.dart';

/// Central switch mock ↔ remote for SAA content APIs.
class RepositoryProvider {
  RepositoryProvider._();

  static final KudosRepository kudos =
      ApiConfig.useMockApi ? KudosRepositoryMock() : KudosRepositoryRemote();

  static final AwardsRepository awards =
      ApiConfig.useMockApi ? AwardsRepositoryMock() : AwardsRepositoryRemote();

  static final NotificationsRepository notifications = ApiConfig.useMockApi
      ? NotificationsRepositoryMock()
      : NotificationsRepositoryRemote();

  /// Mock repo instance when API mock is on (mark-read updates badge source).
  static NotificationsRepositoryMock? get notificationsMock =>
      notifications is NotificationsRepositoryMock ? notifications as NotificationsRepositoryMock : null;
}
