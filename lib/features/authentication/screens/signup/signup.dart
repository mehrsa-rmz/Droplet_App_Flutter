import 'package:flutter_application/features/authentication/controllers/signup_controller.dart';
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

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: context.height,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(bkg3),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
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
                    Text('Sign Up', style: h3.copyWith(color: blue7)),
                    const SizedBox(height: 32),
                    const SignupForm(),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

class SignupForm extends StatelessWidget {
  const SignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          InputType(
            controller: controller.email,
            validator: (value) => TValidator.validateEmail(value),
            type: 'one-line',
            inputType: TextInputType.emailAddress,
            placeholder: 'Email',
            mustBeFilled: true,
          ),
          const SizedBox(height: 16),
          InputType(
            controller: controller.firstName,
            validator: (value) =>
                TValidator.validateEmptyText('First name', value),
            type: 'one-line',
            inputType: TextInputType.name,
            placeholder: 'First Name',
            mustBeFilled: true,
          ),
          const SizedBox(height: 16),
          InputType(
            controller: controller.lastName,
            validator: (value) =>
                TValidator.validateEmptyText('Last name', value),
            type: 'one-line',
            inputType: TextInputType.name,
            placeholder: 'Last Name',
            mustBeFilled: true,
          ),
          const SizedBox(height: 16),
          InputType(
            controller: controller.password,
            validator: (value) => TValidator.validatePassword(value),
            type: 'password',
            inputType: TextInputType.visiblePassword,
            placeholder: 'Password',
            mustBeFilled: true,
          ),
          const SizedBox(height: 8),
          Text(
              'The password must contain at least: \nan uppercase (A) and a lowercase (a) character, a number (1) and a special character (#).',
              style: tParagraphSmall.copyWith(color: grey8)),
          const SizedBox(height: 16),
          InputType(
            controller: controller.repeatPassword,
            validator: (value) => TValidator.validateRepeatPassword(
                controller.password.text, value),
            type: 'password',
            inputType: TextInputType.visiblePassword,
            placeholder: 'Repeat password',
            mustBeFilled: true,
          ),
          const SizedBox(height: 32),
          ButtonType(
            text: 'Create account',
            color: blue7,
            type: 'primary',
            onPressed: () => controller.signup(),
          ),
          const SizedBox(height: 12),
          ButtonType(
            text: 'Go to login',
            color: blue7,
            type: 'secondary',
            onPressed: () => Get.to(() => const LoginScreen()),
          ),
        ],
      ),
    );
  }
}
