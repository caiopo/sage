import 'package:intl/intl.dart';

final _ddmmyyyyhhmm = DateFormat('dd/MM/yyyy HH.mm');

String formatDayMonthYearHourMinute(DateTime dateTime) {
  return _ddmmyyyyhhmm.format(dateTime).replaceFirst('.', 'h');
}
