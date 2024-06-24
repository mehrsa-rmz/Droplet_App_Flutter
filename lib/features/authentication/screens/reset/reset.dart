import 'package:flutter_application/features/authentication/controllers/reset_password_controller.dart';
import 'package:flutter_application/features/authentication/screens/login/login.dart';
import 'package:flutter_application/utils/constants/colors.dart';
import 'package:flutter_application/utils/constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/utils/constants/asset_strings.dart';
import 'package:flutter_application/common/widgets/buttons.dart';
import 'package:flutter_application/common/widgets/inputs.dart';
import 'package:flutter_application/utils/validators/validation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ResetScreen extends StatelessWidget {
  const ResetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ResetController());
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bkg3),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
            decoration: BoxDecoration(
              color: white1,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x59223944),
                  spreadRadius: 0,
                  blurRadius: 30,
                  offset: Offset(0, 8),
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(children: [
                  SvgPicture.asset(logoSmall),
                  const SizedBox(width: 4),
                  Text('Droplet', style: tLogoSmall.copyWith(color: blue7))
                ]),
                const SizedBox(height: 20),
                Text('Reset password', style: h3.copyWith(color: blue7)),
                const SizedBox(height: 32),
                Text(
                  'Enter your email address below and we will send you a code to reset your password.',
                  style: tParagraph.copyWith(color: grey8),
                ),
                const SizedBox(height: 32),
                Form(
                  key: controller.resetPasswordFormKey,
                  child: Column(
                    children: [
                      InputType(
                        controller: controller.email,
                        validator: TValidator.validateEmail,
                        type: 'one-line',
                        inputType: TextInputType.emailAddress,
                        placeholder: 'Email',
                        mustBeFilled: true,
                      ),
                      const SizedBox(height: 32),
                      ButtonType(
                        text: 'Send code',
                        color: blue7,
                        type: 'primary',
                        onPressed: () => controller.sendPasswordResetEmail(),
                      ),
                      const SizedBox(height: 12),
                      ButtonType(
                        text: 'Go to login',
                        color: blue7,
                        type: 'secondary',
                        onPressed: () {
                          // Adding debug log
                          debugPrint('Navigating to LoginScreen from ResetScreen');
                          Get.off(() => const LoginScreen());
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
