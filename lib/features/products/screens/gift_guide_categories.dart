import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/features/products/screens/gift_guide.dart';
import 'package:flutter_application/utils/constants/colors.dart';
import 'package:flutter_application/utils/constants/text_styles.dart';
import 'package:flutter_application/utils/constants/asset_strings.dart';
import 'package:flutter_application/common/widgets/navbar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class GiftGuideCategoriesScreen extends StatelessWidget {
  const GiftGuideCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const BottomNavBar(selectedOption: 'explore',),
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(bkg2),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
                child: ListView(children: [
              Container(
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage(bkg2),
                    fit: BoxFit.cover,
                  ),
                  border: Border(
                    bottom: BorderSide(color: blue7, width: 3),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(CupertinoIcons.chevron_left,
                              color: blue7, size: 32),
                          onPressed: () => Get.back(),
                        ),
                        Text('Gift guide', style: h4.copyWith(color: blue7)),
                        const SizedBox(width: 32),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    overlayColor: const Color.fromARGB(0, 255, 255, 255),
                  ),
                  onPressed: () => Get.to(() => GiftGuideScreen(sex: 'f',)),
                  child: Container(
                      width: context.width,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: red4,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x59223944),
                            spreadRadius: 0,
                            blurRadius: 30,
                            offset:
                                Offset(0, 8),
                          )
                        ],
                      ),
                      child: Text(
                        'For the women in your life',
                        style: tLogoSmall.copyWith(color: white1),
                      ))),
              const SizedBox(height: 16),
              Row(children: [
                const SizedBox(
                  width: 16,
                ),
                TextButton(
                    style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        overlayColor: const Color.fromARGB(0, 255, 255, 255),
                        padding: const EdgeInsets.all(0)),
                    onPressed: () => Get.to(() => GiftGuideScreen(sex: 'f', age: '16-24 years',)),
                    child: Container(
                        height: 156,
                        width: context.width / 3 - 64 / 3,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: white1,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x59223944),
                              spreadRadius: 0,
                              blurRadius: 30,
                              offset: Offset(
                                  0, 8),
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SvgPicture.asset(giftGirl),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              '16 - 24 y',
                              style: tParagraph.copyWith(color: red5),
                            )
                          ],
                        ))),
                const SizedBox(
                  width: 16,
                ),
                TextButton(
                    style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        overlayColor: const Color.fromARGB(0, 255, 255, 255),
                        padding: const EdgeInsets.all(0)),
                    onPressed: () => Get.to(() => GiftGuideScreen(sex: 'f', age: '25-49 years',)),
                    child: Container(
                        height: 156,
                        width: context.width / 3 - 64 / 3,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: white1,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x59223944),
                              spreadRadius: 0,
                              blurRadius: 30,
                              offset: Offset(
                                  0, 8),
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SvgPicture.asset(giftWoman),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              '25 - 49 y',
                              style: tParagraph.copyWith(color: red5),
                            )
                          ],
                        ))),
                const SizedBox(
                  width: 16,
                ),
                TextButton(
                    style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        overlayColor: const Color.fromARGB(0, 255, 255, 255),
                        padding: const EdgeInsets.all(0)),
                    onPressed: () => Get.to(() => GiftGuideScreen(sex: 'f', age: '50+ years',)),
                    child: Container(
                        height: 156,
                        width: context.width / 3 - 64 / 3,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: white1,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x59223944),
                              spreadRadius: 0,
                              blurRadius: 30,
                              offset: Offset(
                                  0, 8), // (0, -8) for BottomBarNavigation
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SvgPicture.asset(giftOldWoman),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              '50+ years',
                              style: tParagraph.copyWith(color: red5),
                            )
                          ],
                        ))),
              ]),
              const SizedBox(
                height: 16,
              ),
              TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    overlayColor: const Color.fromARGB(0, 255, 255, 255),
                  ),
                  onPressed: () => Get.to(() => GiftGuideScreen(sex: 'm',)),
                  child: Container(
                      width: context.width,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: blue4,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x59223944),
                            spreadRadius: 0,
                            blurRadius: 30,
                            offset:
                                Offset(0, 8),
                          )
                        ],
                      ),
                      child: Text(
                        'For the men in your life',
                        style: tLogoSmall.copyWith(color: white1),
                      ))),
              const SizedBox(height: 16),
              Row(children: [
                const SizedBox(
                  width: 16,
                ),
                TextButton(
                    style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        overlayColor: const Color.fromARGB(0, 255, 255, 255),
                        padding: const EdgeInsets.all(0)),
                    onPressed: () => Get.to(() => GiftGuideScreen(sex: 'm', age: '16-24 years',)),
                    child: Container(
                        height: 156,
                        width: context.width / 3 - 64 / 3,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: white1,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x59223944),
                              spreadRadius: 0,
                              blurRadius: 30,
                              offset: Offset(
                                  0, 8), // (0, -8) for BottomBarNavigation
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SvgPicture.asset(giftBoy),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              '16 - 24 y',
                              style: tParagraph.copyWith(color: blue7),
                            )
                          ],
                        ))),
                const SizedBox(
                  width: 16,
                ),
                TextButton(
                    style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        overlayColor: const Color.fromARGB(0, 255, 255, 255),
                        padding: const EdgeInsets.all(0)),
                    onPressed: () => Get.to(() => GiftGuideScreen(sex: 'm', age: '25-49 years',)),
                    child: Container(
                        height: 156,
                        width: context.width / 3 - 64 / 3,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: white1,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x59223944),
                              spreadRadius: 0,
                              blurRadius: 30,
                              offset: Offset(
                                  0, 8), // (0, -8) for BottomBarNavigation
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SvgPicture.asset(giftMan),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              '25 - 49 y',
                              style: tParagraph.copyWith(color: blue7),
                            )
                          ],
                        ))),
                const SizedBox(
                  width: 16,
                ),
                TextButton(
                    style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        overlayColor: const Color.fromARGB(0, 255, 255, 255),
                        padding: const EdgeInsets.all(0)),
                    onPressed:() => Get.to(() => GiftGuideScreen(sex: 'm', age: '50+ years',)),
                    child: Container(
                        height: 156,
                        width: context.width / 3 - 64 / 3,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: white1,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x59223944),
                              spreadRadius: 0,
                              blurRadius: 30,
                              offset: Offset(
                                  0, 8),
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SvgPicture.asset(giftOldMan),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              '50+ years',
                              style: tParagraph.copyWith(color: blue7),
                            )
                          ],
                        ))),
              ]),
            ]))));
  }
}
