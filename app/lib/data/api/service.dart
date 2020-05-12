import 'package:sage/utils/exceptions.dart';
import 'package:sage/utils/result.dart';
import 'package:dio/dio.dart';

class Service {
  final Dio dio;

  Service(this.dio);

  Future<Result<Map<String, dynamic>>> get(
    String path, {
    Map<String, dynamic> query,
    Options options,
  }) async {
    try {
      final response = await dio.get<Map<String, dynamic>>(
        path,
        queryParameters: query,
        options: options,
      );

      return Result.data(response.data);
    } on Exception catch (e) {
      return Result.error(ServiceException(e));
    }
  }
}

class ServiceException extends AppException {
  final Exception cause;

  ServiceException(this.cause);
}
