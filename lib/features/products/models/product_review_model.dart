import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application/features/products/models/product_model.dart';
import 'package:flutter_application/features/profile/models/user_model.dart';

class ProductReviewModel {
  final String id;
  final UserModel user;
  final ProductModel product;
  final double rating;
  final String? message;
  final DateTime timestamp;

  ProductReviewModel({
    required this.id,
    required this.user,
    required this.product,
    required this.rating,
    required this.timestamp,
    this.message,
  });

  String get productId => product.id;

  /// Create Empty func for clean code
  static ProductReviewModel empty() => ProductReviewModel(
    id: '', 
    user: UserModel.empty(), 
    product: ProductModel.empty(), 
    rating: 5, 
    timestamp: DateTime.now(), 
    message: ''
  );

  // Convert to JSON structure for Firebase
  Map<String, dynamic> toJson() {
    return {
      'itemID': id,
      'productId': product.id,
      'customerId': user.id,
      'productReviewRating': rating,
      'productReviewMessage': message,
      'productReviewTimestamp': timestamp,
    };
  }

  /// Map Json oriented document snapshot from Firebase to Model
  static Future<ProductReviewModel> fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) async {
    if (document.data() != null) {
      final data = document.data()!;
      final userId = data['customerId'] as String;
      final productId = data['productId'] as String;
      // Fetch user document
      final userDoc = await FirebaseFirestore.instance
          .collection('Customers')
          .doc(userId)
          .get();
      final user = UserModel.fromSnapshot(userDoc);

      // Fetch product document
      final productDoc = await FirebaseFirestore.instance
          .collection('Products')
          .doc(productId)
          .get();
      final product = ProductModel.fromSnapshot(productDoc);

      return ProductReviewModel(
        id: document.id,
        product: product,
        user: user,
        rating: data['productReviewRating'] as double,
        timestamp: (data['productReviewTimestamp'] as Timestamp).toDate(),
        message: data['productReviewMessage'] as String,
      );
    } else {
      return ProductReviewModel.empty();
    }
  }
}
