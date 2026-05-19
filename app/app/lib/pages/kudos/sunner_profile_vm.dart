import 'package:base_core/presenter/viewmodel/base_vm.dart';
import 'package:saa2025/data/repositories/repository_provider.dart';
import 'package:saa2025/pages/kudos/kudos_models.dart';
import 'package:saa2025/pages/utils/mixin/vm_mixin.dart';

class SunnerProfileVm extends AppBaseViewModel with ViewModelMixin {
  final _repo = RepositoryProvider.kudos;

  bool isLoading = true;
  SunnerProfile? profile;
  List<KudoItem> kudos = [];

  Future<void> load(String sunnerId, {SunnerProfile? fallback}) async {
    isLoading = true;
    notifyListeners();
    try {
      final id = sunnerId.isEmpty ? 'me' : sunnerId;
      profile = await _repo.fetchSunnerProfile(id) ?? fallback;
      kudos = await _repo.kudosForSunner(profile?.id ?? id);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
