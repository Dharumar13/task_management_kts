import 'package:intl/intl.dart';

String currentDateToFormat() {
  DateTime now = DateTime.now();
  // String formattedDate = DateFormat.yMMMEd().format(now);
  String formattedDate = DateFormat('yyyy-MM-ddd HH:mm').format(now);
  return formattedDate;
}

String stringToDateFormat(
    {required String fromFormat,
    required String toFormat,
    required String dateSting}) {
  DateFormat dateFormat = DateFormat(fromFormat);
  DateTime dateTime = dateFormat.parse(dateSting);
  String formattedDate = DateFormat(toFormat).format(dateTime);
  return formattedDate;
}

/*
String stringToDateFormat(String fromFormat, String toFormat, String dateSting) {
  DateTime now = DateTime.now();
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  DateTime dateTime = dateFormat.parse("2019-07-19 8:40:23");
  String formattedDate = DateFormat('yyyy-MM-ddd HH:mm').format(dateTime);
  return formattedDate;
}
 */
