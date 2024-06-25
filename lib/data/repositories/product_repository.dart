import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../features/products/models/product_model.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  final CollectionReference<Map<String, dynamic>> collection =
      FirebaseFirestore.instance.collection('Products');

  Future<void> addProduct(ProductModel product) {
    return collection.add(product.toJson());
  }

  Future<void> updateProduct(String id, ProductModel product) {
    return collection.doc(id).update(product.toJson());
  }

  Future<void> deleteProduct(String id) {
    return collection.doc(id).delete();
  }

  Stream<List<ProductModel>> getProducts() {
    return collection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
    });
  }

  Future<ProductModel?> getProductById(String id) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc = await collection.doc(id).get();
      if (doc.exists) {
        return ProductModel.fromSnapshot(doc);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<List<ProductModel>> getFavouriteProducts(List<String> productIds) async {
    try {
      final snapshot = await collection.where(FieldPath.documentId, whereIn: productIds).get();
      return snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }
}
