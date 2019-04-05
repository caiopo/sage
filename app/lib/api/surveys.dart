import 'package:gaia/api/endpoints.dart';
import 'package:gaia/api/utils.dart';
import 'package:gaia/models/models.dart';

Future<Survey> fetchSurveyList() async {
  final body = await getWithAuth(Endpoints.surveyList());

  return Survey.fromJson(body);
}
