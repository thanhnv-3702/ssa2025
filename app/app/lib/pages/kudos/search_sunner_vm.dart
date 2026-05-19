import 'package:base_core/presenter/viewmodel/base_vm.dart';
import 'package:saa2025/data/repositories/repository_provider.dart';
import 'package:saa2025/pages/kudos/kudos_mock_data.dart';
import 'package:saa2025/pages/kudos/kudos_models.dart';
import 'package:saa2025/pages/utils/mixin/vm_mixin.dart';

class SearchSunnerVm extends AppBaseViewModel with ViewModelMixin {
  final _repo = RepositoryProvider.kudos;

  Future<List<SunnerProfile>> search(String query) async {
    if (query.trim().isEmpty) {
      return List.from(KudosMockData.sunners);
    }
    return _repo.searchSunners(query);
  }
}
