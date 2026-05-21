import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/generated/app_localizations.dart';
import 'package:saa2025/pages/kudos/kudos_mock_data.dart';
import 'package:saa2025/theme/app_colors.dart';

/// Hashtag dropdown — MoMorph `aKWA2klsnt` / write form.
Future<void> showKudosHashtagSheet({
  required BuildContext context,
  required List<String> selected,
  required void Function(List<String> updated) onChanged,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.background,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
    ),
    builder: (ctx) => _HashtagSheet(selected: List.from(selected), onChanged: onChanged),
  );
}

class _HashtagSheet extends StatefulWidget {
  const _HashtagSheet({required this.selected, required this.onChanged});

  final List<String> selected;
  final void Function(List<String> updated) onChanged;

  @override
  State<_HashtagSheet> createState() => _HashtagSheetState();
}

class _HashtagSheetState extends State<_HashtagSheet> {
  late List<String> _selected;

  @override
  void initState() {
    super.initState();
    _selected = List.from(widget.selected);
  }

  void _toggle(String tag) {
    setState(() {
      if (_selected.contains(tag)) {
        _selected.remove(tag);
      } else if (_selected.length < 5) {
        _selected.add(tag);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final all = KudosMockData.suggestedHashtags;
    final tr = AppLocalizations.of(context);
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              tr.kudosHashtagSheetTitle(_selected.length),
              style: TextStyle(color: AppColors.textPrimary, fontSize: 16.sp, fontWeight: FontWeight.w700),
            ),
            Gap(16.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: all.map((tag) {
                final isOn = _selected.contains(tag);
                return FilterChip(
                  label: Text(tag),
                  selected: isOn,
                  onSelected: (_) => _toggle(tag),
                  selectedColor: AppColors.accent,
                  checkmarkColor: AppColors.background,
                  labelStyle: TextStyle(
                    color: isOn ? AppColors.background : AppColors.textPrimary,
                    fontSize: 13.sp,
                  ),
                  backgroundColor: AppColors.fieldBackground,
                );
              }).toList(),
            ),
            Gap(16.h),
            ElevatedButton(
              onPressed: () {
                widget.onChanged(_selected);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: AppColors.background,
              ),
              child: Text(tr.kudosHashtagSheetDone),
            ),
          ],
        ),
      ),
    );
  }
}
