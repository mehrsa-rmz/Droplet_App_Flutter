import 'package:cloud_firestore/cloud_firestore.dart';

class PromotionModel {
  final String id;
  final int promotion;

  PromotionModel({
    required this.id,
    required this.promotion,
  });

  /// Create Empty func for clean code
  static PromotionModel empty() => PromotionModel(id: '', promotion: 0);


  /// Convert model to Json structure so that you can store data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'promotionId': id,
      'promotion': promotion,
    };
  }

  /// Convert model from Json structure so that you can take data in Firebase
  factory PromotionModel.fromJson(Map<String, dynamic> json) {
    return PromotionModel(
      id: json['promotionId'] as String,
      promotion: json['promotion'] as int,
    );
  }

  /// Map Json oriented document snapshot from Firebase to UserModel
  factory PromotionModel.fromSnapshot(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;

    // Map JSON Record to the Model
    return PromotionModel(
      id: document.id,
      promotion: data['promotion'] as int,
    );
  }
}
