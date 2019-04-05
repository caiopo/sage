final ENDPOINT = Uri.http('10.0.2.2:5000', '');

class Endpoints {
  static Uri surveyList() {
    return ENDPOINT.replace(path: '/surveys/list');
  }
}
