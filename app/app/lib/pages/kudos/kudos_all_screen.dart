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
        appBar: AppBar(
          backgroundColor: _background,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: main.onBack,
          ),
          title: Text(
            'All Kudos',
            style: TextStyle(color: Colors.white, fontSize: 17.sp, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 160.h,
              child: Image.asset(Assets.homeHomeBg, fit: BoxFit.cover),
            ),
            SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(child: _sectionHeader()),
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final item = main.items[index];
                          return Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
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
    );
  }

  Widget _sectionHeader() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Sun* Annual Awards 2025', style: TextStyle(color: _textMuted, fontSize: 11.sp)),
          Gap(4.h),
          Row(
            children: [
              Container(width: 4.w, height: 20.h, color: _accent),
              Gap(8.w),
              Text(
                'ALL KUDOS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          Gap(8.h),
          Text(
            '${main.items.length} kudos',
            style: TextStyle(color: _textMuted, fontSize: 12.sp),
          ),
        ],
      ),
    );
  }
}
