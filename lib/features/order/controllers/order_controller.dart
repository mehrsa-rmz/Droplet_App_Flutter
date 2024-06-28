import 'package:flutter/material.dart';
import 'package:flutter_application/utils/popups/full_screen_loader.dart';
import 'package:flutter_application/utils/popups/loaders.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  // Variables
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final phoneNo = TextEditingController();
  final email = TextEditingController();
  final address = TextEditingController();
  GlobalKey<FormState> checkoutKey= GlobalKey<FormState>();

  @override
  void onClose() {
    firstName.dispose();
    lastName.dispose();
    phoneNo.dispose();
    email.dispose();
    address.dispose();
    super.onClose();
  }

  /// -- Email and Password SignIn
  Future<void> checkout() async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog('Processing order...');

      // Form Validation
      if (!checkoutKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Remove Loader
      TFullScreenLoader.stopLoading();

    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'An error occured', message: e.toString());
    }
  }
}
