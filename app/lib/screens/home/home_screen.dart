import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gaia/api/surveys.dart';
import 'package:gaia/models/models.dart';
import 'package:gaia/screens/home/survey_list.dart';
import 'package:gaia/utils/hooks.dart';

class HomeScreen extends HookWidget {
  final Future<FirebaseUser> user = FirebaseAuth.instance.currentUser();

  @override
  Widget build(BuildContext context) {
    final snapshot = useCurrentUser();
    final surveyList = useState(<Survey>[]);
    final selectedItem = useState<Survey>(null);

    final refreshSurveys = () async {
      surveyList.value = await fetchSurveyList();
    };

    useAsyncEffect(refreshSurveys, []);

    final onSurveyPressed = (Survey survey) {};

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: snapshot.hasData
            ? <Widget>[
                IconButton(
                  icon: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      snapshot.data.providerData.first.photoUrl,
                    ),
                  ),
                  onPressed: () async {},
                )
              ]
            : null,
      ),
      body: SurveyList(
        data: surveyList.value,
        onRefresh: refreshSurveys,
        onSurveyPressed: onSurveyPressed,
      ),
    );
  }
}
