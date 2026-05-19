import 'package:saa2025/pages/awards/awards_models.dart';

abstract class AwardsRepository {
  Future<List<AwardItem>> fetchAwards();
}
