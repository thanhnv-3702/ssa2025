import 'package:base_core/presenter/base_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:saa2025/pages/utils/extension.dart';
import 'package:saa2025/pages/utils/utils.dart';
import 'package:saa2025/pages/widgets/update_dialog_screen.dart';
import 'package:saa2025/pages/widgets/update_dialog_vm.dart';
import 'package:saa2025/services/app_update_service.dart';
import 'package:saa2025/services/version_check_service.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateDialogState extends StatefulWidget {
  final VersionCheckResult updateInfo;
  final bool isRequired;
  final String version;

  const UpdateDialogState({
    super.key,
    required this.version,
    required this.updateInfo,
    required this.isRequired,
  });

  @override
  State<UpdateDialogState> createState() => UpdateDialog();
}

class UpdateDialog extends BaseScreenState<UpdateDialogState, UpdateDialogVm> {
  final AppUpdateService _updateService = AppUpdateService();
  bool isDownloading = false;
  double downloadProgress = 0.0;

  @override
  UpdateDialogVm initViewModel() => UpdateDialogVm();

  @override
  Widget initWidget(BuildContext context) => UpdateDialogScreen(this, context).screen();

  Future<void> handleUpdate() async {
    if (widget.updateInfo.downloadUrl.isEmpty) {
      Utils.showToast(tr.updateDownloadUrlNotFound);
      return;
    }

    setState(() {
      isDownloading = true;
      downloadProgress = 0.0;
    });

    final success = await _updateService.downloadAndInstall(
      version: widget.version,
      downloadUrl: widget.updateInfo.downloadUrl,
      onProgress: (progress) {
        setState(() {
          downloadProgress = progress;
        });
      },
      onError: (error) {
        setState(() {
          isDownloading = false;
        });
        Utils.showToast('${tr.updateFailed}: $error');
      },
    );

    if (success) {
      Utils.showToast(tr.updateDownloaded, isSuccess: true);
    } else {
      setState(() {
        isDownloading = false;
      });
    }
  }

  Future<void> handleUpdateIOS() async {
    final url = widget.updateInfo.downloadUrl.trim();
    final isTestFlightLink = url.isNotEmpty && (url.contains('testflight.apple.com') || url.startsWith('itms-beta://'));
    final String link = isTestFlightLink ? url : 'https://apps.apple.com/app/testflight/id899247664';

    final uri = Uri.parse(link);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        Utils.showToast(tr.updateDownloadUrlNotFound);
      }
    } catch (e) {
      Utils.showToast('${tr.updateFailed}: $e');
    }
  }
}
