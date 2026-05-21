import 'package:base_core/presenter/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/generated/assets.dart';
import 'package:saa2025/pages/kudos/kudos_all.dart';
import 'package:saa2025/pages/kudos/widgets/kudos_highlight_card.dart';
import 'package:saa2025/pages/utils/extension.dart';
import 'package:saa2025/theme/app_colors.dart';

/// All Kudos — MoMorph `j_a2GQWKDJ`.
class KudosAllScreen extends BaseScreen<KudosAll> {
  KudosAllScreen(super.main, super.context);

  @override
  Widget screen() {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(Assets.homeHomeBg, fit: BoxFit.cover),
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: AppColors.scaffoldFadeGradientColors,
                ),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
                        onPressed: main.onBack,
                      ),
                      Spacer(),
                      Text(
                        tr.kudosAllScreenTitle,
                        style: TextStyle(color: AppColors.textPrimary, fontSize: 17.sp, fontWeight: FontWeight.w600),
                      ),
                      Spacer(),
                      SizedBox(
                        width: 24,
                      ),
                    ],
                  ),
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(child: _sectionHeader()),
                        SliverPadding(
                          padding: EdgeInsets.fromLTRB(48.w, 0, 48.w, 24.h),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final item = main.items[index];
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 16.h),
                                  child: KudosHighlightCard(
                                    item: item,
                                    width: double.infinity,
                                    onTap: () => main.onKudoTap(item),
                                  ),
                                );
                              },
                              childCount: main.items.length,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr.kudosAllEyebrow,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 11.sp,
            ),
          ),
          Gap(4.h),
          Container(
            height: 1,
            width: double.infinity,
            color: AppColors.divider,
          ),
          Gap(6.h),
          Row(
            children: [
              Text(
                tr.kudosAllSectionHeader,
                style: TextStyle(
                  color: AppColors.accent,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
