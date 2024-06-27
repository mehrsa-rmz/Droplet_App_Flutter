import 'package:flutter_application/utils/formatters/formatter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  // non update-able values with final
  final String id;
  final String email;
  String firstName;
  String lastName;
  String? birthday;
  String? gender;
  String? phoneNo;
  String? address;
  final String cartId;

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.birthday,
    this.gender,
    this.phoneNo,
    this.address,
    required this.cartId,
  });

  String get fullName => '$firstName $lastName';
  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNo!);
  static List<String> nameParts(fullName) => fullName.split(" ");
  
  static UserModel empty() => UserModel(id: '', email: '', firstName: '', lastName: '', birthday: '', gender: 'all', phoneNo: '', address: '', cartId: '');

  // Convert to JSON structure for Firebase
  Map<String, dynamic> toJson() {
    return{
      'customerId': id,
      'email': email,
      'customerFirstName': firstName,
      'customerLastName': lastName,
      'birthday': birthday,
      'gender': gender,
      'phoneNo': phoneNo,
      'address': address,
      'cartId': cartId
    };
  }

  String getId(){
    return id.toString();
  }

  // Create a model from Firebase document
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id, 
        email: data['email'] as String,
        firstName: data['customerFirstName'] as String,
        lastName: data['customerLastName'] as String,
        birthday: data['birthday'] as String,
        gender: data['gender'] as String,
        phoneNo: data['phoneNo'] as String,
        address: data['address'] as String,
        cartId: data['cartId'] as String
        );
    } else {
      return UserModel.empty();
    }
  }
}