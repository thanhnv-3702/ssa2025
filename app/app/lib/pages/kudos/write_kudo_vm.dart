import 'package:base_core/presenter/viewmodel/base_vm.dart';
import 'package:saa2025/data/repositories/repository_provider.dart';
import 'package:saa2025/pages/kudos/kudos_models.dart';
import 'package:saa2025/pages/utils/mixin/vm_mixin.dart';
import 'package:saa2025/pages/utils/utils.dart';

class WriteKudoVm extends AppBaseViewModel with ViewModelMixin {
  bool isSubmitting = false;

  Future<bool> submitKudo(KudoDraft draft) async {
    if (isSubmitting) return false;
    isSubmitting = true;
    notifyListeners();
    try {
      final result = await RepositoryProvider.kudos.submitKudo(draft);
      if (!result.success) {
        Utils.showToast(result.message ?? 'Gửi Kudos thất bại');
        return false;
      }
      return true;
    } catch (e) {
      Utils.showToast('Gửi Kudos thất bại. Vui lòng thử lại.');
      return false;
    } finally {
      isSubmitting = false;
      notifyListeners();
    }
  }
}
