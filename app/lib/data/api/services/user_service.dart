import 'package:dio/src/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:sage/data/api/service.dart';

@injectable
class UserService extends Service {
  UserService(Dio dio) : super(dio);
}
