import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application/features/products/models/condition_model.dart';
import 'package:flutter_application/features/products/models/ingredient_model.dart';
import 'package:flutter_application/utils/constants/enums.dart';

class ProductModel {
  final String id;
  final String productName;
  final ProductCategories category;
  final Genders gender;
  final Ages ageGroup;
  final bool isHypoallergenic;
  final double price;
  int? productPromotion = 0;
  final String description;
  int? stock = 0;
  final List<ConditionModel>? productConditions;
  final List<IngredientModel>? ingredients;

  ProductModel({
    required this.id,
    required this.productName,
    required this.category,
    required this.gender,
    required this.ageGroup,
    required this.isHypoallergenic,
    required this.price,
    required this.description,
    required this.productConditions,
    required this.ingredients,
    this.productPromotion,
    this.stock,
  });

  /// Create Empty func for clean code
  static ProductModel empty() => ProductModel(id: '', productName: '', category: ProductCategories.skin, gender: Genders.all, ageGroup: Ages.all, isHypoallergenic: false, price: 0, description: '', productConditions: [], ingredients: []);

  /// Json Format
  toJson() {
    return {
      'productId': id,
      'productName': productName,
      'category': category.toString(),
      'gender': gender.toString(),
      'ageGroup': ageGroup.toString(),
      'isHypoallergenic': isHypoallergenic,
      'price': price,
      'description': description,
      'productConditions': productConditions?.map((condition) => condition.toJson()).toList(),
      'ingredients': ingredients?.map((ingredient) => ingredient.toJson()).toList(),
      'productPromotion': productPromotion,
      'stock': stock,
    };
  }

  /// Map Json oriented document snapshot from Firebase to Model
  factory ProductModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ProductModel(
      id: document.id,
      productName: data['productName'] as String,
      category:  ProductCategories.values.firstWhere((e) => e.toString() == data['category']),
      gender: Genders.values.firstWhere((e) => e.toString() == data['gender']),
      ageGroup: Ages.values.firstWhere((e) => e.toString() == data['ageGroup']),
      isHypoallergenic: data['isHypoallergenic'] as bool,
      price: data['price'] as double,
      description: data['description'] as String,
      productConditions: (data['productConditions'] as List<dynamic>).map((e) => ConditionModel.fromJson(e)).toList(),
      ingredients: (data['ingredients'] as List<dynamic>).map((e) => IngredientModel.fromJson(e)).toList(),
      productPromotion: int.parse((data['productPromotion'] ?? 0).toString()),
      stock: int.parse((data['stock'] ?? 0).toString()),
    );
  }

  // Map Json-oriented document snapshot from Firebase to Model
  factory ProductModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;
    return ProductModel(
      id: document.id,
      productName: data['productName'] as String,
      category:  ProductCategories.values.firstWhere((e) => e.toString() == data['category']),
      gender: Genders.values.firstWhere((e) => e.toString() == data['gender']),
      ageGroup: Ages.values.firstWhere((e) => e.toString() == data['ageGroup']),
      isHypoallergenic: data['isHypoallergenic'] as bool,
      price: data['price'] as double,
      description: data['description'] as String,
      productConditions: (data['productConditions'] as List<dynamic>).map((e) => ConditionModel.fromJson(e)).toList(),
      ingredients: (data['ingredients'] as List<dynamic>).map((e) => IngredientModel.fromJson(e)).toList(),
      productPromotion: int.parse((data['productPromotion'] ?? 0).toString()),
      stock: int.parse((data['stock'] ?? 0).toString()),
    );
  }
}
