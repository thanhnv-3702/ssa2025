import 'package:base_core/presenter/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/generated/assets.dart';
import 'package:saa2025/pages/kudos/sunner_profile.dart';
import 'package:saa2025/pages/kudos/widgets/kudos_highlight_card.dart';
import 'package:saa2025/theme/saa_design_tokens.dart';

class SunnerProfileScreen extends BaseScreen<SunnerProfilePage> {
  SunnerProfileScreen(super.main, super.context);

  static const Color _background = SaaDesignTokens.background;
  static const Color _accent = SaaDesignTokens.accent;
  static const Color _textMuted = SaaDesignTokens.textMuted;

  @override
  Widget screen() {
    final p = main.profile;
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
            main.isSelf ? 'Hồ sơ của tôi' : p.name,
            style: TextStyle(color: Colors.white, fontSize: 17.sp, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            if (main.isLoading)
              const Center(child: CircularProgressIndicator(color: SaaDesignTokens.accent)),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 180.h,
              child: Image.asset(Assets.homeHomeBg, fit: BoxFit.cover),
            ),
            if (!main.isLoading)
            SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(child: _buildMemberCard(p)),
                  if (!main.isSelf)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 0),
                        child: ElevatedButton.icon(
                          onPressed: main.onSendKudoTap,
                          icon: const Icon(Icons.send_rounded),
                          label: Text(
                            'Gửi lời cảm ơn tới ${p.name.split(' ').last}...',
                            overflow: TextOverflow.ellipsis,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _accent,
                            foregroundColor: _background,
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28.r),
                            ),
                          ),
                        ),
                      ),
                    ),
                  SliverToBoxAdapter(child: _buildBadges(p)),
                  SliverToBoxAdapter(child: _buildStats(p)),
                  SliverToBoxAdapter(child: _sectionTitle('KUDOS')),
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
                    sliver: main.kudosList.isEmpty
                        ? SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.all(24.w),
                              child: Center(
                                child: Text(
                                  'Chưa có Kudos',
                                  style: TextStyle(color: _textMuted, fontSize: 14.sp),
                                ),
                              ),
                            ),
                          )
                        : SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, i) {
                                final item = main.kudosList[i];
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 12.h),
                                  child: KudosHighlightCard(
                                    item: item,
                                    width: double.infinity,
                                    onTap: () => main.onKudoTap(item),
                                  ),
                                );
                              },
                              childCount: main.kudosList.length,
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

  Widget _buildMemberCard(p) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40.r,
            backgroundColor: const Color(0xFF1A3A4A),
            backgroundImage: p.avatarAsset != null ? AssetImage(p.avatarAsset!) : null,
            child: p.avatarAsset == null
                ? Text(p.name[0], style: TextStyle(color: _accent, fontSize: 28.sp))
                : null,
          ),
          Gap(16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  p.name,
                  style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w700),
                ),
                if (p.heroTitle != null)
                  Text(
                    p.heroTitle!,
                    style: TextStyle(color: _accent, fontSize: 13.sp, fontWeight: FontWeight.w600),
                  ),
                Gap(4.h),
                Text(
                  '${p.department} · ${p.employeeCode ?? ''}',
                  style: TextStyle(color: _textMuted, fontSize: 12.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadges(p) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Bộ sưu tập icon của tôi', style: TextStyle(color: Colors.white, fontSize: 14.sp)),
          Gap(12.h),
          Wrap(
            spacing: 12.w,
            runSpacing: 12.h,
            children: p.badges
                .map(
                  (b) => Container(
                    width: 48.w,
                    height: 48.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0A1F2E),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: const Color(0x33FFE99E)),
                    ),
                    child: Text(b, style: TextStyle(fontSize: 24.sp)),
                  ),
                )
                .toList(),
          ),
          Gap(16.h),
        ],
      ),
    );
  }

  Widget _buildStats(p) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          Expanded(child: _statBox('${p.kudosReceived}', 'Kudos nhận')),
          Gap(8.w),
          Expanded(child: _statBox('${p.kudosSent}', 'Kudos gửi')),
        ],
      ),
    );
  }

  Widget _statBox(String value, String label) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF0A1F2E),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0x33FFE99E)),
      ),
      child: Column(
        children: [
          Text(value, style: TextStyle(color: _accent, fontSize: 18.sp, fontWeight: FontWeight.w800)),
          Gap(4.h),
          Text(label, style: TextStyle(color: _textMuted, fontSize: 11.sp)),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 12.h),
      child: Row(
        children: [
          Container(width: 4.w, height: 20.h, color: _accent),
          Gap(8.w),
          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
