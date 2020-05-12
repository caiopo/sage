import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:sage/di/di.dart';

@registerModule
abstract class DioModule {
  @injectable
  Dio get dio => Dio(
        BaseOptions(
          baseUrl: '',
          queryParameters: {
            'token': inject<IdTokenResult>().token,
          },
        ),
      );
}
