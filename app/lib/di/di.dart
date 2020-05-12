import 'package:sage/di/di.iconfig.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final inject = GetIt.instance;

@injectableInit
void configureDependencies() {
  $initGetIt(inject);

  // runs only if compiled in debug mode
  assert(() {
    inject<Dio>().interceptors.add(PrettyDioLogger(responseBody: false));
    return true;
  }());
}
