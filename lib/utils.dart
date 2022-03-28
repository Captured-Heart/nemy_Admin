
import 'package:intl/intl.dart';

class Utils {
  String dateFormatted() {
    var now = DateTime.now();

    var formatter = DateFormat(" d MMM, yyyy");
    String formatted = formatter.format(now);

    return formatted;
  }


}
