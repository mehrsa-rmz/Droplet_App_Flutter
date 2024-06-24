import 'package:flutter_application/features/ingredients/models/ingredient_model.dart';
import 'package:flutter_application/features/profile/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserAllergyModel {
  final String id;
  final UserModel user;
  final IngredientModel ingredient;

  UserAllergyModel({
    required this.id,
    required this.user,
    required this.ingredient
  });

  static UserAllergyModel empty() => UserAllergyModel(id: '', user: UserModel.empty(), ingredient: IngredientModel.empty());
  
  // Convert to JSON structure for Firebase
  Map<String, dynamic> toJson() {
    return{
      'itemID': id,
      'customerId': user.id,
      'ingredientId': ingredient.id,
    };
  }

  // Create a model from Firebase document
   static Future<UserAllergyModel> fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) async {
    if (document.data() != null) {
      final data = document.data()!;
      final userId = data['customerId'] as String;
      final ingredientId = data['ingredientId'] as String;
      // Fetch user document
      final userDoc = await FirebaseFirestore.instance
          .collection('Customers')
          .doc(userId)
          .get();
      final user = UserModel.fromSnapshot(userDoc);

      // Fetch ingredient document
      final ingredientDoc = await FirebaseFirestore.instance
          .collection('Ingredients')
          .doc(ingredientId)
          .get();
      final ingredient = IngredientModel.fromSnapshot(ingredientDoc);

      return UserAllergyModel(
        id: document.id,
        user: user,
        ingredient: ingredient
        );
    } else {
      return UserAllergyModel.empty();
    }
  }

}