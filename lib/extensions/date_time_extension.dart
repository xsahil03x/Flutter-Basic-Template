import 'package:intl/intl.dart';

const _DISPLAY_DATE_FORMAT = 'EEE, dd-MMM-yyyy';

extension DateTimeX on DateTime {
  String toDateString({String dateFormat}) {
    if (this == null) return '-';
    final formatter = DateFormat(dateFormat);
    return formatter.format(this);
  }

  String toApiDateString() => toDateString(dateFormat: 'MM-dd-yyyy');

  String toUiDateString() => toDateString(dateFormat: _DISPLAY_DATE_FORMAT);
}
