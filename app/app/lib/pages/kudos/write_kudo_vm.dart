import 'package:base_core/presenter/viewmodel/base_vm.dart';
import 'package:saa2025/data/repositories/repository_provider.dart';
import 'package:saa2025/generated/app_localizations.dart';
import 'package:saa2025/pages/kudos/kudos_models.dart';
import 'package:saa2025/pages/utils/mixin/vm_mixin.dart';
import 'package:saa2025/pages/utils/utils.dart';
import 'package:stacked_services/stacked_services.dart';

class WriteKudoVm extends AppBaseViewModel with ViewModelMixin {
  bool isSubmitting = false;

  Future<bool> submitKudo(KudoDraft draft) async {
    if (isSubmitting) return false;
    isSubmitting = true;
    notifyListeners();
    try {
      final result = await RepositoryProvider.kudos.submitKudo(draft);
      if (!result.success) {
        final tr = _tr();
        Utils.showToast(result.message ?? tr?.writeKudoSendFailedToast ?? 'Failed to send Kudos');
        return false;
      }
      return true;
    } catch (e) {
      final tr = _tr();
      Utils.showToast(tr?.writeKudoSendFailedRetryToast ?? 'Failed to send Kudos. Please try again.');
      return false;
    } finally {
      isSubmitting = false;
      notifyListeners();
    }
  }

  AppLocalizations? _tr() {
    final ctx = StackedService.navigatorKey?.currentContext;
    return ctx != null ? AppLocalizations.of(ctx) : null;
  }
}
