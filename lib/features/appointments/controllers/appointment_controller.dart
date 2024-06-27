import 'package:get/get.dart';
// controller: TextEditingController(
//     text: DateFormat('dd MMMM yyyy')
//         .format(_dates[0]!)),
// TODO: extragere dropdown din inputs si pus direct in codul de appointments

class AppointmentController extends GetxController{
  static AppointmentController get instance => Get.find();

  // Variables
  String userId = '';
  String specialistId = '';
  String location = '';
  String appointmentDateTime = '';
}