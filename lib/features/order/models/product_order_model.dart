import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application/features/order/models/order_model.dart';
import 'package:flutter_application/features/products/models/product_model.dart';

class ProductOrderModel {
  final String id;
  final ProductModel product;
  final OrderModel order;
  final bool isTester;
  final int quantity;

  ProductOrderModel({
    required this.id,
    required this.product,
    required this.order,
    required this.isTester,
    required this.quantity
  });

  static ProductOrderModel empty() => ProductOrderModel(id: '', product: ProductModel.empty(), order: OrderModel.empty(), isTester: false, quantity: 0);
  
  // Convert to JSON structure for Firebase
  Map<String, dynamic> toJson() {
    return{
      'itemID': id,
      'productId': product.id,
      'orderId': order.id,
      'isTester': isTester,
      'quantity': quantity
    };
  }

  // Create a model from Firebase document
   static Future<ProductOrderModel> fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) async {
    if (document.data() != null) {
      final data = document.data()!;
      final productId = data['productId'] as String;
      final orderId = data['orderId'] as String;
      // Fetch product document
      final productDoc = await FirebaseFirestore.instance
          .collection('Products')
          .doc(productId)
          .get();
      final product = ProductModel.fromSnapshot(productDoc);

      // Fetch order document
      final orderDoc = await FirebaseFirestore.instance
          .collection('Orders')
          .doc(orderId)
          .get();
      final order = OrderModel.fromSnapshot(orderDoc);

      return ProductOrderModel(
        id: document.id,
        product: product,
        order: await order,
        isTester: data['isTester'] as bool,
        quantity: data['quantity'] as int
        );
    } else {
      return ProductOrderModel.empty();
    }
  }

}