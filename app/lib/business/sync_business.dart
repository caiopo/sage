import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:sage/business/business.dart';
import 'package:sage/data/api/services/survey_service.dart';
import 'package:sage/data/daos/survey_dao.dart';

enum SyncStatus {
  connecting,
  sending,
  receiving,
  successful,
  failed,
}

class SyncSummary {
  final SyncStatus status;
  final int sentAnswers;
  final int receivedSurveys;
  final int failedSend;
  final int failedReceive;

  SyncSummary({
    @required this.status,
    this.sentAnswers = 0,
    this.receivedSurveys = 0,
    this.failedSend = 0,
    this.failedReceive = 0,
  });

  @override
  String toString() {
    return 'SyncSummary($status)';
  }
}

@injectable
class SyncBusiness extends Business {
  final SurveyService _surveyService;
  final SurveyDao _surveyDao;

  SyncBusiness(this._surveyService, this._surveyDao);

  Stream<SyncSummary> synchronize() async* {
    yield SyncSummary(status: SyncStatus.connecting);

    final surveyUuids = await _surveyService.surveyUuids();

    if (surveyUuids.hasError) {
      yield SyncSummary(status: SyncStatus.failed);
      return;
    }

    print(surveyUuids.data);

    for (final uuid in surveyUuids.data) {
      final result = await _surveyService.getByUuid(uuid);

      if (result.hasData) {
        await _surveyDao.insert(result.data);
      }
    }
  }
}
