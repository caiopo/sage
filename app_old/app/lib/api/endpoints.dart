final ENDPOINT = Uri.http('10.0.2.2:5000', '');

class Endpoints {
  static Uri surveyRoot() {
    return ENDPOINT.replace(path: '/surveys/');
  }

  static Uri surveyList() {
    return ENDPOINT.replace(path: '/surveys/list');
  }

  static Uri surveyDetail(int surveyId) {
    return ENDPOINT.replace(path: '/surveys/${surveyId}');
  }
}
