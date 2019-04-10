import 'package:gaia/api/endpoints.dart';
import 'package:gaia/api/utils.dart';
import 'package:gaia/models/models.dart';

Future<List<Survey>> fetchSurveyList() async {
  final body = await getWithAuth(Endpoints.surveyList());

  List<dynamic> content = body['content'] as List<dynamic>;

  return content
      .map((s) => Survey.fromJson(s as Map<String, dynamic>))
      .toList();
}

Future<Survey> createSurvey(String title) async {
  final body = await postWithAuth(Endpoints.surveyRoot(), {'title': title});

  return Survey.fromJson(body);
}
