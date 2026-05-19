import 'package:base_core/presenter/viewmodel/base_vm.dart';
import 'package:saa2025/data/repositories/repository_provider.dart';
import 'package:saa2025/pages/kudos/kudos_mock_data.dart';
import 'package:saa2025/pages/kudos/kudos_models.dart';
import 'package:saa2025/pages/utils/mixin/vm_mixin.dart';

class KudosAllVm extends AppBaseViewModel with ViewModelMixin {
  List<KudoItem> items = List.from(KudosMockData.allKudos);

  Future<void> load() async {
    final hub = await RepositoryProvider.kudos.fetchHub();
    items = hub.allKudos;
    notifyListeners();
  }
}
