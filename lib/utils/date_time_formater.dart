import 'package:shamsi_date/shamsi_date.dart';
import 'package:intl/intl.dart';

(String, String) date_convert_to(String value) {
  DateTime dateTime = DateTime.parse(value);
  Jalali jalali = Jalali.fromDateTime(dateTime);
  String hour_min = DateFormat("HH:mm").format(dateTime);
  return ('${jalali.year}/${jalali.month}/${jalali.day} ', hour_min);
}
