import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/data/repositories/authentication_repository.dart';
import 'package:flutter_application/data/repositories/cart_repository.dart';
import 'package:flutter_application/features/order/models/cart_model.dart';
import 'package:get/get.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../utils/popups/loaders.dart';
import '../models/user_model.dart';

/// Controller to manage user-related functionality.
class UserController extends GetxController {
  static UserController get instance => Get.put(UserController());
  final _cartRepository = Get.put(CartRepository());
  Rx<CartModel> currentCart = CartModel.empty().obs;
  Rx<UserModel> user = UserModel.empty().obs;

  final profileLoading = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  /// init user data when Home Screen appears
  @override
  void onInit() async {
    if (FirebaseAuth.instance.currentUser == null) {
      currentCart.value = await _cartRepository.createAnonymousCart();
    } else {
      currentCart.value = await _cartRepository.fetchUserCart(FirebaseAuth.instance.currentUser!.uid);
    }
    fetchUserRecord();
    super.onInit();
  }

  // Fetch a user by ID
  static Future<UserModel?> fetchUserById(String userId) async {
    try {
      final docSnapshot = await FirebaseFirestore.instance
          .collection('Customers')
          .doc(userId)
          .get();

      if (docSnapshot.exists) {
        return UserModel.fromSnapshot(docSnapshot);
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching user: $e");
      return null;
    }
  }

  // Fetch a user by ID
  static Future<String> fetchUserNameById(String userId) async {
    try {
      final docSnapshot = await FirebaseFirestore.instance
          .collection('Customers')
          .doc(userId)
          .get();

      if (docSnapshot.exists) {
        UserModel thisUser = UserModel.fromSnapshot(docSnapshot);
        return thisUser.fullName;
      } else {
        return '';
      }
    } catch (e) {
      print("Error fetching user: $e");
      return '';
    }
  }

  /// Fetch user record
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  /// Save user Record from any Registration provider
  Future<void> saveUserRecord({UserModel? user, UserCredential? userCredentials}) async {
    try {
      // First UPDATE Rx User and then check if user data is already stored. If not store new data
      await fetchUserRecord();

      // If no record already stored.
      if (this.user.value.id.isEmpty) {
        if (userCredentials != null) {
          // Convert Name to First and Last Name
          final nameParts = UserModel.nameParts(userCredentials.user!.displayName ?? '');
          CartModel newCart = await _cartRepository.createUserCart(userCredentials.user!.uid);
          currentCart.value = newCart;

          // Map data
          final newUser = UserModel(
            id: userCredentials.user!.uid,
            firstName: nameParts[0],
            lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : "",
            email: userCredentials.user!.email ?? '',
            phoneNo: userCredentials.user!.phoneNumber ?? '',
            cartId: newCart.id,
            birthday: '',
            gender: 'all',
            address: ''
          );

          // Save user data
          await userRepository.saveUserRecord(newUser);

          // Assign new user to the RxUser so that we can use it through out the app.
          this.user(newUser);
        } else if (user != null) {
          // Save Model when user registers using Email and Password
          await userRepository.saveUserRecord(user);

          // Assign new user to the RxUser so that we can use it through out the app.
          this.user(user);
        }
      }
    } catch (e) {
      TLoaders.warningSnackBar(
        title: 'Data not saved',
        message: 'Something went wrong while saving your information. You can re-save your data in your Profile.',
      );
    }
  }


  /// Logout Loader Function
  logout() async {
    try {
      final anonymousCart = await _cartRepository.createAnonymousCart();
      await AuthenticationRepository.instance.logout();
      currentCart.value = anonymousCart;    
      } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
