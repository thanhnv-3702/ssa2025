import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/pages/kudos/kudos_mock_data.dart';

/// Hashtag dropdown — MoMorph `aKWA2klsnt` / write form.
Future<void> showKudosHashtagSheet({
  required BuildContext context,
  required List<String> selected,
  required void Function(List<String> updated) onChanged,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: const Color(0xFF00101A),
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
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Hashtag (${_selected.length}/5)',
              style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w700),
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
                  selectedColor: const Color(0xFFFFE99E),
                  checkmarkColor: const Color(0xFF00101A),
                  labelStyle: TextStyle(
                    color: isOn ? const Color(0xFF00101A) : Colors.white,
                    fontSize: 13.sp,
                  ),
                  backgroundColor: const Color(0xFF0A1F2E),
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
                backgroundColor: const Color(0xFFFFE99E),
                foregroundColor: const Color(0xFF00101A),
              ),
              child: const Text('Xong'),
            ),
          ],
        ),
      ),
    );
  }
}
