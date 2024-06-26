import 'package:flutter/material.dart';
import 'package:flutter_application/data/repositories/authentication_repository.dart';
import 'package:flutter_application/data/repositories/cart_repository.dart';
import 'package:flutter_application/features/authentication/screens/signup/signup_success.dart';
import 'package:flutter_application/features/order/models/cart_model.dart';
import 'package:flutter_application/features/profile/controllers/user_controller.dart';
import 'package:flutter_application/features/profile/models/user_model.dart';
import 'package:flutter_application/utils/helpers/network_manager.dart';
import 'package:flutter_application/utils/popups/full_screen_loader.dart';
import 'package:flutter_application/utils/popups/loaders.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  // Variables
  final email = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final password = TextEditingController();
  final repeatPassword = TextEditingController();
  final userController = Get.put(UserController());
  final _cartRepository = Get.put(CartRepository());
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  @override
  void onClose() {
    email.dispose();
    firstName.dispose();
    lastName.dispose();
    password.dispose();
    repeatPassword.dispose();
    super.onClose();
  }

  Future<void> signup() async {
    // Start Loading
    try {
      TFullScreenLoader.openLoadingDialog('We are processing your information...');

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!signupFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Register user in Firebase Authentication & save user data in Firebase
      await AuthenticationRepository.instance.registerWithEmailAndPassword(email.text.trim(), password.text.trim());
      
      // Save authenticated user data in Firebase Firestore
      CartModel newCart = await _cartRepository.createUserCart(AuthenticationRepository.instance.getUserID);

      final newUser = UserModel(
        id: AuthenticationRepository.instance.getUserID,
        email: email.text.trim(),
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        birthday: '',
        gender: 'all',
        phoneNo: '',
        address: '',
        cartId: newCart.id
      );

      await userController.saveUserRecord(user: newUser);

      // Remove Loader
      TFullScreenLoader.stopLoading();

      await _cartRepository.deleteAnonymousCart(userController.currentCart.value.id);
      userController.currentCart.value = await _cartRepository.fetchUserCart(userController.user.value.id);

      // Success message
      Get.to(() => const SignupSuccessScreen());
      // Show some Generic Error to the user
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'An error occured', message: e.toString());
    }
  }
}
