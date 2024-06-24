import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application/features/appointments/models/specialist_model.dart';
import 'package:flutter_application/features/profile/models/user_model.dart';

class AppointmentModel {
  final String id;
  final UserModel user;
  final SpecialistModel specialist;
  DateTime timestamp;
  String location;

  AppointmentModel({
    required this.id,
    required this.user,
    required this.specialist,
    required this.timestamp,
    required this.location,
  });

  /// Create Empty func for clean code
  static AppointmentModel empty() => AppointmentModel(id: '', user: UserModel.empty(), specialist: SpecialistModel.empty(), timestamp: DateTime.now(), location: '');

  // Convert to JSON structure for Firebase
  Map<String, dynamic> toJson() {
    return{
      'itemID': id,
      'specialistId': specialist.id,
      'customerId': user.id,
      'appointmentTimestamp': timestamp,
      'appointmnentLocation': location
    };
  }

  /// Map Json oriented document snapshot from Firebase to Model
  static Future<AppointmentModel> fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) async {
    if (document.data() != null) {
      final data = document.data()!;
      final userId = data['customerId'] as String;
      final ingredientId = data['ingredientId'] as String;
      // Fetch user document
      final userDoc = await FirebaseFirestore.instance
          .collection('Customers')
          .doc(userId)
          .get();
      final user = UserModel.fromSnapshot(userDoc);

      // Fetch specialist document
      final specialistDoc = await FirebaseFirestore.instance
          .collection('Specialists')
          .doc(ingredientId)
          .get();
      final specialist = SpecialistModel.fromSnapshot(specialistDoc);

      return AppointmentModel(
        id: document.id, 
        specialist: specialist,
        user: user,
        timestamp: data['appointmentTimestamp'] as DateTime,
        location: data['appointmnentLocation'] as String,
        );
    } else {
      return AppointmentModel.empty();
    }
  }
}
