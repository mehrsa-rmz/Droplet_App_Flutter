import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application/features/order/models/cart_item_model.dart';
import 'package:get/get.dart';

class CartItemsController extends GetxController {
  static CartItemsController get instance => Get.put(CartItemsController());

  final CollectionReference<Map<String, dynamic>> collection =
      FirebaseFirestore.instance.collection('CartItems');

  RxList<CartItemModel> cartItems = RxList<CartItemModel>();
  RxInt cartItemCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    bindCartItems();
  }

  // Function to fetch the current user's cartItem items
  Future<List<CartItemModel>> fetchCartItemsForCartId(String cartId) async {
    try {
      final querySnapshot = await collection
          .where('cartId', isEqualTo: cartId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        List<CartItemModel> fetchedCartItems = await Future.wait(
          querySnapshot.docs.map((doc) async {
            return await CartItemModel.fromSnapshot(doc);
          }).toList()
        );
        cartItems.assignAll(fetchedCartItems);
        cartItemCount.value = fetchedCartItems.length;
        return fetchedCartItems;
      } else {
        cartItems.clear();
        cartItemCount.value = 0;
        return [];
      }
    } catch (e) {
      print("Error fetching cart items: $e");
      return [];
    }
  }

  Future<void> addCartItem(CartItemModel cartItem) async {
    try {
      print("Adding cartItem: ${cartItem.toJson()}"); // Debug statement
      await collection.add(cartItem.toJson());
      await fetchCartItemsForCartId(cartItem.cartId);
      print("CartItem added successfully");
    } catch (e) {
      print("Error adding cartItem: $e");
    }
  }

  Future<void> updateCartItem(String id, CartItemModel cartItem) async {
    try {
      print("Updating cartItem: ${cartItem.toJson()}"); // Debug statement
      await collection.doc(id).update(cartItem.toJson());
      await fetchCartItemsForCartId(cartItem.cartId);
      print("CartItem updated successfully");
    } catch (e) {
      print("Error updating cartItem: $e");
    }
  }

  Future<void> deleteCartItem(String id) async {
    try {
      print("Deleting cartItem with ID: $id"); // Debug statement
      final cartItem = cartItems.firstWhere((item) => item.id == id);
      await collection.doc(id).delete();
      await fetchCartItemsForCartId(cartItem.cartId);
      print("CartItem deleted successfully");
    } catch (e) {
      print("Error deleting cartItem: $e");
    }
  }

  void bindCartItems() {
    collection.snapshots().listen((snapshot) async {
      List<CartItemModel> items = await Future.wait(snapshot.docs.map((doc) async {
        return await CartItemModel.fromSnapshot(doc);
      }).toList());
      cartItems.assignAll(items);
      //cartItemCount.value = items.length;
    });
  }

  // Function to fetch all CartItemModel items
  Future<List<CartItemModel>> fetchAllCartItems() async {
    try {
      final querySnapshot = await collection.get();
      List<CartItemModel> allCartItems = await Future.wait(
        querySnapshot.docs.map((doc) async {
          return await CartItemModel.fromSnapshot(doc);
        }).toList()
      );
      return allCartItems;
    } catch (e) {
      print("Error fetching cartItems: $e");
      return [];
    }
  }

  Future<CartItemModel?> getCartItemById(String id) async {
    try {
      final documentSnapshot = await collection.doc(id).get();
      if (documentSnapshot.exists) {
        return CartItemModel.fromSnapshot(documentSnapshot);
      }
    } catch (e) {
      print("Error fetching cart item: $e");
    }
    return null;
  }
}
