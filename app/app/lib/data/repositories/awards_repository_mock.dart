import 'package:saa2025/data/repositories/awards_repository.dart';
import 'package:saa2025/pages/awards/awards_mock_data.dart';
import 'package:saa2025/pages/awards/awards_models.dart';

class AwardsRepositoryMock implements AwardsRepository {
  @override
  Future<List<AwardItem>> fetchAwards() async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    return AwardsMockData.awards;
  }
}
