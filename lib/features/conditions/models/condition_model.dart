import 'package:cloud_firestore/cloud_firestore.dart';

class ConditionModel {
  final String id;
  final String name;
  final String type;

  ConditionModel({
    required this.id,
    required this.name,
    required this.type
  });

  static ConditionModel empty() => ConditionModel(id: '', name: '', type: '' );

  /// Convert model to Json structure so that you can store data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'itemID': id,
      'conditionName': name,
      'conditionType': type
    };
  }

  factory ConditionModel.fromJson(Map<String, dynamic> json) {
    return ConditionModel(
      id: json['itemID'],
      name: json['conditionName'] as String,
      type: json['conditionType'] as String
    );
  }

  /// Map Json oriented document snapshot from Firebase to UserModel
  factory ConditionModel.fromSnapshot(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;

    // Map JSON Record to the Model
    return ConditionModel(
      id: document.id,
      name: data['conditionName'] as String,
      type: data['conditionType'] as String,
    );
  }
}
