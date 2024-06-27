import 'package:cloud_firestore/cloud_firestore.dart';

class CartItemModel {
  final String id;
  final String productId;
  final String cartId;
  bool isTester;
  int quantity;

  CartItemModel({
    required this.id,
    required this.productId,
    required this.cartId,
    required this.isTester,
    required this.quantity
  });

  static CartItemModel empty() => CartItemModel(id: '', productId: '', cartId: '', isTester: false, quantity: 0);
  
  // Convert to JSON structure for Firebase
  Map<String, dynamic> toJson() {
    return{
      'itemID': id,
      'productId': productId,
      'cartId': cartId,
      'inCartIsTester': isTester,
      'inCartQuantity': quantity
    };
  }

  // Create a model from Firebase document
   static Future<CartItemModel> fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) async {
    if (document.data() != null) {
      final data = document.data()!;
      return CartItemModel(
        id: document.id,
        productId: data['productId'] as String,
        cartId: data['cartId'] as String,
        isTester: data['inCartIsTester'] as bool,
        quantity: data['inCartQuantity'] as int
        );
    } else {
      return CartItemModel.empty();
    }
  }

}