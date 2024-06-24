import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/product_model.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final CollectionReference<Map<String, dynamic>> collection =
      FirebaseFirestore.instance.collection('Products');

  RxList<ProductModel> products = RxList<ProductModel>();

  @override
  void onInit() {
    super.onInit();
    products.bindStream(getProducts());
  }

  Future<void> addProduct(ProductModel product) async {
    try {
      await collection.add(product.toJson());
    } catch (e) {
      print("Error adding product: $e");
    }
  }

  Future<void> updateProduct(String id, ProductModel product) async {
    try {
      await collection.doc(id).update(product.toJson());
    } catch (e) {
      print("Error updating product: $e");
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      await collection.doc(id).delete();
    } catch (e) {
      print("Error deleting product: $e");
    }
  }

  Stream<List<ProductModel>> getProducts() {
    return collection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
    });
  }

  Future<ProductModel?> getProductById(String id) async {
    try {
      final documentSnapshot = await collection.doc(id).get();
      if (documentSnapshot.exists) {
        return ProductModel.fromSnapshot(documentSnapshot);
      }
    } catch (e) {
      print("Error fetching product: $e");
    }
    return null;
  }
}
