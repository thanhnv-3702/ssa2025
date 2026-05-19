import 'dart:async';
import 'dart:io';

import 'package:base_core/domain/repository/resource.dart';
import 'package:https/vn/sun/https/data/dto/saved_data_dto.dart';
import 'package:https/vn/sun/https/domain/repository/local_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class DBUseCase {
  final LocalRepository localRepo;

  DBUseCase(this.localRepo);

  StreamController controller = StreamController<Resource<bool>>();

  Stream get resourceStream => controller.stream;

  Stream<Resource<bool>> addQuestions(SavedDataDto q) async* {
    try {
      controller.sink.add(Loading());
      localRepo.addData(q);
      controller.sink.add(Success(true));
    } on RedirectException catch (e) {
      controller.sink.add(Failed(e, e.redirects[0].statusCode));
    } catch (e) {
      controller.sink.add(Exception(e));
    }
  }
}
