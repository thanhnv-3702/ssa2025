import 'package:base_core/presenter/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/generated/assets.dart';
import 'package:saa2025/pages/kudos/kudos_models.dart';
import 'package:saa2025/pages/kudos/search_sunner.dart';

/// Search Sunner — MoMorph `3jgwke3E8O` (recent) / `hldqjHoSRH` (typing).
class SearchSunnerScreen extends BaseScreen<SearchSunner> {
  SearchSunnerScreen(super.main, super.context);

  static const Color _background = Color(0xFF00101A);
  static const Color _accent = Color(0xFFFFE99E);
  static const Color _fieldBg = Color(0xFF0A1F2E);
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
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: main.onBack,
          ),
          Expanded(
            child: TextField(
              controller: main.searchController,
              autofocus: true,
              style: TextStyle(color: Colors.white, fontSize: 15.sp),
              decoration: InputDecoration(
                hintText: 'Tìm kiếm Sunner',
                hintStyle: TextStyle(color: _textMuted, fontSize: 15.sp),
                filled: true,
                fillColor: _fieldBg,
                prefixIcon: Icon(Icons.search, color: _textMuted, size: 22.sp),
                suffixIcon: main.isSearching
                    ? IconButton(
                        icon: Icon(Icons.close, color: _textMuted, size: 20.sp),
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
            Text('Recent', style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w700)),
            const Spacer(),
            TextButton(
              onPressed: main.onViewAllRecentTap,
              child: Text('View all', style: TextStyle(color: _accent, fontSize: 13.sp)),
            ),
          ],
        ),
        Gap(8.h),
        ...main.recentSearches.asMap().entries.map((e) => _recentChip(e.key, e.value)),
        if (main.results.isNotEmpty) ...[
          Gap(24.h),
          Text('Gợi ý', style: TextStyle(color: _textMuted, fontSize: 14.sp)),
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
                  color: _fieldBg,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(term, style: TextStyle(color: Colors.white, fontSize: 14.sp)),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.close, color: _textMuted, size: 18.sp),
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
          'Không tìm thấy Sunner',
          style: TextStyle(color: _textMuted, fontSize: 14.sp),
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
      color: _fieldBg,
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
                backgroundColor: const Color(0xFF1A3A4A),
                backgroundImage:
                    sunner.avatarAsset != null ? AssetImage(sunner.avatarAsset!) : null,
                child: sunner.avatarAsset == null
                    ? Text(sunner.name[0], style: TextStyle(color: _accent))
                    : null,
              ),
              Gap(12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sunner.name,
                      style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '${sunner.department}${sunner.employeeCode != null ? ' · ${sunner.employeeCode}' : ''}',
                      style: TextStyle(color: _textMuted, fontSize: 12.sp),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: _textMuted, size: 20.sp),
            ],
          ),
        ),
      ),
    );
  }
}
