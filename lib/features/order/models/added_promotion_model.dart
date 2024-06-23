import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application/features/order/models/promotion_model.dart';

class AddedPromotionModel {
  final String id;
  final PromotionModel promotion;
  double? priceDeduction;

  AddedPromotionModel({
    required this.id,
    required this.promotion,
    this.priceDeduction
  });

  /// Create Empty func for clean code
  static AddedPromotionModel empty() => AddedPromotionModel(id: '', promotion: PromotionModel.empty(), priceDeduction: 0);


  /// Convert model to Json structure so that you can store data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'addedPromotionId': id,
      'promotion': promotion.toJson(),
      'priceDeduction': priceDeduction
    };
  }

  /// Convert model from Json structure so that you can take data in Firebase
  factory AddedPromotionModel.fromJson(Map<String, dynamic> json) {
    return AddedPromotionModel(
      id: json['promotionId'] as String,
      promotion: PromotionModel.fromJson(json['promotion'] as Map<String, dynamic>),
      priceDeduction: json['priceDeduction'] as double
    );
  }

  /// Map Json oriented document snapshot from Firebase to UserModel
  factory AddedPromotionModel.fromSnapshot(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;

    // Map JSON Record to the Model
    return AddedPromotionModel(
      id: document.id,
      promotion: PromotionModel.fromJson(data['promotion'] as Map<String, dynamic>),
      priceDeduction: data['priceDeduction'] as double,
    );
  }
}
