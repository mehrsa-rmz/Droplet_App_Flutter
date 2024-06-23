import 'package:cloud_firestore/cloud_firestore.dart';

class SpecialistReviewModel {
  final String id;
  final String userId;
  final String specialistId;
  final double rating;
  final String? comment;
  final DateTime timestamp;

  SpecialistReviewModel({
    required this.id,
    required this.userId,
    required this.specialistId,
    required this.rating,
    required this.timestamp,
    this.comment,
  });

  /// Create Empty func for clean code
  static SpecialistReviewModel empty() => SpecialistReviewModel(id: '', userId: '', specialistId: '', rating: 5, timestamp: DateTime.now());

  // Convert to JSON structure for Firebase
  Map<String, dynamic> toJson() {
    return{
      'specialistReviewId': id,
      'specialistId': specialistId,
      'customerId': userId,
      'rating': rating,
      'comment': comment,
      'timestamp': timestamp,
    };
  }

  /// Map Json oriented document snapshot from Firebase to Model
  factory SpecialistReviewModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return SpecialistReviewModel(
        id: document.id, 
        specialistId: data['specialistId'] as String,
        userId: data['customerId'] as String,
        rating: data['rating'] as double,
        timestamp: data['timestamp'] as DateTime,
        comment: data['comment'] as String,
        );
    } else {
      return SpecialistReviewModel.empty();
    }
  }
}
