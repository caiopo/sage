import 'package:dio/src/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:sage/data/api/service.dart';
import 'package:sage/data/db.dart';
import 'package:sage/utils/result.dart';

@injectable
class AnswerService extends Service {
  AnswerService(Dio dio) : super(dio);

  Future<Result<Survey>> send(Answer answer) async {
    return null;
  }
}
