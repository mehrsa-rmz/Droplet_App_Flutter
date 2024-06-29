import 'package:flutter/services.dart';
import 'package:flutter_application/features/appointments/models/appointment_model.dart';
import 'package:flutter_application/utils/formatters/formatter.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

/// Repository class for appointment-related operations.
class AppointmentRepository extends GetxController {
  static AppointmentRepository get instance => Get.put(AppointmentRepository());

  final FirebaseFirestore _db = FirebaseFirestore.instance;


  /// Function to save appointment data to Firestore.
  Future<void> saveAppointmentRecord(AppointmentModel appointment) async {
    try {
      await _db.collection("Appointments").doc(appointment.id).set(appointment.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Function to fetch appointment details based on appointment ID.
  Future<AppointmentModel> fetchAppointmentById(String id) async {
    try {
      final documentSnapshot = await _db.collection("Appointments").doc(id).get();
      if (documentSnapshot.exists) {
        return AppointmentModel.fromSnapshot(documentSnapshot);
      } else {
        return AppointmentModel.empty();
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Function to update appointment data in Firestore.
  Future<void> updateAppointmentDetails(AppointmentModel updatedAppointment) async {
    try {
      await _db.collection("Appointments").doc(updatedAppointment.id).update(updatedAppointment.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Function to fetch all AppointmentModel items
  Future<List<AppointmentModel>> fetchAllAppointments() async {
    try {
      final querySnapshot = await _db.collection("Appointments").get();
      List<AppointmentModel> productConditions = await Future.wait(
        querySnapshot.docs.map((doc) async {
          return await AppointmentModel.fromSnapshot(doc);
        }).toList()
      );
      return productConditions;
    } catch (e) {
      print("Error fetching product conditions: $e");
      return [];
    }
  }

  /// Function to fetch all future appointments for a user.
  Future<List<AppointmentModel>> fetchUserFutureAppointments(String userId) async {
    try {
      final querySnapshot = await _db.collection("Appointments")
        .where('customerId', isEqualTo: userId)
        .where('appointmentDateTime', isGreaterThanOrEqualTo: TFormatter.formatAppointmentDate(DateTime.now()))
        .get();

      List<AppointmentModel> futureAppointments = await Future.wait(
        querySnapshot.docs.map((doc) async {
          return await AppointmentModel.fromSnapshot(doc);
        }).toList()
      );
      return futureAppointments;
    } catch (e) {
      print("Error fetching future appointments: $e");
      return [];
    }
  }

  /// Function to fetch all past appointments for a user.
  Future<List<AppointmentModel>> fetchUserOldAppointments(String userId) async {
    try {
      final querySnapshot = await _db.collection("Appointments")
        .where('customerId', isEqualTo: userId)
        .where('appointmentDateTime', isLessThan: TFormatter.formatAppointmentDate(DateTime.now()))
        .get();

      List<AppointmentModel> oldAppointments = await Future.wait(
        querySnapshot.docs.map((doc) async {
          return await AppointmentModel.fromSnapshot(doc);
        }).toList()
      );
      return oldAppointments;
    } catch (e) {
      print("Error fetching old appointments: $e");
      return [];
    }
  }

  /// Function to fetch available timeslots for a given date and specialist.
  Future<List<String>> fetchAvailableTimeslots(DateTime datePicked, String specialistId) async {
    try {
      final startOfDay = DateTime(datePicked.year, datePicked.month, datePicked.day, 0, 0);
      final endOfDay = DateTime(datePicked.year, datePicked.month, datePicked.day, 23, 59);

      final querySnapshot = await _db.collection("Appointments")
        .where('specialistId', isEqualTo: specialistId)
        .where('appointmentDateTime', isGreaterThanOrEqualTo: TFormatter.formatAppointmentDate(startOfDay))
        .where('appointmentDateTime', isLessThanOrEqualTo: TFormatter.formatAppointmentDate(endOfDay))
        .get();

      Set<String> bookedTimes = querySnapshot.docs.map((doc) {
        return doc['appointmentDateTime'].toString().substring(11, 16);
      }).toSet();

      List<String> availableTimes = [
        '12:00', '12:30', '13:00', '13:30', '14:00', '14:30', 
        '15:00', '15:30', '16:00', '16:30', '17:00', '17:30', '18:00'
      ];

      availableTimes.removeWhere((time) => bookedTimes.contains(time));

      return availableTimes;
    } catch (e) {
      print("Error fetching available timeslots: $e");
      return [];
    }
  }

  // Function to check if a user went to appointment
  Future<bool> hasUserBeenToAppointment(String userId) async {
    try {
      final querySnapshot = await  _db.collection("Appointments").where('customerId', isEqualTo: userId).get();
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print("Error checking user appointment: $e");
      return false;
    }
  }
}