import 'package:base_core/presenter/base_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:saa2025/data/repositories/repository_provider.dart';
import 'package:saa2025/pages/kudos/kudos_models.dart';
import 'package:saa2025/pages/kudos/kudos_navigation.dart';
import 'package:saa2025/pages/kudos/sunner_profile_screen.dart';
import 'package:saa2025/pages/kudos/sunner_profile_vm.dart';
import 'package:saa2025/pages/kudos/write_kudo.dart';
import 'package:saa2025/pages/utils/mixin/ui_mixin.dart';

/// Profile — MoMorph `hSH7L8doXB` (self) / `bEpdheM0yU` (other).
class SunnerProfileState extends StatefulWidget {
  const SunnerProfileState({super.key, required this.profile});

  final SunnerProfile profile;

  @override
  State<StatefulWidget> createState() => SunnerProfilePage();
}

class SunnerProfilePage extends BaseScreenState<SunnerProfileState, SunnerProfileVm> with UIMixin {
  SunnerProfile get profile => vm.profile ?? widget.profile;

  bool get isSelf {
    final me = RepositoryProvider.kudos.currentUser;
    return me != null && me.id == profile.id;
  }

  List<KudoItem> get kudosList => vm.kudos;

  bool get isLoading => vm.isLoading;

  @override
  SunnerProfileVm initViewModel() => SunnerProfileVm();

  @override
  void beforeBuild() {
    vm.load(widget.profile.id, fallback: widget.profile);
  }

  @override
  Widget initWidget(BuildContext context) => SunnerProfileScreen(this, context).screen();

  void onBack() => Navigator.of(context).pop();

  void onSendKudoTap() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => WriteKudoState(initialRecipient: profile),
      ),
    );
  }

  void onKudoTap(KudoItem item) => openKudoDetail(context, item);
}
