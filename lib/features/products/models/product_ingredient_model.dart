import 'package:flutter_application/features/products/models/ingredient_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application/features/products/models/product_model.dart';

class ProductIngredientModel {
  final String id;
  final ProductModel product;
  final IngredientModel ingredient;

  ProductIngredientModel({
    required this.id,
    required this.product,
    required this.ingredient
  });

  static ProductIngredientModel empty() => ProductIngredientModel(id: '', product: ProductModel.empty(), ingredient: IngredientModel.empty());
  
  // Convert to JSON structure for Firebase
  Map<String, dynamic> toJson() {
    return{
      'itemID': id,
      'productId': product.id,
      'ingredientId': ingredient.id,
    };
  }

  // Create a model from Firebase document
   static Future<ProductIngredientModel> fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) async {
    if (document.data() != null) {
      final data = document.data()!;
      final productId = data['productId'] as String;
      final ingredientId = data['ingredientId'] as String;
      // Fetch product document
      final productDoc = await FirebaseFirestore.instance
          .collection('Products')
          .doc(productId)
          .get();
      final product = ProductModel.fromSnapshot(productDoc);

      // Fetch ingredient document
      final ingredientDoc = await FirebaseFirestore.instance
          .collection('Ingredients')
          .doc(ingredientId)
          .get();
      final ingredient = IngredientModel.fromSnapshot(ingredientDoc);

      return ProductIngredientModel(
        id: document.id,
        product: product,
        ingredient: ingredient
        );
    } else {
      return ProductIngredientModel.empty();
    }
  }

}