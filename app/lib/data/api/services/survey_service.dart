import 'package:dio/src/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:sage/data/api/serializers/survey_serializer.dart';
import 'package:sage/data/api/service.dart';
import 'package:sage/data/db.dart';
import 'package:sage/data/utils/extract.dart';
import 'package:sage/utils/result.dart';

@injectable
class SurveyService extends Service {
  SurveyService(Dio dio) : super(dio);

  Future<Result<List<String>>> surveyUuids() async {
    final response = await get('/surveys/');

    return response.map((d) => extract<String>(
          d,
          {
            'content': [
              {
                'uuid': (s) => s,
              }
            ]
          },
        ));
  }

  Future<Result<SurveyWithQuestions>> getByUuid(String uuid) async {
    final response = await get('/surveys/$uuid');

    return response.map((d) => SurveySerializer().from(d));
  }

  Future<Result<Survey>> create(SurveyWithQuestions surveyWithQuestions) async {
    final response = await post(
      '/surveys',
      body: SurveySerializer().to(surveyWithQuestions),
    );

    return null;
  }
}
