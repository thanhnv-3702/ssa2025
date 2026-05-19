import 'dart:async';

import 'package:base_core/presenter/base_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:saa2025/pages/errors/error_navigation.dart';
import 'package:saa2025/pages/kudos/kudos_mock_data.dart';
import 'package:saa2025/pages/kudos/kudos_models.dart';
import 'package:saa2025/pages/kudos/kudos_navigation.dart';
import 'package:saa2025/pages/kudos/search_sunner_screen.dart';
import 'package:saa2025/pages/kudos/search_sunner_vm.dart';
import 'package:saa2025/pages/utils/mixin/ui_mixin.dart';

/// Search Sunner — MoMorph `3jgwke3E8O` / `hldqjHoSRH`.
class SearchSunnerState extends StatefulWidget {
  const SearchSunnerState({
    super.key,
    this.selectMode = false,
  });

  /// Khi true, chọn Sunner rồi pop về màn trước (Viết Kudo).
  final bool selectMode;

  @override
  State<StatefulWidget> createState() => SearchSunner();
}

class SearchSunner extends BaseScreenState<SearchSunnerState, SearchSunnerVm> with UIMixin {
  final TextEditingController searchController = TextEditingController();

  List<String> recentSearches = List.from(KudosMockData.recentSearches);
  List<SunnerProfile> results = List.from(KudosMockData.sunners);
  Timer? _searchDebounce;

  bool get isSearching => searchController.text.trim().isNotEmpty;

  @override
  SearchSunnerVm initViewModel() => SearchSunnerVm();

  @override
  void beforeBuild() {
    searchController.addListener(_onQueryChanged);
  }

  void _onQueryChanged() {
    final q = searchController.text.trim();
    _searchDebounce?.cancel();
    if (q.isEmpty) {
      setState(() {
        results = List.from(KudosMockData.sunners);
      });
      return;
    }

    _searchDebounce = Timer(const Duration(milliseconds: 350), () async {
      if (!mounted || searchController.text.trim() != q) return;
      final list = await vm.search(q);
      if (!mounted || searchController.text.trim() != q) return;
      setState(() => results = list);
      if (!widget.selectMode && list.isEmpty) {
        openNotFound(context);
      }
    });
  }

  @override
  Widget initWidget(BuildContext context) => SearchSunnerScreen(this, context).screen();

  void onBack() => Navigator.of(context).pop();

  void onClearQuery() {
    searchController.clear();
    setState(() => results = List.from(KudosMockData.sunners));
  }

  void onRemoveRecent(int index) {
    setState(() => recentSearches.removeAt(index));
  }

  void onRecentTap(String term) {
    searchController.text = term;
    _onQueryChanged();
  }

  void onSunnerTap(SunnerProfile sunner) {
    if (widget.selectMode) {
      Navigator.of(context).pop(sunner);
      return;
    }
    openSunnerProfile(context, sunner);
  }

  void onViewAllRecentTap() {
    searchController.clear();
    setState(() => results = List.from(KudosMockData.sunners));
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    searchController.removeListener(_onQueryChanged);
    searchController.dispose();
    super.dispose();
  }
}
