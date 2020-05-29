import 'package:dio/src/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:sage/data/api/service.dart';

@injectable
class AnswerService extends Service {
  AnswerService(Dio dio) : super(dio);
}
