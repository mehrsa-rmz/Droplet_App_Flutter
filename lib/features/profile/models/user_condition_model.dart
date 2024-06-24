import 'package:flutter_application/features/conditions/models/condition_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application/features/profile/models/user_model.dart';

class UserConditionModel {
  final String id;
  final UserModel user;
  final ConditionModel condition;

  UserConditionModel({
    required this.id,
    required this.user,
    required this.condition
  });

  static UserConditionModel empty() => UserConditionModel(id: '', user: UserModel.empty(), condition: ConditionModel.empty());
  
  // Convert to JSON structure for Firebase
  Map<String, dynamic> toJson() {
    return{
      'itemID': id,
      'customerId': user.id,
      'conditionId': condition.id,
    };
  }

  // Create a model from Firebase document
   static Future<UserConditionModel> fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) async {
    if (document.data() != null) {
      final data = document.data()!;
      final userId = data['customerId'] as String;
      final conditionId = data['conditionId'] as String;
      // Fetch user document
      final userDoc = await FirebaseFirestore.instance
          .collection('Customers')
          .doc(userId)
          .get();
      final user = UserModel.fromSnapshot(userDoc);

      // Fetch condition document
      final conditionDoc = await FirebaseFirestore.instance
          .collection('Conditions')
          .doc(conditionId)
          .get();
      final condition = ConditionModel.fromSnapshot(conditionDoc);

      return UserConditionModel(
        id: document.id,
        user: user,
        condition: condition
        );
    } else {
      return UserConditionModel.empty();
    }
  }

}