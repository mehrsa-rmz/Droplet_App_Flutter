import 'package:cloud_firestore/cloud_firestore.dart';

class ProductOrderModel {
  final String id;
  final String productId;
  final String orderId;
  final bool isTester;
  final int quantity;
  final int finalPrice;

  ProductOrderModel({
    required this.id,
    required this.productId,
    required this.orderId,
    required this.isTester,
    required this.quantity,
    required this.finalPrice
  });

  static ProductOrderModel empty() => ProductOrderModel(id: '', productId: '', orderId: '', isTester: false, quantity: 0, finalPrice: 0);
  
  // Convert to JSON structure for Firebase
  Map<String, dynamic> toJson() {
    return{
      'itemID': id,
      'productId': productId,
      'orderId': orderId,
      'isTester': isTester,
      'quantity': quantity,
      'productFinalPrice': finalPrice
    };
  }

  // Create a model from Firebase document
   static Future<ProductOrderModel> fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) async {
    if (document.data() != null) {
      final data = document.data()!;
      return ProductOrderModel(
        id: data['itemID'] as String,
        productId: data['productId'] as String,
        orderId: data['orderId'] as String,
        isTester: data['isTester'] as bool,
        quantity: data['quantity'] as int,
        finalPrice: data['productFinalPrice'] as int
        );
    } else {
      return ProductOrderModel.empty();
    }
  }

}