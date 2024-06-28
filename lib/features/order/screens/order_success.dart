import 'package:flutter/material.dart';
import 'package:flutter_application/features/explore/screens/explore.dart';
import 'package:flutter_application/utils/constants/asset_strings.dart';
import 'package:flutter_application/utils/constants/text_styles.dart';
import 'package:flutter_application/utils/constants/colors.dart';
import 'package:flutter_application/common/widgets/buttons.dart';
import 'package:get/get.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(bkg1),
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
                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                              text: 'Order placed ',
                              style: h41.copyWith(color: blue7)),
                          TextSpan(
                              text: 'successfully',
                              style: h41.copyWith(color: green))
                        ])),
                    const SizedBox(height: 32),
                    Text(
                      'Thank you for your order! 🥳 We can’t wait for you to experience our products. ❤',
                      style: tParagraph.copyWith(color: grey8),
                    ),
                    const SizedBox(height: 32),
                    ButtonType(
                      text: 'Back to homepage',
                      color: red5,
                      type: 'primary',
                      onPressed: () => Get.offAll(() => const ExploreScreen()),
                    ),
                  ],
                )),
          )),
    );
  }
}
