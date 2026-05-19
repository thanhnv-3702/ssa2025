import 'package:flutter/material.dart';
import 'package:saa2025/pages/kudos/kudos_mock_data.dart';
import 'package:saa2025/pages/kudos/kudos_models.dart';
import 'package:saa2025/pages/kudos/sunner_profile.dart';
import 'package:saa2025/pages/kudos/view_kudo.dart';
import 'package:saa2025/pages/kudos/view_kudo_anonymous.dart';

/// Central routing for Kudo detail screens (P0).
void openKudoDetail(BuildContext context, KudoItem item) {
  if (item.isAnonymous) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ViewKudoAnonymousState(kudo: item),
      ),
    );
  } else {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ViewKudoState(kudo: item),
      ),
    );
  }
}

void openSunnerProfile(BuildContext context, SunnerProfile profile) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (_) => SunnerProfileState(profile: profile),
    ),
  );
}

void openCurrentUserProfile(BuildContext context) {
  openSunnerProfile(context, KudosMockData.currentUser);
}
