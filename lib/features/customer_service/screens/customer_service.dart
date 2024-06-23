import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/utils/constants/asset_strings.dart';
import 'package:flutter_application/common/widgets/buttons.dart';
import 'package:flutter_application/utils/constants/colors.dart';
import 'package:flutter_application/utils/constants/text_styles.dart';
import 'package:flutter_application/common/widgets/navbar.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CustomerSupportScreen extends StatelessWidget {
  const CustomerSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(selectedOption: 'explore',),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bkg4),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(bkg4),
                      fit: BoxFit.cover,
                    ),
                    border: Border(
                        bottom:
                            BorderSide(color: Color(0xFFB23A48), width: 3))),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(CupertinoIcons.chevron_left,
                              color: red5, size: 32),
                          onPressed: () => Get.back(),
                        ),
                        Text(
                          'Customer support',
                          style: h4.copyWith(color: red5),
                        ),
                        const SizedBox(
                          width: 32,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    )
                  ],
                )),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text:
                            'Our Customer Support specialists are available everyday from ',
                        style: tParagraph.copyWith(color: grey8)),
                    TextSpan(
                        text: '10:00-18:00',
                        style: tParagraph.copyWith(
                            color: grey8, fontWeight: FontWeight.w700)),
                    TextSpan(
                        text:
                            '. If you need help outside this interval, you can chat with our AI Assistant, ',
                        style: tParagraph.copyWith(color: grey8)),
                    TextSpan(
                        text: 'Drip, available 24/7',
                        style: tParagraph.copyWith(
                            color: grey8, fontWeight: FontWeight.w700)),
                    TextSpan(
                        text: '.', style: tParagraph.copyWith(color: grey8)),
                  ])),
                  const SizedBox(
                    height: 32,
                  ),
                  Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x59223944),
                            spreadRadius: 0,
                            blurRadius: 30,
                            offset:
                                Offset(0, 8), // (0, -8) for BottomBarNavigation
                          )
                        ],
                      ),
                      child: ButtonTypeIcon(
                          text: 'Call 123-456-789',
                          icon: CupertinoIcons.phone,
                          color: pink5,
                          type: 'primary',
                          onPressed: () => launchUrlString("tel://123456789"))),
                  const SizedBox(
                    height: 24,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x59223944),
                          spreadRadius: 0,
                          blurRadius: 30,
                          offset:
                              Offset(0, 8), // (0, -8) for BottomBarNavigation
                        )
                      ],
                    ),
                    child: ButtonTypeIcon(
                        text: 'Email support@droplet.com',
                        icon: CupertinoIcons.mail,
                        color: blue7,
                        type: 'primary',
                        onPressed: () =>
                            launchUrlString("mailto:support@droplet.com")),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x59223944),
                          spreadRadius: 0,
                          blurRadius: 30,
                          offset:
                              Offset(0, 8), // (0, -8) for BottomBarNavigation
                        )
                      ],
                    ),
                    child: ButtonTypeIcon(
                        text: 'Chat with Drip',
                        icon: CupertinoIcons.chat_bubble,
                        color: red5,
                        type: 'primary',
                        onPressed: (){}) // => Get.to(() => const ChatbotScreen())),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
