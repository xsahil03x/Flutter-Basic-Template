import 'date_time_extension.dart';

const _ALERT_DATE_FORMAT = 'hh:mm aa, dd MMM yyyy';

extension StringX on String {
  String _restrictFractionalSeconds(String dateTime) =>
      dateTime.replaceFirstMapped(RegExp("(\\.\\d{6})\\d+"), (m) => m[1]);

  DateTime isoToDateTime() {
    if (this != null && this.length > 0)
      return DateTime.parse(_restrictFractionalSeconds(this));
    return DateTime.now();
  }

  String isoToUiDateString({String dateFormat = _ALERT_DATE_FORMAT}) =>
      this.isoToDateTime().toDateString(dateFormat: dateFormat);
}
