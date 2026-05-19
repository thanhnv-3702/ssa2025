import 'package:base_core/common/config.dart';
import 'package:base_core/presenter/viewmodel/base_vm.dart';
import 'package:saa2025/data/repositories/repository_provider.dart';
import 'package:saa2025/pages/awards/awards_mock_data.dart';
import 'package:saa2025/pages/awards/awards_models.dart';
import 'package:saa2025/pages/utils/mixin/vm_mixin.dart';

class AwardsVm extends AppBaseViewModel with ViewModelMixin {
  final _repo = RepositoryProvider.awards;

  List<AwardItem> awards = List.from(AwardsMockData.awards);
  bool isLoading = false;

  Future<void> loadAwards() async {
    isLoading = true;
    notifyListeners();
    try {
      awards = await _repo.fetchAwards();
    } catch (e) {
      logger.e('AwardsVm.loadAwards: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
