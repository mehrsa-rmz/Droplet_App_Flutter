import 'package:cloud_firestore/cloud_firestore.dart';

class ProductReviewModel {
  final String id;
  final String userId;
  final String productId;
  final double rating;
  final String? comment;
  final DateTime timestamp;

  ProductReviewModel({
    required this.id,
    required this.userId,
    required this.productId,
    required this.rating,
    required this.timestamp,
    this.comment,
  });

  /// Create Empty func for clean code
  static ProductReviewModel empty() => ProductReviewModel(id: '', userId: '', productId: '', rating: 5, timestamp: DateTime.now());

  // Convert to JSON structure for Firebase
  Map<String, dynamic> toJson() {
    return{
      'specialistReviewId': id,
      'productId': productId,
      'customerId': userId,
      'rating': rating,
      'comment': comment,
      'timestamp': timestamp,
    };
  }

  /// Map Json oriented document snapshot from Firebase to Model
  factory ProductReviewModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return ProductReviewModel(
        id: document.id, 
        productId: data['productId'] as String,
        userId: data['customerId'] as String,
        rating: data['rating'] as double,
        timestamp: data['timestamp'] as DateTime,
        comment: data['comment'] as String,
        );
    } else {
      return ProductReviewModel.empty();
    }
  }
}
