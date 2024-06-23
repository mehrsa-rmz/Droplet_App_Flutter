import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteModel {
  final String id;
  final String userId;
  final String productId;

  FavoriteModel({
    required this.id,
    required this.userId,
    required this.productId,
  });

  /// Create Empty func for clean code
  static FavoriteModel empty() => FavoriteModel(id: '', userId: '', productId: '');


  /// Convert model to Json structure so that you can store data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'appointmentId': id,
      'customerId': userId,
      'productId': productId,
    };
  }

  /// Convert model from Json structure so that you can take data in Firebase
  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: json['appointmentId'],
      userId: json['customerId'],
      productId: json['productId'],
    );
  }

  /// Map Json oriented document snapshot from Firebase to UserModel
  factory FavoriteModel.fromSnapshot(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;

    // Map JSON Record to the Model
    return FavoriteModel(
      id: document.id,
      userId: data['customerId'] as String,
      productId: data['productId'] as String,
    );
  }
}
