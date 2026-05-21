import 'package:base_core/presenter/base_screen_state.dart';
import 'package:base_core/storage/storage.dart';
import 'package:flutter/material.dart';
import 'package:saa2025/data/repositories/repository_provider.dart';
import 'package:saa2025/pages/kudos/kudos_models.dart';
import 'package:saa2025/pages/kudos/kudos_navigation.dart';
import 'package:saa2025/pages/kudos/sunner_profile_screen.dart';
import 'package:saa2025/pages/kudos/sunner_profile_vm.dart';
import 'package:saa2025/pages/kudos/write_kudo.dart';
import 'package:saa2025/pages/secret_box/secret_box_navigation.dart';
import 'package:saa2025/pages/utils/mixin/ui_mixin.dart';
import 'package:saa2025/pages/widgets/saa_language_sheet.dart';

/// Profile — MoMorph `hSH7L8doXB` (self) / `bEpdheM0yU` (other).
class SunnerProfileState extends StatefulWidget {
  const SunnerProfileState({super.key, required this.profile});

  final SunnerProfile profile;

  @override
  State<StatefulWidget> createState() => SunnerProfilePage();
}

class SunnerProfilePage extends BaseScreenState<SunnerProfileState, SunnerProfileVm> with UIMixin {
  String _languageCode = 'EN';
  String kudosFilter = 'sent'; // 'sent' or 'received'

  String get languageCode => _languageCode;

  SunnerProfile get profile => vm.profile ?? widget.profile;

  bool get isSelf {
    final me = RepositoryProvider.kudos.currentUser;
    return me != null && me.id == profile.id;
  }

  List<KudoItem> get kudosList {
    if (kudosFilter == 'sent') {
      return vm.kudos.where((k) => k.senderName == profile.name).toList();
    } else {
      return vm.kudos.where((k) => k.receiverName == profile.name).toList();
    }
  }

  int get sentCount => vm.kudos.where((k) => k.senderName == profile.name).length;

  int get receivedCount => vm.kudos.where((k) => k.receiverName == profile.name).length;

  bool get isLoading => vm.isLoading;

  void onFilterChange(String filter) {
    setState(() {
      kudosFilter = filter;
    });
  }

  @override
  SunnerProfileVm initViewModel() => SunnerProfileVm();

  @override
  void beforeBuild() {
    _loadLanguage();
    vm.load(widget.profile.id, fallback: widget.profile);
  }

  void _loadLanguage() {
    final saved = storage.getString(StorageKey.keySelectedLanguage.name);
    if (saved == 'en') _languageCode = 'EN';
    if (saved == 'ja') _languageCode = 'JA';
    if (saved == 'vi') _languageCode = 'VN';
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

  void onLanguageTap() {
    showSaaLanguageSheet(
      context: context,
      currentCode: _languageCode,
      onLanguageChanged: (code) => setState(() => _languageCode = code),
    );
  }

  void onOpenSecretBoxTap() {
    if (!isSelf) return;
    openSecretBox(context);
  }
}
