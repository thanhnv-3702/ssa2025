import 'package:base_core/presenter/viewmodel/base_vm.dart';
import 'package:base_core/storage/storage.dart';
import 'package:saa2025/pages/utils/mixin/vm_mixin.dart';

class SetupNotificationVm extends AppBaseViewModel with ViewModelMixin {
  /// Get current notification enabled state
  bool getNotificationEnabled() {
    return storageService.getBool(StorageKey.keyNotificationEnabled.name, defaultValue: false);
  }

  /// Set notification enabled state
  Future<void> updateNotificationEnabled({
    required Function(bool) onSuccess,
    required Function(bool) onLoading,
    required Function(String) onToast,
    required bool enabled,
  }) async {
    storageService.setBool(StorageKey.keyNotificationEnabled.name, enabled);
  }
}
