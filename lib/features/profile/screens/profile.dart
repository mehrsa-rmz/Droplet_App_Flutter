import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/features/authentication/screens/login/login.dart';
import 'package:flutter_application/features/authentication/screens/signup/signup.dart';
import 'package:flutter_application/features/profile/controllers/user_controller.dart';
import 'package:flutter_application/features/profile/screens/edit_profile.dart';
import 'package:flutter_application/features/profile/screens/loyalty_program.dart';
import 'package:flutter_application/utils/constants/asset_strings.dart';
import 'package:flutter_application/utils/constants/text_styles.dart';
import 'package:flutter_application/utils/constants/colors.dart';
import 'package:flutter_application/common/widgets/buttons.dart';
import 'package:flutter_application/common/widgets/navbar.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final controller = UserController.instance;
  
  var testersNo = 2;
  bool expanded = false;

  final List<Map<String, dynamic>> _products = [
    {
      'quantity': 1,
      'category': 'hair',
      'sex': 'f',
      'age': 'all',
      'conditions': ['thin hair', 'dandruff'],
      'hypoallergenic': true,
      'name': 'Hair Mousse',
      'price': 120.toDouble(),
      'reviewsNo': 21,
      'rating': 4.85,
      'favorite': false,
      'outOfStock': false,
      'noOfOrders': 10,
      'promotion': 0,
      'description':
          'This is a very long message meant for completing the text area input in order to make it look better. This is a very long message meant for completing the text area input in order to make it look better.',
      'ingredients': ['Water', 'Jojoba oil', 'Glycerin', 'Rose extract']
    },
    {
      'quantity': 1,
      'category': 'hair',
      'sex': 'f',
      'age': 'all',
      'conditions': ['thin hair', 'dandruff'],
      'hypoallergenic': true,
      'name': 'Shampoo',
      'price': 95.toDouble(),
      'reviewsNo': 10,
      'rating': 4.55,
      'favorite': true,
      'outOfStock': false,
      'noOfOrders': 5,
      'promotion': -20,
      'description':
          'This is a very long message meant for completing the text area input in order to make it look better. This is a very long message meant for completing the text area input in order to make it look better.',
      'ingredients': ['Water', 'Jojoba oil', 'Glycerin', 'Rose extract']
    },
    {
      'quantity': 2,
      'category': 'hair',
      'sex': 'f',
      'age': 'all',
      'conditions': ['thin hair', 'dandruff'],
      'hypoallergenic': true,
      'name': 'Conditioner',
      'price': 70.toDouble(),
      'reviewsNo': 6,
      'rating': 5.00,
      'favorite': false,
      'outOfStock': true,
      'noOfOrders': 2,
      'promotion': 0,
      'description':
          'This is a very long message meant for completing the text area input in order to make it look better. This is a very long message meant for completing the text area input in order to make it look better.',
      'ingredients': ['Water', 'Jojoba oil', 'Glycerin', 'Rose extract']
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(selectedOption: 'profile',),
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
                width: context.width,
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
                      height: 40,
                    ),
                    Text(
                      'Profile',
                      style: h4.copyWith(color: red5),
                    ),
                    const SizedBox(
                      height: 12,
                    )
                  ],
                )),
            user != null
                ? Expanded(
                    child: ListView(
                      children: [
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              children: [
                                const SizedBox(height: 32,),
                                ButtonTypeIcon(
                                  text: 'Loyalty Program',
                                  icon: CupertinoIcons.gift,
                                  color: pink5,
                                  type: 'primary',
                                  onPressed: () => Get.to(() => const LoyaltyProgramScreen()),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: white1,
                                      borderRadius: BorderRadius.circular(8),
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
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text('Pop Laura',
                                            style:
                                                tMenu.copyWith(color: black)),
                                        const SizedBox(height: 20),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: context.width / 2 -
                                                  6 -
                                                  20 -
                                                  16,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Client code',
                                                    style: tParagraph.copyWith(
                                                        color: black),
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(
                                                    '165432',
                                                    style: tParagraphMed
                                                        .copyWith(color: grey8),
                                                  )
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            SizedBox(
                                              width: context.width / 2 -
                                                  6 -
                                                  20 -
                                                  16,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Loyalty points',
                                                    style: tParagraph.copyWith(
                                                        color: black),
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(
                                                    '475',
                                                    style: tParagraphMed
                                                        .copyWith(color: grey8),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: context.width / 2 -
                                                  6 -
                                                  20 -
                                                  16,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Phone',
                                                    style: tParagraph.copyWith(
                                                        color: black),
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(
                                                    '0722 555 444',
                                                    style: tParagraphMed
                                                        .copyWith(color: grey8),
                                                  )
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            SizedBox(
                                              width: context.width / 2 -
                                                  6 -
                                                  20 -
                                                  16,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Email',
                                                    style: tParagraph.copyWith(
                                                        color: black),
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(
                                                    'poplaura@gmail.com',
                                                    style: tParagraphMed
                                                        .copyWith(color: grey8),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Address',
                                              style: tParagraph.copyWith(
                                                  color: black),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              'Bucuresti, Sector 4, str. Pacii nr. 54, bl. F2, scara 2, etaj 5, ap. 44, 0308334',
                                              style: tParagraphMed.copyWith(
                                                  color: grey8),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: context.width / 2 -
                                                  6 -
                                                  20 -
                                                  16,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Birthday',
                                                    style: tParagraph.copyWith(
                                                        color: black),
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(
                                                    'October 16th 1999',
                                                    style: tParagraphMed
                                                        .copyWith(color: grey8),
                                                  )
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            SizedBox(
                                              width: context.width / 2 -
                                                  6 -
                                                  20 -
                                                  16,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Gender',
                                                    style: tParagraph.copyWith(
                                                        color: black),
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(
                                                    'F',
                                                    style: tParagraphMed
                                                        .copyWith(color: grey8),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: context.width / 2 -
                                                  6 -
                                                  20 -
                                                  16,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Skin type',
                                                    style: tParagraph.copyWith(
                                                        color: black),
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(
                                                    'oily, sensitive, acne prone',
                                                    style: tParagraphMed
                                                        .copyWith(color: grey8),
                                                  )
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            SizedBox(
                                              width: context.width / 2 -
                                                  6 -
                                                  20 -
                                                  16,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Hair type',
                                                    style: tParagraph.copyWith(
                                                        color: black),
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(
                                                    'curly, dry, dyed, thick, frizzy',
                                                    style: tParagraphMed
                                                        .copyWith(color: grey8),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: context.width / 2 -
                                                  6 -
                                                  20 -
                                                  16,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Allergies',
                                                    style: tParagraph.copyWith(
                                                        color: black),
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(
                                                    '-',
                                                    style: tParagraphMed
                                                        .copyWith(color: grey8),
                                                  )
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            SizedBox(
                                              width: context.width / 2 -
                                                  6 -
                                                  20 -
                                                  16,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Preferences',
                                                    style: tParagraph.copyWith(
                                                        color: black),
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(
                                                    'floral, fruity, spiced',
                                                    style: tParagraphMed
                                                        .copyWith(color: grey8),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                                width: context.width / 2 -
                                                    6 -
                                                    20 -
                                                    16,
                                                child: ButtonTypeIcon(
                                                  text: 'Logout',
                                                  icon: CupertinoIcons
                                                      .square_arrow_left,
                                                  color: red5,
                                                  type: "secondary",
                                                  onPressed: () => showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return AlertDialog(
                                                          insetPadding: const EdgeInsets.all(16),
                                                          backgroundColor:white1,
                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                          shadowColor: blue7dtrans,
                                                          title: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.end,
                                                            children: [
                                                              IconButton(
                                                                icon: Icon(CupertinoIcons.xmark, color: red5, size: 24),
                                                                onPressed: () {Navigator.of(context).pop();},
                                                              ),
                                                              SizedBox(
                                                                  width: context.width,
                                                                  child: Text('Warning', textAlign: TextAlign.center, style: h5.copyWith(color: black))),
                                                              const SizedBox(height: 24),
                                                              SizedBox(
                                                                  width: context.width,
                                                                  child: Text( 'Are you sure you want to logout?', style: tParagraph.copyWith(color: grey8))),
                                                              const SizedBox(height: 24),
                                                              Row(children: [
                                                                SizedBox(
                                                                  width: context.width /2 -6 -40,
                                                                  child: ButtonType(
                                                                      text: 'Yes',
                                                                      color: red5,
                                                                      type: "primary",
                                                                      onPressed: () => controller.logout()
                                                                    )
                                                                  ),
                                                                const SizedBox(width: 12),
                                                                SizedBox(
                                                                    width: context.width / 2 - 6 - 40,
                                                                    child: ButtonType(
                                                                        text: 'Cancel',
                                                                        color: blue7,
                                                                        type: "secondary",
                                                                        onPressed: () => Navigator.of(context).pop()))
                                                              ]),
                                                            ],
                                                          ),
                                                        );
                                                      }),
                                                )),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            SizedBox(
                                                width: context.width / 2 -
                                                    6 -
                                                    20 -
                                                    16,
                                                child: ButtonTypeIcon(
                                                    text: 'Edit',
                                                    icon: CupertinoIcons
                                                        .square_pencil,
                                                    color: blue7,
                                                    type: "secondary",
                                                    onPressed: () => Get.to(() => const EditProfileScreen())))
                                          ],
                                        )
                                      ],
                                    )),
                                const SizedBox(height: 20),
                                Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: white1,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color(0x59223944),
                                          spreadRadius: 0,
                                          blurRadius: 30,
                                          offset: Offset(0,
                                              8),
                                        )
                                      ],
                                    ),
                                    child: Column(children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Testers ordered this month:',
                                            style: tMenu.copyWith(color: black),
                                          ),
                                          Text(
                                            '$testersNo/5',
                                            style: tMenu.copyWith(color: red5),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            product,
                                            height: 20,
                                          ),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          Text(
                                            'Shampoo',
                                            style: tParagraph.copyWith(
                                                color: black),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            product,
                                            height: 20,
                                          ),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          Text(
                                            'Hair Mousse',
                                            style: tParagraph.copyWith(
                                                color: black),
                                          )
                                        ],
                                      ),
                                    ])),
                                const SizedBox(height: 20),
                                Container(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: blue7, width: 2))),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Order history',
                                          style:
                                              tButton.copyWith(color: blue7)),
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              expanded = !expanded;
                                            });
                                          },
                                          icon: Icon(
                                              expanded
                                                  ? CupertinoIcons.chevron_up
                                                  : CupertinoIcons.chevron_down,
                                              color: blue7,
                                              size: 24))
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                expanded
                                    ? OrderBox(
                                        orderNo: '0652493',
                                        status: 'Shipped',
                                        orderDate: 'April 17th  2024',
                                        arivalDate: '-',
                                        products: _products)
                                    : const SizedBox(
                                        height: 20,
                                      ),
                              ],
                            ))
                      ],
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 32,
                        ),
                        Text(
                            'To access this feature, you need to have an account. Having an account enables you to receive personalized product recommendations.',
                            style: tParagraph.copyWith(color: grey8)),
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
                                  offset: Offset(0, 8),
                                )
                              ],
                            ),
                            child: ButtonTypeIcon(
                              text: 'Login',
                              icon: CupertinoIcons.square_arrow_right,
                              color: blue7,
                              type: 'primary',
                              onPressed: () => Get.to(() => const LoginScreen()),
                            )),
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
                                  offset: Offset(0, 8),
                                )
                              ],
                            ),
                            child: ButtonTypeIcon(
                              text: 'Sign up',
                              icon: CupertinoIcons.person_badge_plus,
                              color: red5,
                              type: 'primary',
                              onPressed: () => Get.to(() => const SignupScreen()),
                            )),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class OrderBox extends StatelessWidget {
  OrderBox({
    super.key,
    required this.orderNo,
    required this.status,
    required this.orderDate,
    required this.arivalDate,
    required this.products,
  });

  final String orderNo;
  final String status;
  final String orderDate;
  final String arivalDate;
  final List<Map<String, dynamic>> products;

  double points = 0;
  double price = 0;

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    for (var _product in products) {
      points += _product['price'];
      price += _product['promotion'] == 0
          ? (_product['price'])
          : (_product['promotion'] < 0
              ? (_product['price'] + _product['promotion'])
              : (_product['price'] * (100 - _product['promotion']) / 100));
    }

    return Container(
      width: context.width,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
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
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Order $orderNo',
          style: tParagraph.copyWith(color: black),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            SizedBox(
                width: 78,
                child:
                    Text('Status:', style: tParagraph.copyWith(color: black))),
            Text(status, style: tParagraph.copyWith(color: grey8))
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            SizedBox(
                width: 78,
                child:
                    Text('Total:', style: tParagraph.copyWith(color: black))),
            Text('$price RON', style: tParagraph.copyWith(color: grey8))
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            SizedBox(
                width: 78,
                child:
                    Text('Points:', style: tParagraph.copyWith(color: black))),
            Text('$points', style: tParagraph.copyWith(color: grey8))
          ],
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: blue7, width: 1))),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            SizedBox(
                width: 78,
                child:
                    Text('Ordered:', style: tParagraph.copyWith(color: black))),
            Text(orderDate, style: tParagraph.copyWith(color: grey8))
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            SizedBox(
                width: 78,
                child:
                    Text('Arrived:', style: tParagraph.copyWith(color: black))),
            Text(arivalDate, style: tParagraph.copyWith(color: grey8))
          ],
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: blue7, width: 1))),
        ),
        const SizedBox(height: 12),
        Column(children: <Widget>[
          // ignore: no_leading_underscores_for_local_identifiers
          for (var _product in products)
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          product,
                          height: 20,
                        ),
                        const SizedBox(width: 12),
                        Text(
                            _product['quantity'] > 1
                                ? '${_product['quantity']} x ${_product['name']}'
                                : '${_product['name']}',
                            style: tParagraph.copyWith(color: black))
                      ],
                    ),
                    Text(
                        _product['quantity'] > 1
                            ? '${_product['quantity'] * _product['price']} RON'
                            : '${_product['price']} RON',
                        style: tParagraph.copyWith(color: grey8)),
                  ],
                ),
                const SizedBox(height: 12),
              ],
            ),
        ]),
        ButtonType(
          text: 'Order again',
          color: blue7,
          type: 'secondary',
          onPressed: () {},
        )
      ]),
    );
  }
}
