import 'package:cloud_firestore/cloud_firestore.dart';

class ProductReviewModel {
  final String id;
  final String productId;
  final String userId;
  final int rating;
  final String? message;
  final String dateTime;

  ProductReviewModel({
    required this.id,
    required this.productId,
    required this.userId,
    required this.rating,
    required this.dateTime,
    this.message,
  });

  /// Create Empty func for clean code
  static ProductReviewModel empty() => ProductReviewModel(id: '', userId: '', productId: '', rating: 5, dateTime: '', message: '');
  
  // Convert to JSON structure for Firebase
  Map<String, dynamic> toJson() {
    return{
      'itemID': id,
      'productId': productId,
      'customerId': userId,
      'productReviewRating': rating,
      'productReviewMessage': message,
      'productReviewDateTime': dateTime,
    };
  }

  /// Map Json oriented document snapshot from Firebase to Model
  static Future<ProductReviewModel> fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) async {
    if (document.data() != null) {
      final data = document.data()!;
      return ProductReviewModel(
        id: document.id,
        userId: data['customerId'] as String,
        productId: data['productId'] as String,
        rating: data['productReviewRating'] as int,
        dateTime: data['productReviewDateTime'] as String,
        message: data['productReviewMessage'] as String,
      );
    } else {
      return ProductReviewModel.empty();
    }
  }
}
