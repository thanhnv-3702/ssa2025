import 'package:base_core/presenter/base_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:saa2025/pages/kudos/community_standards_screen.dart';
import 'package:saa2025/pages/kudos/community_standards_vm.dart';
import 'package:saa2025/pages/kudos/kudos_mock_data.dart';
import 'package:saa2025/pages/utils/mixin/ui_mixin.dart';

/// Tiêu chuẩn cộng đồng — MoMorph `xms7csmDhD`.
class CommunityStandardsState extends StatefulWidget {
  const CommunityStandardsState({super.key});

  @override
  State<StatefulWidget> createState() => CommunityStandards();
}

class CommunityStandards extends BaseScreenState<CommunityStandardsState, CommunityStandardsVm> with UIMixin {
  String get intro => KudosMockData.communityStandardsIntro;

  List<String> get communityRules => KudosMockData.communityStandardsRules;

  List<String> get privacyRules => KudosMockData.privacyStandards;

  @override
  CommunityStandardsVm initViewModel() => CommunityStandardsVm();

  @override
  Widget initWidget(BuildContext context) => CommunityStandardsScreen(this, context).screen();

  void onBack() => Navigator.of(context).pop();
}
