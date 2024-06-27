import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application/features/order/models/cart_model.dart';
import 'package:get/get.dart';

class CartRepository extends GetxController {
  static CartRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<CartModel> fetchUserCart(String userId) async {
    final querySnapshot = await _db.collection('Carts')
        .where('customerId', isEqualTo: userId)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return CartModel.fromSnapshot(querySnapshot.docs.first);
    }
    return CartModel.empty();
  }

  Future<CartModel?> fetchAnonymousCart() async {
    final querySnapshot = await _db.collection('Carts')
        .where('customerId', isEqualTo: '')
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return CartModel.fromSnapshot(querySnapshot.docs.first);
    }
    return null;
  }

  Future<CartModel> createAnonymousCart() async {
    final existingCart = await fetchAnonymousCart();
    if (existingCart != null) {
      return existingCart;
    }
    final cart = CartModel(id: _db.collection('Carts').doc().id, userId: '');
    await _db.collection('Carts').doc(cart.id).set(cart.toJson());
    return cart;
  }


  Future<void> deleteAnonymousCart(String cartId) async {
    try {
      // Fetch all cart items associated with the given cart ID
      final cartItemsQuery = await _db.collection('CartItems')
          .where('cartId', isEqualTo: cartId)
          .get();

      // Delete each cart item
      for (var doc in cartItemsQuery.docs) {
        await _db.collection('CartItems').doc(doc.id).delete();
      }

      // Delete the cart itself
      await _db.collection('Carts').doc(cartId).delete();
    } catch (e) {
      print("Error deleting anonymous cart: $e");
    }
  }

  Future<CartModel> createUserCart(String userId) async {
    final cart = CartModel(id: _db.collection('Carts').doc().id, userId: userId);
    await _db.collection('Carts').doc(cart.id).set(cart.toJson());
    return cart;
  }

}