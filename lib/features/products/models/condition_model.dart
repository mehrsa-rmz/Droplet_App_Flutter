import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application/utils/constants/enums.dart';

class ConditionModel {
  final String id;
  final Conditions name;
  final ProductCategories type;

  ConditionModel({
    required this.id,
    required this.name,
    required this.type
  });

  String get nameText {
    switch (name) {
      case Conditions.all:
        return "Good for all";
      case Conditions.dry:
        return "Dry";
      case Conditions.oily:
        return "Oily";
      case Conditions.acneeProne:
        return "Acnee prone";
      case Conditions.combination:
        return "Combination";
      case Conditions.sensitive:
        return "Sensitive";
      case Conditions.dyed:
        return "Dyed";
      case Conditions.dandruff:
        return "Dandruff";
      case Conditions.thin:
        return "Thin";
      case Conditions.thick:
        return "Thick";
      case Conditions.frizzy:
        return "Frizzy";
      case Conditions.straight:
        return "Straight";
      case Conditions.wavy:
        return "Wavy";
      case Conditions.curly:
        return "Curly";
      case Conditions.scars:
        return "Scars";
      case Conditions.sweet:
        return "Sweet";
      case Conditions.floral:
        return "Floral";
      case Conditions.fresh:
        return "Fresh";
      case Conditions.fruity:
        return "Fruity";
      case Conditions.musky:
        return "Musky";
      case Conditions.woody:
        return "Woody";
      case Conditions.oriental:
        return "Oriental";
      case Conditions.spiced:
        return "Spiced";
      default:
        return "";
    }
  }

  String get typeText => type == ProductCategories.skin
      ? 'Skincare'
      : type == ProductCategories.hair
          ? 'Haircare'
          : type == ProductCategories.body
            ? 'Body'
            : 'Perfume';

  /// Convert model to Json structure so that you can store data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'conditionId': id,
      'conditionName': name.toString(),
      'conditionType': type.toString()
    };
  }

  factory ConditionModel.fromJson(Map<String, dynamic> json) {
    return ConditionModel(
      id: json['conditionId'],
      name: json['conditionName'] as Conditions,
      type: json['conditionType'] as ProductCategories
    );
  }

  /// Map Json oriented document snapshot from Firebase to UserModel
  factory ConditionModel.fromSnapshot(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;

    // Map JSON Record to the Model
    return ConditionModel(
      id: document.id,
      name: Conditions.values.firstWhere((e) => e.toString() == data['conditionName']),
      type: ProductCategories.values.firstWhere((e) => e.toString() == data['conditionType']),
    );
  }
}
