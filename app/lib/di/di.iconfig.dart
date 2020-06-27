// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:sage/business/answer_business.dart';
import 'package:sage/viewmodels/answer_viewmodel.dart';
import 'package:sage/data/db.dart';
import 'package:sage/data/api/settings.dart';
import 'package:dio/dio.dart';
import 'package:sage/business/question_business.dart';
import 'package:sage/viewmodels/question_create_viewmodel.dart';
import 'package:sage/viewmodels/survey_create_viewmodel.dart';
import 'package:sage/data/daos/survey_dao.dart';
import 'package:sage/data/repositories/survey_repository.dart';
import 'package:sage/data/api/services/survey_service.dart';
import 'package:sage/business/sync_business.dart';
import 'package:sage/data/api/services/user_service.dart';
import 'package:sage/data/api/services/answer_service.dart';
import 'package:sage/viewmodels/home_viewmodel.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  final dioModule = _$DioModule();
  g.registerFactory<AnswerBusiness>(() => AnswerBusiness());
  g.registerFactory<AnswerViewModel>(
      () => AnswerViewModel(g<AnswerBusiness>()));
  g.registerFactory<Dio>(() => dioModule.dio);
  g.registerFactory<QuestionBusiness>(() => QuestionBusiness());
  g.registerFactory<QuestionCreateViewModel>(
      () => QuestionCreateViewModel(g<QuestionBusiness>()));
  g.registerFactory<SurveyCreateViewModel>(
      () => SurveyCreateViewModel(g<QuestionBusiness>()));
  g.registerFactory<SurveyDao>(() => SurveyDao(g<AppDatabase>()));
  g.registerFactory<SurveyRepository>(() => SurveyRepository(g<SurveyDao>()));
  g.registerFactory<SurveyService>(() => SurveyService(g<Dio>()));
  g.registerFactory<SyncBusiness>(
      () => SyncBusiness(g<SurveyService>(), g<SurveyDao>()));
  g.registerFactory<UserService>(() => UserService(g<Dio>()));
  g.registerFactory<AnswerService>(() => AnswerService(g<Dio>()));
  g.registerFactory<HomeViewModel>(() => HomeViewModel(g<SurveyRepository>()));

  //Eager singletons must be registered in the right order
  g.registerSingleton<AppDatabase>(AppDatabase());
}

class _$DioModule extends DioModule {}
