// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:sage/data/db.dart';
import 'package:dio/dio.dart';
import 'package:sage/data/api/settings.dart';
import 'package:sage/viewmodels/survey_create_viewmodel.dart';
import 'package:sage/data/api/services/answer_service.dart';
import 'package:sage/data/api/services/survey_service.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  final dioModule = _$DioModule();
  g.registerFactory<Dio>(() => dioModule.dio);
  g.registerFactory<SurveyCreateViewModel>(() => SurveyCreateViewModel());
  g.registerFactory<SurveyService>(() => SurveyService(g<Dio>()));
  g.registerFactory<AnswerService>(() => AnswerService(g<Dio>()));

  //Eager singletons must be registered in the right order
  g.registerSingleton<AppDatabase>(AppDatabase());
}

class _$DioModule extends DioModule {}
