import 'package:intl/intl.dart';

class TFormatter {
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    
    String daySuffix(int day) {
      if (day >= 11 && day <= 13) {
        return 'th';
      }
      switch (day % 10) {
        case 1:
          return 'st';
        case 2:
          return 'nd';
        case 3:
          return 'rd';
        default:
          return 'th';
      }
    }

    String day = DateFormat('d').format(date);
    String month = DateFormat('MMMM').format(date);
    String year = DateFormat('yyyy').format(date);
    
    return '$month $day${daySuffix(int.parse(day))} $year';
  }

  static String formatTimestamp(int timestamp) {
    // Convert timestamp to DateTime
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);

    // Format DateTime to YYYY-MM-DD
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    String formattedDate = dateFormat.format(dateTime);

    return formattedDate;
  }

  static String formatPhoneNumber(String phoneNumber) {
    return '(${phoneNumber.substring(0,3)}) ${phoneNumber.substring(4,6)} ${phoneNumber.substring(7)}';
  }

  static int convertStringToTimestamp(String dateStr) {
    // Parse the string to DateTime
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    DateTime dateTime = dateFormat.parse(dateStr);

    // Convert DateTime to timestamp (in seconds since epoch)
    int timestamp = dateTime.millisecondsSinceEpoch ~/ 1000;

    return timestamp;
  }
}