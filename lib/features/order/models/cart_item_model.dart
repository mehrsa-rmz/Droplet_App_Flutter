import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application/features/order/models/cart_model.dart';
import 'package:flutter_application/features/products/models/product_model.dart';

class CartItemModel {
  final String id;
  final ProductModel product;
  final CartModel cart;
  bool isTester;
  int quantity;

  CartItemModel({
    required this.id,
    required this.product,
    required this.cart,
    required this.isTester,
    required this.quantity
  });

  static CartItemModel empty() => CartItemModel(id: '', product: ProductModel.empty(), cart: CartModel.empty(), isTester: false, quantity: 0);
  
  // Convert to JSON structure for Firebase
  Map<String, dynamic> toJson() {
    return{
      'itemID': id,
      'productId': product.id,
      'cartId': cart.id,
      'inCartIsTester': isTester,
      'inCartQuantity': quantity
    };
  }

  // Create a model from Firebase document
   static Future<CartItemModel> fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) async {
    if (document.data() != null) {
      final data = document.data()!;
      final productId = data['productId'] as String;
      final cartId = data['cartId'] as String;
      // Fetch product document
      final productDoc = await FirebaseFirestore.instance
          .collection('Products')
          .doc(productId)
          .get();
      final product = ProductModel.fromSnapshot(productDoc);

      // Fetch cart document
      final cartDoc = await FirebaseFirestore.instance
          .collection('Orders')
          .doc(cartId)
          .get();
      final cart = CartModel.fromSnapshot(cartDoc);

      return CartItemModel(
        id: document.id,
        product: product,
        cart: await cart,
        isTester: data['inCartIsTester'] as bool,
        quantity: data['inCartQuantity'] as int
        );
    } else {
      return CartItemModel.empty();
    }
  }

}