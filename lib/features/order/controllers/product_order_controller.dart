import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application/features/order/models/product_order_model.dart';
import 'package:get/get.dart';

class ProductOrderController extends GetxController {
  static ProductOrderController get instance => Get.put(ProductOrderController());

  final CollectionReference<Map<String, dynamic>> collection =
      FirebaseFirestore.instance.collection('ProductsOrders');

  RxList<ProductOrderModel> orderProducts = RxList<ProductOrderModel>();

  @override
  void onInit() {
    super.onInit();
    bindOrderProducts();
  }

  // Function to fetch the order's products
  Future<List<ProductOrderModel>> fetchOrderProductsForOrderId(String orderId) async {
    try {
      final querySnapshot = await collection
          .where('orderId', isEqualTo: orderId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        List<ProductOrderModel> fetchedOrderProducts = await Future.wait(
          querySnapshot.docs.map((doc) async {
            return await ProductOrderModel.fromSnapshot(doc);
          }).toList()
        );
        orderProducts.assignAll(fetchedOrderProducts);
        return fetchedOrderProducts;
      } else {
        return [];
      }
    } catch (e) {
      print("Error fetching order products: $e");
      return [];
    }
  }

  Future<void> addOrderProduct(ProductOrderModel orderProduct) async {
    try {
      print("Adding orderProduct: ${orderProduct.toJson()}"); // Debug statement
      await collection.add(orderProduct.toJson());
      print("OrderProduct added successfully");
    } catch (e) {
      print("Error adding orderProduct: $e");
    }
  }

  Future<void> updateOrderProduct(String id, ProductOrderModel orderProduct) async {
    try {
      print("Updating orderProduct: ${orderProduct.toJson()}"); // Debug statement
      await collection.doc(id).update(orderProduct.toJson());
      print("OrderProduct updated successfully");
    } catch (e) {
      print("Error updating orderProduct: $e");
    }
  }

  Future<void> deleteOrderProduct(String id) async {
    try {
      print("Deleting orderProduct with ID: $id"); // Debug statement
      await collection.doc(id).delete();
      print("OrderProduct deleted successfully");
    } catch (e) {
      print("Error deleting orderProduct: $e");
    }
  }

  void bindOrderProducts() {
    collection.snapshots().listen((snapshot) async {
      List<ProductOrderModel> products = await Future.wait(snapshot.docs.map((doc) async {
        return await ProductOrderModel.fromSnapshot(doc);
      }).toList());
      orderProducts.assignAll(products);
    });
  }

  // Function to fetch all ProductOrderModel products
  Future<List<ProductOrderModel>> fetchAllOrderProducts() async {
    try {
      final querySnapshot = await collection.get();
      List<ProductOrderModel> orderProducts = await Future.wait(
        querySnapshot.docs.map((doc) async {
          return await ProductOrderModel.fromSnapshot(doc);
        }).toList()
      );
      return orderProducts;
    } catch (e) {
      print("Error fetching orderProducts: $e");
      return [];
    }
  }

  Future<String?> getOrderProductDocumentIdByProductId(String productId) async {
    try {
      final querySnapshot = await collection
          .where('productID', isEqualTo: productId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.id; // Get the document ID
      } else {
        print("No order product found with productID: $productId");
        return null;
      }
    } catch (e) {
      print("Error fetching order product document ID: $e");
      return null;
    }
  }
}
