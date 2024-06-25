// import 'package:flutter_application/features/products/models/ingredient_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_application/features/products/models/product_model.dart';

// class ProductIngredientModel {
//   final String id;
//   final ProductModel product;
//   final IngredientModel ingredient;

//   ProductIngredientModel({
//     required this.id,
//     required this.product,
//     required this.ingredient
//   });

//   static ProductIngredientModel empty() => ProductIngredientModel(id: '', product: ProductModel.empty(), ingredient: IngredientModel.empty());

//   String getProductId(){
//     return product.id.toString();
//   }

//   String getIngredientId(){
//     return ingredient.id.toString();
//   }
  
//   // Convert to JSON structure for Firebase
//   Map<String, dynamic> toJson() {
//     return{
//       'itemID': id,
//       'productId': product.id,
//       'ingredientId': ingredient.id,
//     };
//   }

//   // Create a model from Firebase document
//   static Future<ProductIngredientModel> fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) async {
//     final data = document.data()!;
//     final ingredientId = data['ingredientId'] as String;
//     final productId = data['productId'] as String;

//     final ingredientDoc = await FirebaseFirestore.instance.collection('Ingredients').doc(ingredientId).get();
//     final productDoc = await FirebaseFirestore.instance.collection('Products').doc(productId).get();

//     return ProductIngredientModel(
//       id: document.id,
//       ingredient: IngredientModel.fromSnapshot(ingredientDoc),
//       product: ProductModel.fromSnapshot(productDoc),
//     );
//   }

// }

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductIngredientModel {
  final String id;
  final String productId;
  final String ingredientId;

  ProductIngredientModel({
    required this.id,
    required this.productId,
    required this.ingredientId,
  });

  static ProductIngredientModel empty() => ProductIngredientModel(
        id: '',
        productId: '',
        ingredientId: '',
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'ingredientId': ingredientId,
    };
  }

  static Future<ProductIngredientModel> fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) async {
    final data = document.data()!;
    return ProductIngredientModel(
      id: document.id,
      productId: data['productId'] as String? ?? '',
      ingredientId: data['ingredientId'] as String? ?? '',
    );
  }
}
