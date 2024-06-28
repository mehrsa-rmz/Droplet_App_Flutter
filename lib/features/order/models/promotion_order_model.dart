import 'package:cloud_firestore/cloud_firestore.dart';

class PromotionOrderModel {
  final String id;
  final String promotionId;
  final String orderId;

  PromotionOrderModel({
    required this.id,
    required this.promotionId,
    required this.orderId,
  });

  static PromotionOrderModel empty() => PromotionOrderModel(id: '', promotionId: '', orderId: '');
  
  // Convert to JSON structure for Firebase
  Map<String, dynamic> toJson() {
    return{
      'itemID': id,
      'promotionId': promotionId,
      'orderId': orderId
    };
  }

  // Create a model from Firebase document
   static Future<PromotionOrderModel> fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) async {
    if (document.data() != null) {
      final data = document.data()!;
      return PromotionOrderModel(
        id: document.id,
        promotionId: data['promotionId'] as String,
        orderId: data['orderId'] as String
        );
    } else {
      return PromotionOrderModel.empty();
    }
  }

}