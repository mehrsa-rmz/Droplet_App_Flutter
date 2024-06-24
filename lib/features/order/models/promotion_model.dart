import 'package:cloud_firestore/cloud_firestore.dart';

class PromotionModel {
  final String id;
  final int amount;

  PromotionModel({
    required this.id,
    required this.amount,
  });

  static PromotionModel empty() => PromotionModel(id: '', amount: 0);

  /// Convert model to Json structure so that you can store data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'itemID': id,
      'promotionAmount': amount,
    };
  }

  factory PromotionModel.fromJson(Map<String, dynamic> json) {
    return PromotionModel(
      id: json['itemID'],
      amount: json['promotionAmount'] as int
    );
  }

  /// Map Json oriented document snapshot from Firebase to UserModel
  factory PromotionModel.fromSnapshot(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;

    // Map JSON Record to the Model
    return PromotionModel(
      id: document.id,
      amount: data['promotionAmount'] as int,
    );
  }
}
