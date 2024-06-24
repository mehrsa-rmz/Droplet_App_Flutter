import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application/features/order/models/order_model.dart';
import 'package:flutter_application/features/order/models/promotion_model.dart';

class PromotionOrderModel {
  final String id;
  final PromotionModel promotion;
  final OrderModel order;

  PromotionOrderModel({
    required this.id,
    required this.promotion,
    required this.order,
  });

  static PromotionOrderModel empty() => PromotionOrderModel(id: '', promotion: PromotionModel.empty(), order: OrderModel.empty());
  
  // Convert to JSON structure for Firebase
  Map<String, dynamic> toJson() {
    return{
      'itemID': id,
      'promotionId': promotion.id,
      'orderId': order.id
    };
  }

  // Create a model from Firebase document
   static Future<PromotionOrderModel> fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) async {
    if (document.data() != null) {
      final data = document.data()!;
      final promotionId = data['promotionId'] as String;
      final orderId = data['orderId'] as String;
      // Fetch promotion document
      final promotionDoc = await FirebaseFirestore.instance
          .collection('Promotions')
          .doc(promotionId)
          .get();
      final promotion = PromotionModel.fromSnapshot(promotionDoc);

      // Fetch order document
      final orderDoc = await FirebaseFirestore.instance
          .collection('Orders')
          .doc(orderId)
          .get();
      final order = OrderModel.fromSnapshot(orderDoc);

      return PromotionOrderModel(
        id: document.id,
        promotion: promotion,
        order: await order
        );
    } else {
      return PromotionOrderModel.empty();
    }
  }

}