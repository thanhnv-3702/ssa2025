import 'package:base_core/presenter/base_screen_state.dart';
import 'package:base_core/storage/storage.dart';
import 'package:flutter/material.dart';
import 'package:saa2025/pages/app_pages.router.dart';
import 'package:saa2025/pages/kudos/kudos_all.dart';
import 'package:saa2025/pages/kudos/kudos_models.dart';
import 'package:saa2025/pages/kudos/kudos_navigation.dart';
import 'package:saa2025/pages/kudos/kudos_screen.dart';
import 'package:saa2025/pages/kudos/kudos_vm.dart';
import 'package:saa2025/pages/kudos/search_sunner.dart';
import 'package:saa2025/pages/kudos/widgets/kudos_option_sheet.dart';
import 'package:saa2025/pages/kudos/write_kudo.dart';
import 'package:saa2025/pages/utils/extension.dart';
import 'package:saa2025/pages/utils/mixin/notification_badge_mixin.dart';
import 'package:saa2025/pages/utils/mixin/ui_mixin.dart';
import 'package:saa2025/pages/widgets/saa_language_sheet.dart';

class KudosState extends StatefulWidget {
  const KudosState({super.key});

  @override
  State<StatefulWidget> createState() => Kudos();
}

class Kudos extends BaseScreenState<KudosState, KudosVm> with UIMixin, NotificationBadgeMixin {
  String _languageCode = 'EN';
  int _highlightPage = 0;
  late String _filterPeriod;
  late String _filterHashtag;
  late String _filterDepartment;

  final PageController highlightController = PageController(viewportFraction: 0.88);
  final GlobalKey hashtagButtonKey = GlobalKey();
  final GlobalKey departmentButtonKey = GlobalKey();

  String get languageCode => _languageCode;

  int get highlightPage => _highlightPage;

  String get filterPeriod => _filterPeriod;

  String get filterHashtag => _filterHashtag;

  String get filterDepartment => _filterDepartment;

  List<KudoItem> get highlights => vm.highlights;

  List<SpotlightEntry> get filteredSpotlight => vm.spotlight;

  List<SpotlightActivity> get spotlightActivities => vm.spotlightActivities;

  List<KudoItem> get allKudos => vm.allKudos;

  KudosStats get stats => vm.stats;

  bool get isHubLoading => vm.isHubLoading;

  int get highlightPageCount => highlights.isEmpty ? 1 : highlights.length;

  @override
  KudosVm initViewModel() => KudosVm();

  List<String> get periodFilters => tr.kudosPeriodFilters;

  List<String> get hashtagFilters => tr.kudosHashtagFilters;

  List<String> get departmentFilters => tr.kudosDepartmentFilters;

  @override
  void beforeBuild() {
    _filterPeriod = tr.kudosFilterPeriodThisMonth;
    _filterHashtag = tr.kudosFilterHashtagAll;
    _filterDepartment = tr.kudosFilterDepartmentDefault;
    _loadLanguage();
    initNotificationBadge();
    highlightController.addListener(_onHighlightScroll);
    vm.loadHub(
      period: tr.kudosHubPeriodParam(_filterPeriod),
      hashtag: tr.kudosHubHashtagParam(_filterHashtag),
      department: tr.kudosHubDepartmentParam(_filterDepartment),
    );
  }

  Future<void> _reloadHub() => vm.loadHub(
        period: tr.kudosHubPeriodParam(_filterPeriod),
        hashtag: tr.kudosHubHashtagParam(_filterHashtag),
        department: tr.kudosHubDepartmentParam(_filterDepartment),
      );

  void _loadLanguage() {
    final saved = storage.getString(StorageKey.keySelectedLanguage.name);
    if (saved == 'en') _languageCode = 'EN';
    if (saved == 'ja') _languageCode = 'JA';
  }

  void _onHighlightScroll() {
    if (!highlightController.hasClients) return;
    final page = highlightController.page?.round() ?? 0;
    if (page != _highlightPage && mounted) {
      setState(() => _highlightPage = page);
    }
  }

  void onHighlightPageChanged(int page) {
    if (page != _highlightPage) setState(() => _highlightPage = page);
  }

  @override
  Widget initWidget(BuildContext context) => KudosScreen(this, context).screen();

  void onLanguageTap() {
    showSaaLanguageSheet(
      context: context,
      currentCode: _languageCode,
      onLanguageChanged: (code) => setState(() => _languageCode = code),
    );
  }

  void onSearchTap() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const SearchSunnerState()),
    );
  }

  void onSpotlightSearchTap() => onSearchTap();

  void onSpotlightSunnerTap(SunnerProfile sunner) => openSunnerProfile(context, sunner);

  void onNotificationTap() => navigator.navigateTo(Routes.notificationListState);

  void onSendKudoTap() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const WriteKudoState()),
    );
  }

  void onKudoTap(KudoItem item) => openKudoDetail(context, item);

  void onHighlightPrev() {
    if (_highlightPage > 0) {
      highlightController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void onHighlightNext() {
    if (_highlightPage < highlightPageCount - 1) {
      highlightController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> onFilterPeriodTap() async {
    final picked = await showKudosFilterBottomSheet(
      context: context,
      title: tr.kudosFilterPeriodTitle,
      options: periodFilters,
      selected: _filterPeriod,
    );
    if (picked == null) return;
    setState(() => _filterPeriod = picked);
    await _reloadHub();
  }

  Future<void> onFilterHashtagTap() async {
    final picked = await showKudosDropdown(
      context: context,
      buttonKey: hashtagButtonKey,
      options: hashtagFilters,
      selected: _filterHashtag,
    );
    if (picked == null) return;
    setState(() {
      _filterHashtag = picked;
      _highlightPage = 0;
    });
    await _reloadHub();
  }

  Future<void> onFilterDepartmentTap() async {
    final picked = await showKudosDropdown(
      context: context,
      buttonKey: departmentButtonKey,
      options: departmentFilters,
      selected: _filterDepartment,
    );
    if (picked == null) return;
    setState(() {
      _filterDepartment = picked;
      _highlightPage = 0;
    });
    await _reloadHub();
  }

  void onViewAllKudosTap() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const KudosAllState()),
    );
  }

  void onOpenSecretBoxTap() {
    // TODO: Implement secret box opening functionality
  }

  @override
  void dispose() {
    disposeNotificationBadge();
    highlightController.removeListener(_onHighlightScroll);
    highlightController.dispose();
    super.dispose();
  }
}
