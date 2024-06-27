import 'package:cloud_firestore/cloud_firestore.dart';

class SpecialistReviewModel {
  final String id;
  final String specialistId;
  final String userId;
  final int rating;
  final String? message;
  final String dateTime;

  SpecialistReviewModel({
    required this.id,
    required this.specialistId,
    required this.userId,
    required this.rating,
    required this.dateTime,
    this.message,
  });

  /// Create Empty func for clean code
  static SpecialistReviewModel empty() => SpecialistReviewModel(id: '', userId: '', specialistId: '', rating: 5, dateTime: '', message: '');
  
  // Convert to JSON structure for Firebase
  Map<String, dynamic> toJson() {
    return{
      'itemID': id,
      'specialistId': specialistId,
      'customerId': userId,
      'specialistReviewRating': rating,
      'specialistReviewMessage': message,
      'specialistReviewDateTime': dateTime,
    };
  }

  /// Map Json oriented document snapshot from Firebase to Model
  static Future<SpecialistReviewModel> fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) async {
    if (document.data() != null) {
      final data = document.data()!;
        return SpecialistReviewModel(
        id: document.id,
        userId: data['customerId'] as String,
        specialistId: data['specialistId'] as String,
        rating: data['specialistReviewRating'] as int,
        dateTime: data['specialistReviewDateTime'] as String,
        message: data['specialistReviewMessage'] as String,
      );
    } else {
      return SpecialistReviewModel.empty();
    }
  }
}
