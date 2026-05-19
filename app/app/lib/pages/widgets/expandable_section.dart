import 'package:base_core/res/widgets/text.dart';
import 'package:base_core/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

/// Section with a title and chevron. Tapping the header toggles expansion;
/// the icon rotates 180° when expanded.
class ExpandableSection extends StatefulWidget {
  final String title;
  final Widget child;
  final bool initiallyExpanded;
  final bool blurEdge;

  const ExpandableSection({
    super.key,
    required this.title,
    required this.child,
    this.initiallyExpanded = false,
    this.blurEdge = true,
  });

  @override
  State<ExpandableSection> createState() => _ExpandableSectionState();
}

class _ExpandableSectionState extends State<ExpandableSection> {
  late bool _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
  }

  Widget renderWithEdge() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.skyLight),
        color: Colors.white,
      ),
      padding: widget.blurEdge ? EdgeInsets.all(16.h) : EdgeInsets.all(8.h),
      child: widget.child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: [
        InkWell(
          onTap: () => setState(() => _expanded = !_expanded),
          child: Row(
            children: [
              Expanded(
                child: TextCs(
                  text: widget.title,
                  style: AppFonts.regular600.copyWith(
                    color: AppColors.inkDarkest,
                    fontSize: 16.sp,
                  ),
                ),
              ),
              AnimatedRotation(
                turns: _expanded ? -.25 : 0,
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  Icons.keyboard_arrow_right,
                  color: AppColors.inkBase,
                  size: 24.r,
                ),
              ),
            ],
          ),
        ),
        Gap(8.h),
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          child: _expanded ? renderWithEdge() : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
