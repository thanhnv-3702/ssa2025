import 'package:base_core/common/base_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
/// Award hero — MoMorph `mm_media_Picture-Award` (160×160).
class AwardPictureCard extends StatelessWidget {
  const AwardPictureCard({
    super.key,
    required this.imageAsset,
    required this.title,
  });

  final String imageAsset;
  final String title;

  static const Color _accent = Color(0xFFFFE99E);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 160.w,
        height: 160.w,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11.r),
                border: Border.all(color: _accent, width: 0.5),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFAE287).withValues(alpha: 0.4),
                    blurRadius: 3,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(11.r),
                child: Image.asset(imageAsset, width: 160.w, height: 160.w, fit: BoxFit.cover),
              ),
            ),
            Positioned(
              bottom: 20.h,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: BaseConst.fontBold,
                  fontSize: 11.sp,
                  color: _accent,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
