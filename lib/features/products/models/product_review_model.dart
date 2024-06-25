import 'package:cloud_firestore/cloud_firestore.dart';

class ProductReviewModel {
  final String id;
  // final UserModel user;
  // final ProductModel product;
  final String productId;
  final String userId;
  final int rating;
  final String? message;
  final String timestamp;

  ProductReviewModel({
    required this.id,
    // required this.user,
    // required this.product,
    required this.productId,
    required this.userId,
    required this.rating,
    required this.timestamp,
    this.message,
  });

  /// Create Empty func for clean code
  //static ProductReviewModel empty() => ProductReviewModel(id: '', user: UserModel.empty(), product: ProductModel.empty(), rating: 5, timestamp: DateTime.now(), message: '');
  static ProductReviewModel empty() => ProductReviewModel(id: '', userId: '', productId: '', rating: 5, timestamp: '', message: '');

  // String getProductId(){
  //   return product.id.toString();
  // }

  // String getUserId(){
  //   return user.id.toString();
  // }
  
  // Convert to JSON structure for Firebase
  Map<String, dynamic> toJson() {
    return{
      'itemID': id,
      'productId': productId,
      'customerId': userId,
      'productReviewRating': rating,
      'productReviewMessage': message,
      'productReviewTimestamp': timestamp,
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
        timestamp: data['productReviewTimestamp'] as String,
        message: data['productReviewMessage'] as String,
      );
    } else {
      return ProductReviewModel.empty();
    }
  }
}
