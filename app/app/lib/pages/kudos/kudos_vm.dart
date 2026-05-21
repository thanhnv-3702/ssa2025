import 'package:base_core/common/config.dart';
import 'package:base_core/presenter/viewmodel/base_vm.dart';
import 'package:saa2025/data/models/kudos_hub_data.dart';
import 'package:saa2025/data/repositories/repository_provider.dart';
import 'package:saa2025/pages/kudos/kudos_mock_data.dart';
import 'package:saa2025/pages/kudos/kudos_models.dart';
import 'package:saa2025/pages/utils/mixin/vm_mixin.dart';

class KudosVm extends AppBaseViewModel with ViewModelMixin {
  final _repo = RepositoryProvider.kudos;

  KudosHubData? hubData;
  bool isHubLoading = false;
  String? loadError;

  KudosStats get stats => hubData?.stats ?? KudosMockData.stats;

  List<KudoItem> get highlights => hubData?.highlights ?? KudosMockData.highlights;

  List<SpotlightEntry> get spotlight => hubData?.spotlight ?? KudosMockData.spotlight;

  List<SpotlightActivity> get spotlightActivities =>
      hubData?.spotlightActivities.isNotEmpty == true
          ? hubData!.spotlightActivities
          : KudosMockData.spotlightActivities;

  List<KudoItem> get allKudos => hubData?.allKudos ?? KudosMockData.allKudos;

  List<String> get periodFilters =>
      hubData?.periodFilters.isNotEmpty == true ? hubData!.periodFilters : KudosMockData.periodFilters;

  List<String> get hashtagFilters =>
      hubData?.hashtagFilters.isNotEmpty == true ? hubData!.hashtagFilters : KudosMockData.hashtagFilters;

  List<String> get departmentFilters =>
      hubData?.departmentFilters.isNotEmpty == true ? hubData!.departmentFilters : KudosMockData.departmentFilters;

  Future<void> loadHub({
    String? period,
    String? hashtag,
    String? department,
  }) async {
    isHubLoading = true;
    loadError = null;
    notifyListeners();
    try {
      hubData = await _repo.fetchHub(
        period: period,
        hashtag: hashtag,
        department: department,
      );
    } catch (e) {
      loadError = e.toString();
      logger.e('KudosVm.loadHub: $e');
    } finally {
      isHubLoading = false;
      notifyListeners();
    }
  }
}
