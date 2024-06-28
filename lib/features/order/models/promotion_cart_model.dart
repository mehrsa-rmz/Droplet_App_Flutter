import 'package:cloud_firestore/cloud_firestore.dart';

class PromotionCartModel {
  final String id;
  final String promotionId;
  final String cartId;

  PromotionCartModel({
    required this.id,
    required this.promotionId,
    required this.cartId,
  });

  static PromotionCartModel empty() => PromotionCartModel(id: '', promotionId: '', cartId: '');
  
  // Convert to JSON structure for Firebase
  Map<String, dynamic> toJson() {
    return{
      'itemID': id,
      'promotionId': promotionId,
      'cartId': cartId
    };
  }

  // Create a model from Firebase document
   static Future<PromotionCartModel> fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) async {
    if (document.data() != null) {
      final data = document.data()!;
      return PromotionCartModel(
        id: document.id,
        promotionId: data['promotionId'] as String,
        cartId: data['cartId'] as String
        );
    } else {
      return PromotionCartModel.empty();
    }
  }

}