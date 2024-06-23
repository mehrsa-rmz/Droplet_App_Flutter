import 'package:flutter/material.dart';
import 'package:flutter_application/data/repositories/authentication_repository.dart';
import 'package:flutter_application/features/authentication/screens/signup/signup_success.dart';
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
  GlobalKey<FormState>  signupFormKey = GlobalKey<FormState>();

  // Update current index and jump to nextPage
  Future<void> signup() async {
    try{
      // Start Loading
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
      final newUser = UserModel(
        id: AuthenticationRepository.instance.getUserID,
        email: email.text.trim(),
        userFirstName: firstName.text.trim(),
        userLastName: lastName.text.trim(),
        birthday: null,
        gender: null,
        phoneNo: '',
        address: '',
      );

      await UserController.instance.saveUserRecord(user: newUser);

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Success message
      Get.to(() => const SignupSuccessScreen());
    }catch (e) {
      // Show some Generic Error to the user
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'An error occured', message: e.toString());
    }
  }
}