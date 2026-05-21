import 'package:saa2025/data/models/kudos_hub_data.dart';
import 'package:saa2025/data/models/submit_kudo_result.dart';
import 'package:saa2025/pages/kudos/kudos_models.dart';

/// Maps SAA `/kudos/hub` JSON → domain models.
class KudosJsonParser {
  KudosJsonParser._();

  static KudosHubData parseHub(Map<String, dynamic> json) {
    final root = _unwrapData(json);

    return KudosHubData(
      stats: _parseStats(root['stats'] as Map<String, dynamic>? ?? {}),
      highlights: _parseKudoList(root['highlights']),
      spotlight: _parseSpotlight(root['spotlight']),
      spotlightActivities: _parseSpotlightActivities(
        root['spotlight_activities'] ?? root['spotlightActivities'],
      ),
      allKudos: _parseKudoList(root['all_kudos'] ?? root['allKudos']),
      periodFilters: _stringList(root['period_filters'] ?? root['periodFilters']),
      hashtagFilters: _stringList(root['hashtag_filters'] ?? root['hashtagFilters']),
      departmentFilters: _stringList(root['department_filters'] ?? root['departmentFilters']),
    );
  }

  static SunnerProfile? parseProfile(Map<String, dynamic> json) {
    final root = _unwrapData(json);
    final profile = root['profile'] ?? root['sunner'] ?? root;
    if (profile is Map<String, dynamic>) return _parseSunner(profile);
    if (root.containsKey('id') && root.containsKey('name')) {
      return _parseSunner(root);
    }
    return null;
  }

  static List<KudoItem> parseKudoList(Map<String, dynamic> json) {
    final root = _unwrapData(json);
    return _parseKudoList(root['items'] ?? root['kudos'] ?? root);
  }

  static SubmitKudoResult parseSubmitResult(Map<String, dynamic> json) {
    final root = _unwrapData(json);
    final id = root['kudo_id']?.toString() ?? root['id']?.toString();
    return SubmitKudoResult(
      success: root['success'] != false,
      kudoId: id,
      message: root['message']?.toString(),
    );
  }

  static List<SunnerProfile> parseSunners(Map<String, dynamic> json) {
    final root = _unwrapData(json);
    final list = root['items'] ?? root['sunners'] ?? root;
    if (list is! List) return [];
    return list.map((e) => _parseSunner(e as Map<String, dynamic>)).toList();
  }

  static Map<String, dynamic> _unwrapData(Map<String, dynamic> json) {
    final data = json['data'];
    if (data is Map<String, dynamic>) return data;
    if (data is String && data.isNotEmpty && data != '{}') {
      try {
        // ignore: avoid_dynamic_calls
        return Map<String, dynamic>.from(data as dynamic);
      } catch (_) {}
    }
    return json;
  }

  static KudosStats _parseStats(Map<String, dynamic> json) {
    return KudosStats(
      totalKudos: _int(json['total_kudos'] ?? json['totalKudos']),
      totalReceivers: _int(json['total_receivers'] ?? json['totalReceivers']),
      totalSenders: _int(json['total_senders'] ?? json['totalSenders']),
      topReceivers: _stringList(json['top_receivers'] ?? json['topReceivers']),
    );
  }

  static List<SpotlightEntry> _parseSpotlight(dynamic raw) {
    if (raw is! List) return [];
    return raw
        .map((e) {
          final m = e as Map<String, dynamic>;
          return SpotlightEntry(
            name: m['name']?.toString() ?? '',
            kudosCount: _int(m['kudos_count'] ?? m['kudosCount']),
          );
        })
        .where((e) => e.name.isNotEmpty)
        .toList();
  }

  static List<SpotlightActivity> _parseSpotlightActivities(dynamic raw) {
    if (raw is! List) return [];
    return raw
        .map((e) {
          final m = e as Map<String, dynamic>;
          return SpotlightActivity(
            time: m['time']?.toString() ?? '',
            personName: m['person_name']?.toString() ?? m['personName']?.toString() ?? '',
          );
        })
        .where((e) => e.personName.isNotEmpty)
        .toList();
  }

  static List<KudoItem> _parseKudoList(dynamic raw) {
    if (raw is! List) return [];
    return raw.map((e) => _parseKudo(e as Map<String, dynamic>)).toList();
  }

  static KudoItem _parseKudo(Map<String, dynamic> m) {
    return KudoItem(
      id: m['id']?.toString() ?? '',
      senderName: m['sender_name']?.toString() ?? m['senderName']?.toString() ?? '',
      receiverName: m['receiver_name']?.toString() ?? m['receiverName']?.toString() ?? '',
      title: m['title']?.toString() ?? '',
      message: m['message']?.toString() ?? '',
      postedAt: m['posted_at']?.toString() ?? m['postedAt']?.toString() ?? '',
      isAnonymous: m['is_anonymous'] == true || m['isAnonymous'] == true,
      senderAvatarAsset: m['sender_avatar']?.toString() ?? m['senderAvatarAsset']?.toString(),
      receiverAvatarAsset: m['receiver_avatar']?.toString() ?? m['receiverAvatarAsset']?.toString(),
      hashtags: _stringList(m['hashtags']),
      likeCount: _int(m['like_count'] ?? m['likeCount']),
      commentCount: _int(m['comment_count'] ?? m['commentCount']),
    );
  }

  static SunnerProfile _parseSunner(Map<String, dynamic> m) {
    return SunnerProfile(
      id: m['id']?.toString() ?? '',
      name: m['name']?.toString() ?? '',
      department: m['department']?.toString() ?? '',
      avatarAsset: m['avatar']?.toString() ?? m['avatar_asset']?.toString(),
      employeeCode: m['employee_code']?.toString() ?? m['employeeCode']?.toString(),
      heroTitle: m['hero_title']?.toString() ?? m['heroTitle']?.toString(),
      kudosReceived: _int(m['kudos_received'] ?? m['kudosReceived']),
      kudosSent: _int(m['kudos_sent'] ?? m['kudosSent']),
      badges: _stringList(m['badges']),
    );
  }

  static int _int(dynamic v) {
    if (v is int) return v;
    if (v is num) return v.toInt();
    return int.tryParse(v?.toString() ?? '') ?? 0;
  }

  static List<String> _stringList(dynamic raw) {
    if (raw is! List) return [];
    return raw.map((e) => e.toString()).toList();
  }
}
