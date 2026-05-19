import 'package:base_core/presenter/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:saa2025/pages/home/home.dart';
import 'package:saa2025/pages/main_tab/main_tab.dart';
import 'package:saa2025/pages/widgets/saa_bottom_nav.dart';
import 'package:saa2025/pages/kudos/kudos.dart';
import 'package:saa2025/data/repositories/repository_provider.dart';
import 'package:saa2025/pages/kudos/kudos_mock_data.dart';
import 'package:saa2025/pages/kudos/sunner_profile.dart';
import 'package:saa2025/pages/awards/awards.dart';

class MainTabScreen extends BaseScreen<MainTab> {
  MainTabScreen(super.main, super.context);

  static const Color _background = Color(0xFF00101A);

  @override
  Widget screen() {
    return ColoredBox(
      color: _background,
      child: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: main.currentIndex,
              children: [
                const HomeState(),
                const AwardsState(),
                const KudosState(),
                SunnerProfileState(
                  profile: RepositoryProvider.kudos.currentUser ?? KudosMockData.currentUser,
                ),
              ],
            ),
          ),
          SaaBottomNav(
            currentIndex: main.currentIndex,
            onTap: main.onTabSelected,
          ),
        ],
      ),
    );
  }
}
