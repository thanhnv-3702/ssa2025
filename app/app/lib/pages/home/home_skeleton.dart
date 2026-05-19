import 'package:base_core/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/pages/widgets/skeleton_card.dart';

/// Skeleton placeholder matching the home dashboard layout, shown while the dashboard API is loading.
class HomeSkeleton extends StatelessWidget {
  const HomeSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(16.h),
          _skeletonTopBar(),
          Gap(16.h),
          _skeletonDashboardTitle(),
          Gap(16.h),
          _skeletonConnectProfileCard(),
          Gap(16.h),
          _skeletonFaqCard(),
          Gap(16.h),
          _skeletonAppointmentsSection(),
          Gap(16.h),
          _skeletonReportsSection(),
          Gap(16.h),
        ],
      ),
    );
  }

  Widget _skeletonBox({
    required double width,
    required double height,
    double? borderRadius,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.skyLightest,
        borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
      ),
      child: SkeletonCard(
        height: height,
        backgroundColor: AppColors.skyLight,
        flashColor: AppColors.white,
        animAxis: Axis.horizontal,
        animated: true,
      ),
    );
  }

  Widget _skeletonTopBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                _skeletonBox(width: 70.w, height: 14.h),
                Gap(8.w),
                _skeletonBox(width: 100.w, height: 14.h),
                Gap(8.w),
                _skeletonBox(width: 20.w, height: 20.w),
              ],
            ),
          ),
          _skeletonBox(width: 24.w, height: 24.w),
          Gap(8.w),
          _skeletonBox(width: 24.w, height: 24.w),
        ],
      ),
    );
  }

  Widget _skeletonDashboardTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: _skeletonBox(width: 180.w, height: 28.h, borderRadius: 8.r),
    );
  }

  Widget _skeletonConnectProfileCard() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColors.greenLightest2,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.skyLightest),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _skeletonBox(width: 36.w, height: 36.w),
            Gap(12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _skeletonBox(width: 140.w, height: 14.h),
                  Gap(8.h),
                  _skeletonBox(width: double.infinity, height: 12.h),
                  Gap(4.h),
                  _skeletonBox(width: 200.w, height: 12.h),
                  Gap(12.h),
                  _skeletonBox(width: 80.w, height: 32.h, borderRadius: 48.r),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _skeletonFaqCard() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColors.greenLightest2,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.skyLightest),
        ),
        child: Row(
          children: [
            _skeletonBox(width: 24.w, height: 24.w),
            Gap(12.w),
            Expanded(
              child: _skeletonBox(width: double.infinity, height: 14.h),
            ),
            _skeletonBox(width: 16.w, height: 16.w),
          ],
        ),
      ),
    );
  }

  Widget _skeletonAppointmentsSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: AppColors.greenLightest2,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: AppColors.skyLightest),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              child: Row(
                children: [
                  _skeletonBox(width: 120.w, height: 16.h),
                  Gap(8.w),
                  _skeletonBox(width: 16.w, height: 16.w),
                ],
              ),
            ),
            Gap(8.h),
            _skeletonAppointmentItem(),
            Gap(8.h),
            _skeletonAppointmentItem(),
            Gap(8.h),
            _skeletonAppointmentItem(),
          ],
        ),
      ),
    );
  }

  Widget _skeletonAppointmentItem() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.greenLightest2,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.skyLightest),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _skeletonBox(width: double.infinity, height: 14.h),
              ),
              _skeletonBox(width: 60.w, height: 24.h, borderRadius: 32.r),
            ],
          ),
          Gap(10.h),
          _skeletonBox(width: 100.w, height: 12.h),
          Gap(8.h),
          _skeletonBox(width: 120.w, height: 12.h),
          Gap(8.h),
          _skeletonBox(width: 80.w, height: 12.h),
        ],
      ),
    );
  }

  Widget _skeletonReportsSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: AppColors.greenLightest2,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: AppColors.skyLightest),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        _skeletonBox(width: 140.w, height: 16.h),
                        Gap(8.w),
                        _skeletonBox(width: 16.w, height: 16.w),
                      ],
                    ),
                  ),
                  _skeletonBox(width: 20.w, height: 20.w),
                ],
              ),
            ),
            Gap(8.h),
            _skeletonReportItem(),
            Gap(8.h),
            _skeletonReportItem(),
          ],
        ),
      ),
    );
  }

  Widget _skeletonReportItem() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.greenLightest2,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.skyLightest),
      ),
      child: Row(
        children: [
          _skeletonBox(width: 20.w, height: 20.w),
          Gap(10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _skeletonBox(width: 120.w, height: 14.h),
                Gap(6.h),
                _skeletonBox(width: 80.w, height: 12.h),
              ],
            ),
          ),
          _skeletonBox(width: 60.w, height: 12.h),
        ],
      ),
    );
  }
}
