import 'package:flutter/material.dart';
import 'package:flutter_application/features/authentication/screens/login/login.dart';
import 'package:flutter_application/features/customer_service/screens/customer_service.dart';
import 'package:flutter_application/utils/constants/asset_strings.dart';
import 'package:flutter_application/common/widgets/buttons.dart';
import 'package:flutter_application/utils/constants/colors.dart';
import 'package:flutter_application/utils/constants/text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginScreenFail extends StatelessWidget {
  const LoginScreenFail({super.key});

  @override
  Widget build(BuildContext context) {
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
                      offset: Offset(0, 8), // (0, -8) for BottomBarNavigation
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
                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                              text: 'Failed ',
                              style: h41.copyWith(color: red5)),
                          TextSpan(
                              text: 'to log into account',
                              style: h41.copyWith(color: blue7))
                        ])),
                    const SizedBox(height: 32),
                    Text(
                        'We ran into some difficulties. Try again and if the problem persists, contact technical support.',
                        style: tParagraph.copyWith(color: grey8)),
                    const SizedBox(height: 32),
                    ButtonType(
                      text: 'Contact support',
                      color: blue7,
                      type: 'primary',
                      onPressed: () => Get.to(() => const CustomerSupportScreen()),
                    ),
                    const SizedBox(height: 12),
                    ButtonType(
                      text: 'Try again',
                      color: blue7,
                      type: 'secondary',
                      onPressed: () => Get.to(() => const LoginScreen()),
                    ),
                  ],
                )),
          )),
    );
  }
}
