import 'package:flutter/material.dart';
import 'package:flutter_application/features/products/screens/products.dart';
import 'package:flutter_application/utils/constants/asset_strings.dart';
import 'package:flutter_application/utils/constants/text_styles.dart';
import 'package:flutter_application/utils/constants/colors.dart';
import 'package:flutter_application/common/widgets/navbar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProductCategoriesScreen extends StatefulWidget {
  const ProductCategoriesScreen({super.key});

  @override
  State<ProductCategoriesScreen> createState() =>
      _ProductCategoriesScreenState();
}

class _ProductCategoriesScreenState extends State<ProductCategoriesScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const BottomNavBar(selectedOption: 'products',),
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(bkg2),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
                child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                  Column(children: [
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: const EdgeInsets.all(0),
                            overlayColor: const Color.fromARGB(0, 255, 255, 255),
                          ),
                          onPressed: () => Get.to(() => ProductsScreen(category: 'skin',)),
                          child: Container(
                              width: context.width / 2 - 16 - 8,
                              padding: const EdgeInsets.all(12),
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
                                children: [
                                  SvgPicture.asset(categorySkincare),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Text('Skincare',
                                      style: h42.copyWith(color: red5))
                                ],
                              )),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: const EdgeInsets.all(0),
                            overlayColor: const Color.fromARGB(0, 255, 255, 255),
                          ),
                          onPressed: () => Get.to(() => ProductsScreen(category: 'hair',)),
                          child: Container(
                              width: context.width / 2 - 16 - 8,
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
                                children: [
                                  SvgPicture.asset(categoryHaircare),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Text('Haircare',
                                      style: h42.copyWith(color: red5))
                                ],
                              )),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: const EdgeInsets.all(0),
                            overlayColor: const Color.fromARGB(0, 255, 255, 255),
                          ),
                          onPressed: () => Get.to(() => ProductsScreen(category: 'body',)),
                          child: Container(
                              width: context.width / 2 - 16 - 8,
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
                                children: [
                                  SvgPicture.asset(categoryBody),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Text('Body', style: h42.copyWith(color: red5))
                                ],
                              )),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: const EdgeInsets.all(0),
                            overlayColor: const Color.fromARGB(0, 255, 255, 255),
                          ),
                          onPressed: () => Get.to(() => ProductsScreen(category: 'perfume',)),
                          child: Container(
                              width: context.width / 2 - 16 - 8,
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
                                children: [
                                  SvgPicture.asset(categoryPerfume),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Text('Perfume',
                                      style: h42.copyWith(color: red5))
                                ],
                              )),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: const EdgeInsets.all(0),
                        overlayColor: const Color.fromARGB(0, 255, 255, 255),
                      ),
                      onPressed: () => Get.to(() => ProductsScreen(category: 'all',)),
                      child: Container(
                          alignment: Alignment.center,
                          width: context.width,
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
                          child: Text('See all products',
                              style: h42.copyWith(color: red5))),
                    )
                  ])
                ]))));
  }
}
