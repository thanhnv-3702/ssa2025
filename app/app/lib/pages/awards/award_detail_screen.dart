import 'package:base_core/presenter/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/generated/assets.dart';
import 'package:saa2025/pages/awards/award_detail.dart';
import 'package:saa2025/pages/awards/widgets/award_info_blocks.dart';
import 'package:saa2025/pages/awards/widgets/award_kudos_promo.dart';
import 'package:saa2025/pages/awards/widgets/award_picture_card.dart';
import 'package:saa2025/pages/home/home_styles.dart';
import 'package:saa2025/pages/widgets/saa_app_header.dart';

/// Award detail — MoMorph `Award_*` screens (Sprint B).
class AwardDetailScreen extends BaseScreen<AwardDetailPage> {
  AwardDetailScreen(super.main, super.context);

  @override
  Widget screen() {
    final award = main.award;
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: HomeStyles.background,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 280.h,
              child: Image.asset(Assets.homeHomeBg, fit: BoxFit.cover),
            ),
            Column(
              children: [
                SaaAppHeader(
                  languageCode: main.languageCode,
                  onLanguageTap: main.onLanguageTap,
                  onNotificationTap: main.onNotificationTap,
                  showBack: true,
                  onBack: main.onBack,
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 40.h),
                    children: [
                      AwardPictureCard(imageAsset: award.imageAsset, title: award.title),
                      Gap(20.h),
                      AwardInfoBlocks.descriptionBlock(
                        title: award.displayTitle,
                        description: award.longDescription,
                      ),
                      Gap(16.h),
                      const Divider(color: HomeStyles.divider, height: 1),
                      Gap(16.h),
                      AwardInfoBlocks.prizeQuantityBlock(award),
                      Gap(16.h),
                      const Divider(color: HomeStyles.divider, height: 1),
                      Gap(16.h),
                      for (var i = 0; i < award.prizeValues.length; i++) ...[
                        if (i > 0) ...[
                          AwardInfoBlocks.orDivider(),
                          Gap(8.h),
                        ],
                        AwardInfoBlocks.prizeValueBlock(award.prizeValues[i]),
                      ],
                      Gap(32.h),
                      AwardKudosPromo(onDetailTap: main.onKudosDetailTap),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
