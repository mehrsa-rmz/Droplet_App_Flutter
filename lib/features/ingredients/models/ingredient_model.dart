import 'package:cloud_firestore/cloud_firestore.dart';

class IngredientModel {
  final String id;
  final String name;

  IngredientModel({
    required this.id,
    required this.name,
  });

  static IngredientModel empty() => IngredientModel(id: '', name: '');

  /// Convert model to Json structure so that you can store data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'itemID': id,
      'ingredientName': name,
    };
  }

  factory IngredientModel.fromJson(Map<String, dynamic> json) {
    return IngredientModel(
      id: json['itemID'],
      name: json['ingredientName'] as String
    );
  }

  /// Map Json oriented document snapshot from Firebase to UserModel
  factory IngredientModel.fromSnapshot(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;

    // Map JSON Record to the Model
    return IngredientModel(
      id: document.id,
      name: data['ingredientName'] as String,
    );
  }
}
