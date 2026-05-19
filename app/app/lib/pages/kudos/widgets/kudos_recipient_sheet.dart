import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:saa2025/pages/kudos/kudos_mock_data.dart';
import 'package:saa2025/pages/kudos/kudos_models.dart';
import 'package:saa2025/pages/kudos/search_sunner.dart';

/// Dropdown chọn người nhận — MoMorph `aKWA2klsnt` style.
Future<SunnerProfile?> showKudosRecipientSheet(BuildContext context) {
  return showModalBottomSheet<SunnerProfile>(
    context: context,
    isScrollControlled: true,
    backgroundColor: const Color(0xFF00101A),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
    ),
    builder: (ctx) => _RecipientSheetBody(parentContext: context),
  );
}

class _RecipientSheetBody extends StatefulWidget {
  const _RecipientSheetBody({required this.parentContext});

  final BuildContext parentContext;

  @override
  State<_RecipientSheetBody> createState() => _RecipientSheetBodyState();
}

class _RecipientSheetBodyState extends State<_RecipientSheetBody> {
  final _queryController = TextEditingController();
  List<SunnerProfile> _results = KudosMockData.sunners;

  @override
  void initState() {
    super.initState();
    _queryController.addListener(_onQuery);
  }

  void _onQuery() {
    setState(() => _results = KudosMockData.searchSunners(_queryController.text));
  }

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final maxH = MediaQuery.sizeOf(context).height * 0.75;
    return SafeArea(
      child: SizedBox(
        height: maxH,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Text(
                'Chọn người nhận',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: TextField(
                controller: _queryController,
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm',
                  hintStyle: TextStyle(color: const Color(0xB3FFFFFF), fontSize: 14.sp),
                  filled: true,
                  fillColor: const Color(0xFF0A1F2E),
                  prefixIcon: const Icon(Icons.search, color: Color(0xB3FFFFFF)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Gap(8.h),
            ListTile(
              leading: const Icon(Icons.open_in_new, color: Color(0xFFFFE99E)),
              title: const Text('Tìm kiếm nâng cao', style: TextStyle(color: Color(0xFFFFE99E))),
              onTap: () async {
                Navigator.pop(context);
                final picked = await Navigator.of(widget.parentContext).push<SunnerProfile>(
                  MaterialPageRoute(builder: (_) => const SearchSunnerState(selectMode: true)),
                );
                if (picked != null && widget.parentContext.mounted) {
                  Navigator.of(widget.parentContext).pop(picked);
                }
              },
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                itemCount: _results.length,
                itemBuilder: (_, i) {
                  final s = _results[i];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: s.avatarAsset != null ? AssetImage(s.avatarAsset!) : null,
                      child: s.avatarAsset == null ? Text(s.name[0]) : null,
                    ),
                    title: Text(s.name, style: const TextStyle(color: Colors.white)),
                    subtitle: Text(
                      '${s.department} · ${s.employeeCode ?? ''}',
                      style: const TextStyle(color: Color(0xB3FFFFFF)),
                    ),
                    onTap: () => Navigator.pop(context, s),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
