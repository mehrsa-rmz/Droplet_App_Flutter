import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application/features/appointments/models/specialist_model.dart';
import 'package:flutter_application/features/profile/models/user_model.dart';

class SpecialistReviewModel {
  final String id;
  final UserModel user;
  final SpecialistModel specialist;
  final double rating;
  final String? message;
  final DateTime timestamp;

  SpecialistReviewModel({
    required this.id,
    required this.user,
    required this.specialist,
    required this.rating,
    required this.timestamp,
    this.message,
  });

  /// Create Empty func for clean code
  static SpecialistReviewModel empty() => SpecialistReviewModel(id: '', user: UserModel.empty(), specialist: SpecialistModel.empty(), rating: 5, timestamp: DateTime.now(), message: '');

  // Convert to JSON structure for Firebase
  Map<String, dynamic> toJson() {
    return{
      'itemID': id,
      'specialistId': specialist.id,
      'customerId': user.id,
      'specialistReviewRating': rating,
      'specialistReviewMessage': message,
      'specialistReviewTimestamp': timestamp,
    };
  }

  /// Map Json oriented document snapshot from Firebase to Model
  static Future<SpecialistReviewModel> fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) async {
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

      return SpecialistReviewModel(
        id: document.id, 
        specialist: specialist,
        user: user,
        rating: data['specialistReviewRating'] as double,
        timestamp: data['specialistReviewTimestamp'] as DateTime,
        message: data['specialistReviewMessage'] as String,
        );
    } else {
      return SpecialistReviewModel.empty();
    }
  }
}
