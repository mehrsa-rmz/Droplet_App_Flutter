import 'package:flutter_application/features/appointments/screens/appointments_history.dart';
import 'package:flutter_application/features/articles/screens/articles.dart';
import 'package:flutter_application/features/customer_service/screens/customer_service.dart';
import 'package:flutter_application/features/products/screens/gift_guide_categories.dart';
import 'package:flutter_application/features/products/screens/hypoallergenic.dart';
import 'package:flutter_application/features/products/screens/personal_rec.dart';
import 'package:flutter_application/features/stores_map/screens/stores_map.dart';
import 'package:flutter_application/utils/constants/colors.dart';
import 'package:flutter_application/utils/constants/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/utils/constants/asset_strings.dart';
import 'package:flutter_application/common/widgets/navbar.dart';
import 'package:get/get.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key, this.isLogged = false});

  final bool isLogged;

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
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 48),
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(children: [
                      Container(
                          width: context.width / 2 - 24,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: const DecorationImage(
                              image: AssetImage(bkg4),
                              fit: BoxFit.cover,
                            ),
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
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: TextButton(
                              style: TextButton.styleFrom(
                                overlayColor:
                                    const Color.fromARGB(0, 255, 255, 255),
                              ),
                              onPressed: () => Get.to(() => const StoresMapScreen()),
                              child: Column(
                                children: [
                                  Icon(CupertinoIcons.placemark,
                                      color: blue8, size: 24),
                                  const SizedBox(height: 8),
                                  Text('Stores',
                                      style: tButton.copyWith(color: blue8))
                                ],
                              ))),
                      const SizedBox(
                        width: 16,
                      ),
                      Container(
                          width: context.width / 2 - 24,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: const DecorationImage(
                              image: AssetImage(bkg4),
                              fit: BoxFit.cover,
                            ),
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
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: TextButton(
                              style: TextButton.styleFrom(
                                overlayColor:
                                    const Color.fromARGB(0, 255, 255, 255),
                              ),
                              onPressed: () => Get.to(() => const ArticlesScreen()),
                              child: Column(
                                children: [
                                  Icon(CupertinoIcons.book,
                                      color: blue8, size: 24),
                                  const SizedBox(height: 8),
                                  Text('Medical advice',
                                      style: tButton.copyWith(color: blue8))
                                ],
                              )))
                    ]),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(children: [
                      Container(
                          width: context.width / 2 - 24,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: const DecorationImage(
                              image: AssetImage(bkg4),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x59223944),
                                spreadRadius: 0,
                                blurRadius: 30,
                                offset: Offset(0, 8),
                              )
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: TextButton(
                              style: TextButton.styleFrom(
                                overlayColor:
                                    const Color.fromARGB(0, 255, 255, 255),
                              ),
                              onPressed: () => Get.to(() => AppointmentsHistoryScreen(isLogged: isLogged)),
                              child: Column(
                                children: [
                                  Icon(CupertinoIcons.calendar,
                                      color: blue8, size: 24),
                                  const SizedBox(height: 8),
                                  Text('Appointments',
                                      style: tButton.copyWith(color: blue8))
                                ],
                              ))),
                      const SizedBox(
                        width: 16,
                      ),
                      Container(
                          width: context.width / 2 - 24,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: const DecorationImage(
                              image: AssetImage(bkg4),
                              fit: BoxFit.cover,
                            ),
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
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: TextButton(
                              style: TextButton.styleFrom(
                                overlayColor:
                                    const Color.fromARGB(0, 255, 255, 255),
                              ),
                              onPressed: () => Get.to(() => const CustomerSupportScreen()),
                              child: Column(
                                children: [
                                  Icon(CupertinoIcons.phone,
                                      color: blue8, size: 24),
                                  const SizedBox(height: 8),
                                  Text('Customer support',
                                      textAlign: TextAlign.center,
                                      style: tButton.copyWith(color: blue8))
                                ],
                              )))
                    ]),
                    isLogged
                        ? Column(
                            children: [
                              const SizedBox(
                                height: 32,
                              ),
                              Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: pink3,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0x59223944),
                                        spreadRadius: 0,
                                        blurRadius: 30,
                                        offset: Offset(0,
                                            8), // (0, -8) for BottomBarNavigation
                                      )
                                    ],
                                  ),
                                  child: TextButton(
                                      style: TextButton.styleFrom(
                                        minimumSize: Size.zero,
                                        padding: EdgeInsets.zero,
                                        overlayColor: const Color.fromARGB(
                                            0, 255, 255, 255),
                                      ),
                                      onPressed: () => Get.to(() => const PersonalRecScreen()),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                              height: 112,
                                              width: 102,
                                              child: Image.asset(
                                                banner1,
                                                fit: BoxFit.cover,
                                              )),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                top: 8, bottom: 8, right: 12),
                                            child: SizedBox(
                                              width:
                                                  context.width - 102 - 12 - 32,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      'Discover your selection',
                                                      style: h6.copyWith(
                                                          color: black)),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                      'We carefully curated a list of products tailored to your needs.',
                                                      style: tParagraphSmall
                                                          .copyWith(
                                                              color: grey8)),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        border: Border(
                                                            top: BorderSide(
                                                                color: pink6,
                                                                width: 1))),
                                                    child: Column(
                                                      children: [
                                                        const SizedBox(
                                                          height: 8,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              'TAKE A LOOK',
                                                              style: tSubtext
                                                                  .copyWith(
                                                                      color:
                                                                          pink6),
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Icon(
                                                                CupertinoIcons
                                                                    .chevron_right,
                                                                color: pink6,
                                                                size: 16)
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ))),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          )
                        : const SizedBox(
                            height: 32,
                          ),
                    Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: blue4,
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
                        child: TextButton(
                            style: TextButton.styleFrom(
                              minimumSize: Size.zero,
                              padding: EdgeInsets.zero,
                              overlayColor:
                                  const Color.fromARGB(0, 255, 255, 255),
                            ),
                            onPressed: () => Get.to(() => const HypoallergenicScreen()),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                      top: 8, bottom: 8, left: 12),
                                  child: SizedBox(
                                    width: context.width - 85 - 12 - 33,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Hypoallergenic products',
                                            style: h6.copyWith(color: white1)),
                                        const SizedBox(height: 8),
                                        Text(
                                            'Specifically designed for sensitive skin.',
                                            style: tParagraphSmall.copyWith(
                                                color: grey1)),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  top: BorderSide(
                                                      color: blue8, width: 1))),
                                          child: Column(
                                            children: [
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'TAKE A LOOK',
                                                    style: tSubtext.copyWith(
                                                        color: blue8),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Icon(
                                                      CupertinoIcons
                                                          .chevron_right,
                                                      color: blue8,
                                                      size: 16)
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Image.asset(banner2, height: 96),
                              ],
                            ))),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: red4,
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
                        child: TextButton(
                            style: TextButton.styleFrom(
                              minimumSize: Size.zero,
                              padding: EdgeInsets.zero,
                              overlayColor:
                                  const Color.fromARGB(0, 255, 255, 255),
                            ),
                            onPressed: () => Get.to(() => const GiftGuideCategoriesScreen()),
                            child: Row(
                              children: [
                                Image.asset(
                                  banner3,
                                  height: 112,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      top: 8, bottom: 8, right: 12),
                                  child: SizedBox(
                                    width: context.width - 102 - 12 - 33,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Gift guide',
                                            style: h6.copyWith(color: white1)),
                                        const SizedBox(height: 8),
                                        Text(
                                            'Need help finding the special gifts for the special people in your life? Let us help.',
                                            style: tParagraphSmall.copyWith(
                                                color: grey1)),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  top: BorderSide(
                                                      color: red6, width: 1))),
                                          child: Column(
                                            children: [
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'TAKE A LOOK',
                                                    style: tSubtext.copyWith(
                                                        color: red6),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Icon(
                                                      CupertinoIcons
                                                          .chevron_right,
                                                      color: red6,
                                                      size: 16)
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ))),
                    const SizedBox(
                      height: 16,
                    ),
                    // Container(
                    //     clipBehavior: Clip.antiAlias,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(8),
                    //       color: pink3,
                    //       boxShadow: const [
                    //         BoxShadow(
                    //           color: Color(0x59223944),
                    //           spreadRadius: 0,
                    //           blurRadius: 30,
                    //           offset: Offset(
                    //               0, 8), // (0, -8) for BottomBarNavigation
                    //         )
                    //       ],
                    //     ),
                    //     child: TextButton(
                    //         style: TextButton.styleFrom(
                    //           minimumSize: Size.zero,
                    //           padding: EdgeInsets.zero,
                    //           overlayColor:
                    //               const Color.fromARGB(0, 255, 255, 255),
                    //         ),
                    //         onPressed: () => Get.to(() => const ArticlesScreen()),
                    //         child: Row(
                    //           children: [
                    //             Container(
                    //               padding: const EdgeInsets.only(
                    //                   top: 8, bottom: 8, left: 12),
                    //               child: SizedBox(
                    //                 width: context.width - 97 - 12 - 33,
                    //                 child: Column(
                    //                   mainAxisAlignment:
                    //                       MainAxisAlignment.start,
                    //                   mainAxisSize: MainAxisSize.min,
                    //                   crossAxisAlignment:
                    //                       CrossAxisAlignment.start,
                    //                   children: [
                    //                     Text('Advice from specialists',
                    //                         style: h6.copyWith(color: black)),
                    //                     const SizedBox(height: 8),
                    //                     Text(
                    //                         'Access personalized dermatological recommendations from medical professionals.',
                    //                         style: tParagraphSmall.copyWith(
                    //                             color: grey8)),
                    //                     const SizedBox(
                    //                       height: 8,
                    //                     ),
                    //                     Container(
                    //                       decoration: BoxDecoration(
                    //                           border: Border(
                    //                               top: BorderSide(
                    //                                   color: pink6, width: 1))),
                    //                       child: Column(
                    //                         children: [
                    //                           const SizedBox(
                    //                             height: 8,
                    //                           ),
                    //                           Row(
                    //                             mainAxisAlignment:
                    //                                 MainAxisAlignment.center,
                    //                             children: [
                    //                               Text(
                    //                                 'TAKE A LOOK',
                    //                                 style: tSubtext.copyWith(
                    //                                     color: pink6),
                    //                               ),
                    //                               const SizedBox(
                    //                                 width: 10,
                    //                               ),
                    //                               Icon(
                    //                                   CupertinoIcons
                    //                                       .chevron_right,
                    //                                   color: pink6,
                    //                                   size: 16)
                    //                             ],
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     )
                    //                   ],
                    //                 ),
                    //               ),
                    //             ),
                    //             Image.asset(banner4, height: 128),
                    //           ],
                    //         ))),
                  ],
                )
              ],
            )));
  }
}
