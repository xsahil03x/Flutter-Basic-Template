import 'package:intl/intl.dart';

const displayDateFormat = 'EEE, dd-MMM-yyyy';
const alertDateFormat = 'hh:mm aa, dd MMM yyyy';

class FormatHelpers {
  static String toDateString(DateTime date, {String format = 'dd-MMM-yyyy'}) {
    if (date == null) return "-";
    var formatter = new DateFormat(format);
    return formatter.format(date);
  }

  static String toApiDateString(DateTime date) =>
      toDateString(date, format: 'MM-dd-yyyy');

  static String toUiDateString(DateTime date) =>
      toDateString(date, format: displayDateFormat);

  static DateTime isoToDateTime(String isoDate) {
    if (isoDate != null && isoDate.length > 0)
      return DateTime.parse(_restrictFractionalSeconds(isoDate));
    return DateTime.now();
  }

  static String isoUiDateString(String isoDate,
          {String format = alertDateFormat}) =>
      toDateString(isoToDateTime(isoDate), format: format);

  static String _restrictFractionalSeconds(String dateTime) =>
      dateTime.replaceFirstMapped(RegExp("(\\.\\d{6})\\d+"), (m) => m[1]);

  static String toCurrency(double value, {String symbol = '₹ '}) {
    var formatter = NumberFormat.currency(symbol: symbol);
    var postFix = "";
    value = value ?? 0;
    return formatter.format(value ?? 0) + postFix;
  }

  static String toDecimal(double value, {int places = 2}) {
    var formatter = NumberFormat.decimalPattern();
    value = value ?? 0;
    return formatter.format(value ?? 0);
  }

  static String toInt(double qty) {
    return qty.round().toString();
  }

  static String toPercent(double qty) {
    var formatter = NumberFormat.percentPattern();
    return formatter.format(qty).toString();
  }
}
