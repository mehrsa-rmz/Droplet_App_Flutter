import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteModel {
  final String id;
  final String productId;
  final String userId;

  FavoriteModel({
    required this.id,
    required this.productId,
    required this.userId,
  });

  static FavoriteModel empty() => FavoriteModel(id: '', userId: '', productId: '');

  // Convert to JSON structure for Firebase
  Map<String, dynamic> toJson() {
    return{
      'itemID': id,
      'customerId': userId,
      'productId': productId,
    };
  }

  // Create a model from Firebase document
  static Future<FavoriteModel> fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) async {
    if (document.data() != null) {
      final data = document.data()!;
        return FavoriteModel(
        id: document.id,
        userId: data['customerId'] as String,
        productId: data['productId'] as String,
      );
    } else {
      return FavoriteModel.empty();
    }
  }
}
