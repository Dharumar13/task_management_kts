import 'package:intl/intl.dart';

String currentDateToFormat() {
  DateTime now = DateTime.now();
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


