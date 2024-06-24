import 'package:flutter_application/features/conditions/models/condition_model.dart';
import 'package:flutter_application/features/products/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductConditionModel {
  final String id;
  final ProductModel product;
  final ConditionModel condition;

  ProductConditionModel({
    required this.id,
    required this.product,
    required this.condition
  });

  static ProductConditionModel empty() => ProductConditionModel(id: '', product: ProductModel.empty(), condition: ConditionModel.empty());
  
  // Convert to JSON structure for Firebase
  Map<String, dynamic> toJson() {
    return{
      'itemID': id,
      'productId': product.id,
      'conditionId': condition.id,
    };
  }

  // Create a model from Firebase document
   static Future<ProductConditionModel> fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) async {
    if (document.data() != null) {
      final data = document.data()!;
      final productId = data['productId'] as String;
      final conditionId = data['conditionId'] as String;
      // Fetch product document
      final productDoc = await FirebaseFirestore.instance
          .collection('Products')
          .doc(productId)
          .get();
      final product = ProductModel.fromSnapshot(productDoc);

      // Fetch condition document
      final conditionDoc = await FirebaseFirestore.instance
          .collection('Conditions')
          .doc(conditionId)
          .get();
      final condition = ConditionModel.fromSnapshot(conditionDoc);

      return ProductConditionModel(
        id: document.id,
        product: product,
        condition: condition
        );
    } else {
      return ProductConditionModel.empty();
    }
  }

}