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

//
//import 'dart:async';
//
//import 'package:chopper/chopper.dart';
//import 'package:gaia/models/models.dart';
//
//part 'surveys.chopper.dart';
//
//@ChopperApi(baseUrl: '/surveys')
//abstract class SurveyService extends ChopperService {
//  static SurveyService create([ChopperClient client]) => _$SurveyService(client);
//
//  @Post(path: '/')
//  Future<Response<Survey>> get();
//
//  @Get(path: '/list')
//  Future<Response<Survey>> me(@Query() String token);
//}
