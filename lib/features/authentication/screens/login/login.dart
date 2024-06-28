import 'package:flutter_application/features/authentication/controllers/login_controller.dart';
import 'package:flutter_application/features/authentication/screens/reset/reset.dart';
import 'package:flutter_application/features/authentication/screens/signup/signup.dart';
import 'package:flutter_application/utils/constants/colors.dart';
import 'package:flutter_application/utils/constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/utils/constants/asset_strings.dart';
import 'package:flutter_application/common/widgets/buttons.dart';
import 'package:flutter_application/common/widgets/inputs.dart';
import 'package:flutter_application/utils/validators/validation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
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
                  Text('Login', style: h3.copyWith(color: blue7)),
                  const SizedBox(height: 32),
                  Form(
                    key: controller.loginFormKey,
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
                        const SizedBox(height: 16),
                        InputType(
                           controller: controller.password,
                            validator: (value) => TValidator.validateEmptyText('Password', value),
                            type: 'password',
                            inputType: TextInputType.visiblePassword,
                            placeholder: 'Password',
                            mustBeFilled: true,
                            ),
                        const SizedBox(height: 32),
                        ButtonType(
                          text: 'Login',
                          color: blue7,
                          type: 'primary',
                          onPressed: () => controller.login(),
                        ),
                        const SizedBox(height: 12),
                        ButtonType(
                          text: 'Sign up',
                          color: blue7,
                          type: 'secondary',
                          onPressed: () => Get.off(() => const SignupScreen()),
                        ),
                        const SizedBox(height: 12),
                        ButtonType(
                          text: 'Forgot password?',
                          color: blue7,
                          type: 'tertiary',
                          onPressed: () => Get.off(() => const ResetScreen()),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
