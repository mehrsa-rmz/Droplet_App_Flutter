import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentModel {
  final String id;
  final String userId;
  final String specialistId;
  String dateTime;
  String location;

  AppointmentModel({
    required this.id,
    required this.userId,
    required this.specialistId,
    required this.dateTime,
    required this.location,
  });

  /// Create Empty func for clean code
  static AppointmentModel empty() => AppointmentModel(id: '', userId: '', specialistId: '', dateTime: '', location: '');

  // Convert to JSON structure for Firebase
  Map<String, dynamic> toJson() {
    return{
      'itemID': id,
      'specialistId': specialistId,
      'customerId': userId,
      'appointmentDateTime': dateTime,
      'appointmnentLocation': location
    };
  }

  /// Map Json oriented document snapshot from Firebase to Model
  static Future<AppointmentModel> fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) async {
    final data = document.data()!;
    return AppointmentModel(
      id: document.id, 
      specialistId: data['specialistId'] ?? '',
      userId: data['customerId'] ?? '',
      dateTime: data['appointmentDateTime'] ?? '',
      location: data['appointmnentLocation'] ?? '',
    );
  }
}
