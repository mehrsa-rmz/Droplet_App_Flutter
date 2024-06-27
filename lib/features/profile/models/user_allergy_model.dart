import 'package:cloud_firestore/cloud_firestore.dart';

class UserAllergyModel {
  final String id;
  final String userId;
  final String ingredientId;

  UserAllergyModel({
    required this.id,
    required this.userId,
    required this.ingredientId
  });

  static UserAllergyModel empty() => UserAllergyModel(id: '', userId: '', ingredientId: '');
  
  // Convert to JSON structure for Firebase
  Map<String, dynamic> toJson() {
    return{
      'itemID': id,
      'customerId': userId,
      'ingredientId': ingredientId,
    };
  }

  // Create a model from Firebase document
  static Future<UserAllergyModel> fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) async {
    final data = document.data()!;
    return UserAllergyModel(
      id: document.id,
      userId: data['customerId'] as String? ?? '',
      ingredientId: data['ingredientId'] as String? ?? '',
    );
  }
}