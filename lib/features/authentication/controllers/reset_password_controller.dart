import 'package:flutter/widgets.dart';
import 'package:flutter_application/data/repositories/authentication_repository.dart';
import 'package:flutter_application/features/authentication/screens/reset/check_email.dart';
import 'package:flutter_application/utils/helpers/network_manager.dart';
import 'package:flutter_application/utils/popups/full_screen_loader.dart';
import 'package:flutter_application/utils/popups/loaders.dart';
import 'package:get/get.dart';

class ResetController extends GetxController {
  static ResetController get instance => Get.find();

  /// Variables
  final email = TextEditingController();
  GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();

  @override
  void onClose() {
    email.dispose();
    super.onClose();
  }
  
  /// Send Reset Password EMail
  Future<void> sendPasswordResetEmail() async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog('Processing your request...');

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!resetPasswordFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Send Email to Reset Password
      await AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Redirect
      TLoaders.successSnackBar(title: 'Email Sent', message: 'Email Link Sent to Reset your Password'.tr);
      Get.to(() => CheckEmailScreen(email: email.text.trim()));
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'An error occured', message: e.toString());
    }
  }

  Future<void> resendPasswordResetEmail(String email) async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog('Processing your request...');

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Send EMail to Reset Password
      await AuthenticationRepository.instance.sendPasswordResetEmail(email.trim());

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Redirect
      TLoaders.successSnackBar(title: 'Email Sent', message: 'Email Link Sent to Reset your Password'.tr);
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'An error occured', message: e.toString());
    }
  }
}
