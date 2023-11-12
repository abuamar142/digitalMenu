import 'package:intl/intl.dart';

var formatter = NumberFormat('#,###,###,###,###');

String formattedNumber(int number) {
  String result = formatter.format(number);
  return result;
}