import 'package:intl/intl.dart';

class TFormatter {
  static String formatDate(DateTime date){
    return DateFormat('dd-MM-yyyy').format(date);
  }

  static DateTime dateFromString(String date){
    return DateFormat('dd-MM-yyyy').parse(date);
  }

  static String formatAppointmentDate(DateTime date){
    return DateFormat('yyyy-MM-dd HH:mm').format(date);
  }

  static DateTime appointmentDateFromString(String date){
    return DateFormat('yyyy-MM-dd HH:mm').parse(date);
  }

  static String formatDateSpecial(DateTime date) {
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

  static String formatPhoneNumber(String phoneNumber) {
    return '(${phoneNumber.substring(0,3)}) ${phoneNumber.substring(4,6)} ${phoneNumber.substring(7)}';
  }
}