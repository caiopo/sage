import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DioModule {
  @injectable
  Dio get dio => Dio(
        BaseOptions(
          baseUrl: 'https://sage-survey.herokuapp.com',
          followRedirects: true,
          queryParameters: {
//            'token': inject<IdTokenResult>().token,
          },
        ),
      );
}
