import 'package:flutter/material.dart';
import 'package:flutter_application/common/widgets/buttons.dart';
import 'package:flutter_application/utils/constants/text_styles.dart';
import '../../../utils/constants/colors.dart';

/// A widget for displaying an animated loading indicator with optional text and action button.
class TLoaderWidget extends StatelessWidget {
  /// Default constructor for the TLoaderWidget.
  ///
  /// Parameters:
  ///   - text: The text to be displayed.
  ///   - showAction: Whether to show an action button below the text.
  ///   - actionText: The text to be displayed on the action button.
  ///   - onActionPressed: Callback function to be executed when the action button is pressed.
  const TLoaderWidget({
    super.key,
    required this.text,
    this.showAction = false,
    this.actionText,
    this.onActionPressed,
  });

  final String text;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: h5.copyWith(color: white1),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          showAction
              ? SizedBox(
                  width: 250,
                  child: ButtonType(text: actionText!, color: pink5, type: 'secondary'),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
