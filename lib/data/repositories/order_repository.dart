import 'package:flutter_application/data/repositories/authentication_repository.dart';
import 'package:flutter_application/features/order/models/order_model.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.put(OrderRepository());

  /// Variables
  final _db = FirebaseFirestore.instance;

  /* ---------------------------- FUNCTIONS ---------------------------------*/

  /// Get all order related to current User
  Future<List<OrderModel>> fetchCurrentUserOrders() async {
    final userId = AuthenticationRepository.instance.getUserID;
    final querySnapshot = await _db.collection('Orders')
        .where('customerId', isEqualTo: userId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      List<OrderModel> orders = await Future.wait(
        querySnapshot.docs.map((doc) async {
          return await OrderModel.fromSnapshot(doc);
        }).toList()
      );
      return orders;
    }
    return [];
  }

  Future<OrderModel?> getOrderById(String id) async {
    try {
      final documentSnapshot = await  _db.collection('Orders').doc(id).get();
      if (documentSnapshot.exists) {
        return OrderModel.fromSnapshot(documentSnapshot);
      }
    } catch (e) {
      print("Error fetching order: $e");
    }
    return null;
  }

  /// Store new user order
  Future<void> addOrder(OrderModel order) async {
    try {
      await _db.collection('Orders').add(order.toJson());
    } catch (e) {
      throw 'Something went wrong while saving Order. Try again later';
    }
  }
}