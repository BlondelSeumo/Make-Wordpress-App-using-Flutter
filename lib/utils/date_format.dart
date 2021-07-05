import 'package:intl/intl.dart';

String formatDate({String date, String dateFormat = 'MMMM d, y', String locate = 'en_US'}) {
  DateTime _date = DateTime.parse(date);
  return DateFormat(dateFormat, 'en_US').format(_date);
}

bool compareSpaceDate({String date, int space = 30}) {
  DateTime _dateNow = DateTime.now();
  DateTime _date = DateTime.parse(date).add(Duration(days: space));
  return !_dateNow.isAfter(_date);
}
