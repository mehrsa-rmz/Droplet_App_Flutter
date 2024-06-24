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

  final email = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final password = TextEditingController();
  final repeatPassword = TextEditingController();
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
    try {
      TFullScreenLoader.openLoadingDialog('We are processing your information...');

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!signupFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance.registerWithEmailAndPassword(email.text.trim(), password.text.trim());

      final newUser = UserModel(
        id: AuthenticationRepository.instance.getUserID,
        email: email.text.trim(),
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        birthday: null,
        gender: '',
        phoneNo: '',
        address: '',
      );

      await UserController.instance.saveUserRecord(user: newUser);

      TFullScreenLoader.stopLoading();

      Get.to(() => const SignupSuccessScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'An error occured', message: e.toString());
    }
  }
}
