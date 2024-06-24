import 'package:flutter/material.dart';
import 'package:flutter_application/data/repositories/authentication_repository.dart';
import 'package:flutter_application/features/profile/controllers/user_controller.dart';
import 'package:flutter_application/utils/helpers/network_manager.dart';
import 'package:flutter_application/utils/popups/full_screen_loader.dart';
import 'package:flutter_application/utils/popups/loaders.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final userController = Get.put(UserController());
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    super.onClose();
  }

  Future<void> login() async {
    try {
      TFullScreenLoader.openLoadingDialog('Logging you in...');

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        TLoaders.customToast(message: 'No Internet Connection');
        return;
      }

      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      final userCredentials = await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      await userController.fetchUserRecord();

      TFullScreenLoader.stopLoading();

      await AuthenticationRepository.instance.screenRedirect(userCredentials.user);
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'An error occured', message: e.toString());
    }
  }
}
