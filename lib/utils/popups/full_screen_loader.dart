import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../common/widgets/loaders/loader.dart';
import '../constants/colors.dart';

/// A utility class for managing a full-screen loading dialog.
class TFullScreenLoader {
  /// Open a full-screen loading dialog with a given text.
  /// This method doesn't return anything.
  ///
  /// Parameters:
  ///   - text: The text to be displayed in the loading dialog.
  static void openLoadingDialog(String text) {
    showDialog(
      context: Get.overlayContext!, // Use Get.overlayContext for overlay dialogs
      barrierDismissible: false, // The dialog can't be dismissed by tapping outside it
      builder: (_) => PopScope(
        canPop: false, // Disable popping with the back button
        child: Container(
          color: blue7,
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 300),
                const SpinKitFadingCircle(
                  color: Color(0xFFE6AB9E),
                  size: 100.0,
                ),
                const SizedBox(height: 36), // Adjust the spacing as needed
                TLoaderWidget(text: text),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Stop the currently open loading dialog.
  /// This method doesn't return anything.
  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop(); // Close the dialog using the Navigator
  }
}
