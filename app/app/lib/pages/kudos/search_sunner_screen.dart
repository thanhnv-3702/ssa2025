import 'package:base_core/presenter/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/generated/assets.dart';
import 'package:saa2025/pages/kudos/kudos_models.dart';
import 'package:saa2025/pages/kudos/search_sunner.dart';
import 'package:saa2025/pages/utils/extension.dart';
import 'package:saa2025/theme/app_colors.dart';

/// Search Sunner — MoMorph `3jgwke3E8O` (recent) / `hldqjHoSRH` (typing).
class SearchSunnerScreen extends BaseScreen<SearchSunner> {
  SearchSunnerScreen(super.main, super.context);

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
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 160.h,
              child: Image.asset(Assets.homeHomeBg, fit: BoxFit.cover),
            ),
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildSearchBar(),
                  Expanded(
                    child: main.isSearching ? _buildResults() : _buildRecent(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.fromLTRB(8.w, 8.h, 16.w, 12.h),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
            onPressed: main.onBack,
          ),
          Expanded(
            child: TextField(
              controller: main.searchController,
              autofocus: true,
              style: TextStyle(color: AppColors.textPrimary, fontSize: 15.sp),
              decoration: InputDecoration(
                hintText: tr.searchSunnerHint,
                hintStyle: TextStyle(color: AppColors.textMuted, fontSize: 15.sp),
                filled: true,
                fillColor: AppColors.fieldBackground,
                prefixIcon: Icon(Icons.search, color: AppColors.textMuted, size: 22.sp),
                suffixIcon: main.isSearching
                    ? IconButton(
                        icon: Icon(Icons.close, color: AppColors.textMuted, size: 20.sp),
                        onPressed: main.onClearQuery,
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.r),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 12.h),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecent() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      children: [
        Row(
          children: [
            Text(tr.searchSunnerRecentTitle,
                style: TextStyle(color: AppColors.textPrimary, fontSize: 16.sp, fontWeight: FontWeight.w700)),
            const Spacer(),
            TextButton(
              onPressed: main.onViewAllRecentTap,
              child: Text(tr.searchSunnerViewAll, style: TextStyle(color: AppColors.accent, fontSize: 13.sp)),
            ),
          ],
        ),
        Gap(8.h),
        ...main.recentSearches.asMap().entries.map((e) => _recentChip(e.key, e.value)),
        if (main.results.isNotEmpty) ...[
          Gap(24.h),
          Text(tr.searchSunnerSuggestionsTitle, style: TextStyle(color: AppColors.textMuted, fontSize: 14.sp)),
          Gap(12.h),
          ...main.results.map(_sunnerTile),
        ],
      ],
    );
  }

  Widget _recentChip(int index, String term) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () => main.onRecentTap(term),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: AppColors.fieldBackground,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(term, style: TextStyle(color: AppColors.textPrimary, fontSize: 14.sp)),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.close, color: AppColors.textMuted, size: 18.sp),
            onPressed: () => main.onRemoveRecent(index),
          ),
        ],
      ),
    );
  }

  Widget _buildResults() {
    if (main.results.isEmpty) {
      return Center(
        child: Text(
          tr.searchSunnerNoResults,
          style: TextStyle(color: AppColors.textMuted, fontSize: 14.sp),
        ),
      );
    }
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      itemCount: main.results.length,
      separatorBuilder: (_, __) => Gap(8.h),
      itemBuilder: (_, i) => _sunnerTile(main.results[i]),
    );
  }

  Widget _sunnerTile(SunnerProfile sunner) {
    return Material(
      color: AppColors.fieldBackground,
      borderRadius: BorderRadius.circular(8.r),
      child: InkWell(
        onTap: () => main.onSunnerTap(sunner),
        borderRadius: BorderRadius.circular(8.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          child: Row(
            children: [
              CircleAvatar(
                radius: 22.r,
                backgroundColor: AppColors.avatarPlaceholder,
                backgroundImage: sunner.avatarAsset != null ? AssetImage(sunner.avatarAsset!) : null,
                child:
                    sunner.avatarAsset == null ? Text(sunner.name[0], style: TextStyle(color: AppColors.accent)) : null,
              ),
              Gap(12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sunner.name,
                      style: TextStyle(color: AppColors.textPrimary, fontSize: 14.sp, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '${sunner.department}${sunner.employeeCode != null ? ' · ${sunner.employeeCode}' : ''}',
                      style: TextStyle(color: AppColors.textMuted, fontSize: 12.sp),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: AppColors.textMuted, size: 20.sp),
            ],
          ),
        ),
      ),
    );
  }
}
