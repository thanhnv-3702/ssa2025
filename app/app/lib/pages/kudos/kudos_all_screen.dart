import 'package:base_core/presenter/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/generated/assets.dart';
import 'package:saa2025/pages/kudos/kudos_all.dart';
import 'package:saa2025/pages/kudos/widgets/kudos_highlight_card.dart';

/// All Kudos — MoMorph `j_a2GQWKDJ`.
class KudosAllScreen extends BaseScreen<KudosAll> {
  KudosAllScreen(super.main, super.context);

  static const Color _background = Color(0xFF00101A);
  static const Color _accent = Color(0xFFFFE99E);
  static const Color _textMuted = Color(0xB3FFFFFF);

  @override
  Widget screen() {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: _background,
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
                  colors: [
                    Color(0xFF00101A),
                    Color(0xFF00101A),
                    Color(0x0000101A),
                  ],
                ),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: main.onBack,
                      ),
                      Spacer(),
                      Text(
                        'All Kudos',
                        style: TextStyle(color: Colors.white, fontSize: 17.sp, fontWeight: FontWeight.w600),
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
            'Sun* Annual Awards 2025',
            style: TextStyle(
              color: Colors.white,
              fontSize: 11.sp,
            ),
          ),
          Gap(4.h),
          Container(
            height: 1,
            width: double.infinity,
            color: Color(0xFF2E3940),
          ),
          Gap(6.h),
          Row(
            children: [
              Text(
                'ALL KUDOS',
                style: TextStyle(
                  color: _accent,
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
