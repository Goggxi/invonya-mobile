import 'package:intl/intl.dart';

extension ExtDateFormat on DateTime {
  String get toCustomFormat {
    return DateFormat("dd MMMM yyyy", "id").format(this);
  }
}
