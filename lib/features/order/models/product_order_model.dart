import 'package:cloud_firestore/cloud_firestore.dart';

class ProductOrderModel {
  final String id;
  final String productId;
  final String orderId;
  final bool isTester;
  final int quantity;

  ProductOrderModel({
    required this.id,
    required this.productId,
    required this.orderId,
    required this.isTester,
    required this.quantity
  });

  static ProductOrderModel empty() => ProductOrderModel(id: '', productId: '', orderId: '', isTester: false, quantity: 0);
  
  // Convert to JSON structure for Firebase
  Map<String, dynamic> toJson() {
    return{
      'itemID': id,
      'productId': productId,
      'orderId': orderId,
      'isTester': isTester,
      'quantity': quantity
    };
  }

  // Create a model from Firebase document
   static Future<ProductOrderModel> fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) async {
    if (document.data() != null) {
      final data = document.data()!;
      return ProductOrderModel(
        id: document.id,
        productId: data['productId'] as String,
        orderId: data['orderId'] as String,
        isTester: data['isTester'] as bool,
        quantity: data['quantity'] as int
        );
    } else {
      return ProductOrderModel.empty();
    }
  }

}