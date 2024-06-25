// import 'package:flutter_application/features/products/models/condition_model.dart';
// import 'package:flutter_application/features/products/models/product_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class ProductConditionModel {
//   final String id;
//   final ProductModel product;
//   final ConditionModel condition;


//   ProductConditionModel({
//     required this.id,
//     required this.product,
//     required this.condition,
//   });

//   static ProductConditionModel empty() => ProductConditionModel(id: '', product: ProductModel.empty(), condition: ConditionModel.empty());

//   String getProductId(){
//     return product.id.toString();
//   }

//   String getConditionId(){
//     return condition.id.toString();
//   }
  
//   // Convert to JSON structure for Firebase
//   Map<String, dynamic> toJson() {
//     return{
//       'itemID': id,
//       'productId': product.id,
//       'conditionId': condition.id,
//     };
//   }

//   // Create a model from Firebase document
//   static Future<ProductConditionModel> fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) async {
//     final data = document.data()!;
//     final conditionId = data['conditionId'] as String;
//     final productId = data['productId'] as String;

//     final conditionDoc = await FirebaseFirestore.instance.collection('Conditions').doc(conditionId).get();
//     final productDoc = await FirebaseFirestore.instance.collection('Products').doc(productId).get();

//     return ProductConditionModel(
//       id: document.id,
//       condition: ConditionModel.fromSnapshot(conditionDoc),
//       product: ProductModel.fromSnapshot(productDoc),
//     );
//   }

// }

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductConditionModel {
  final String id;
  final String productId;
  final String conditionId;

  ProductConditionModel({
    required this.id,
    required this.productId,
    required this.conditionId,
  });

  // Convert to JSON structure for Firebase
  Map<String, dynamic> toJson() {
    return {
      'itemID': id,
      'productId': productId,
      'conditionId': conditionId,
    };
  }

  // Create a ProductConditionModel from Firebase document
  static Future<ProductConditionModel> fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) async {
    final data = document.data()!;
    return ProductConditionModel(
      id: document.id,
      productId: data['productId'] ?? '',
      conditionId: data['conditionId'] ?? '',
    );
  }

  // Create an empty instance
  static ProductConditionModel empty() => ProductConditionModel(id: '', productId: '', conditionId: '');
}
