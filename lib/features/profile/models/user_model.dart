import 'package:flutter_application/features/products/models/condition_model.dart';
import 'package:flutter_application/features/products/models/ingredient_model.dart';
import 'package:flutter_application/utils/constants/enums.dart';
import 'package:flutter_application/utils/formatters/formatter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  // non update-able values with final
  final String id;
  final String email;
  String userFirstName;
  String userLastName;
  DateTime? birthday;
  Genders? gender;
  String? phoneNo;
  String? address;
  List<ConditionModel>? conditions = [];
  List<IngredientModel>? allergies = [];
  //final CartModel? cart; //TODO

  UserModel({
    required this.id,
    required this.email,
    required this.userFirstName,
    required this.userLastName,
    this.birthday,
    this.gender,
    this.phoneNo,
    this.address,
    this.conditions,
    this.allergies,
    //this.cart, //TODO
  });

  String get fullName => '$userFirstName $userLastName';
  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNo!);
  static List<String> nameParts(fullName) => fullName.split(" ");
  
  String get genderText => gender == Genders.f
      ? 'Woman'
      : gender == Genders.m
          ? 'Man'
          : 'All';

  // Empty User Model
  static UserModel empty() => UserModel(id: '', email: '', userFirstName: '', userLastName: '', birthday: DateTime.now(), gender: Genders.all, phoneNo: '', address: '', conditions: [], allergies: []);

  // Convert to JSON structure for Firebase
  Map<String, dynamic> toJson() {
    return{
      'customerId': id,
      'email': email,
      'customerFirstName': userFirstName,
      'customerLastName': userLastName,
      'birthday': birthday,
      'gender': gender.toString(),
      'phoneNo': phoneNo,
      'address': address,
      'customerConditions': conditions?.map((condition) => condition.toJson()).toList(),
      'allergies': allergies?.map((ingredient) => ingredient.toJson()).toList(),
    };
  }

  // Create a UserModel from Firebase document
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id, 
        email: data['email'] as String,
        userFirstName: data['customerFirstName'] as String,
        userLastName: data['customerLastName'] as String,
        birthday: data['birthday'] as DateTime,
        gender: Genders.values.firstWhere((e) => e.toString() == data['gender']),
        phoneNo: data['phoneNo'] as String,
        address: data['address'] as String,
        conditions: (data['customerConditions'] as List<dynamic>).map((condition) => ConditionModel.fromJson(condition as Map<String, dynamic>)).toList(),
        allergies: (data['allergies'] as List<dynamic>).map((ingredient) => IngredientModel.fromJson(ingredient as Map<String, dynamic>)).toList(),
        );
    } else {
      return UserModel.empty();
    }
  }

}