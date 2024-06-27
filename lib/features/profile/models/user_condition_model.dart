import 'package:cloud_firestore/cloud_firestore.dart';

class UserConditionModel {
  final String id;
  final String userId;
  final String conditionId;

  UserConditionModel({
    required this.id,
    required this.userId,
    required this.conditionId
  });

  static UserConditionModel empty() => UserConditionModel(id: '', userId: '', conditionId: '');
  
  // Convert to JSON structure for Firebase
  Map<String, dynamic> toJson() {
    return{
      'itemID': id,
      'customerId': userId,
      'conditionId': conditionId,
    };
  }

  // Create a model from Firebase document
  static Future<UserConditionModel> fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) async {
    final data = document.data()!;
    return UserConditionModel(
      id: document.id,
      userId: data['customerId'] ?? '',
      conditionId: data['conditionId'] ?? '',
    );
  }
}