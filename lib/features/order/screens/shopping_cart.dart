import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/features/order/screens/checkout.dart';
import 'package:flutter_application/utils/constants/asset_strings.dart';
import 'package:flutter_application/utils/constants/text_styles.dart';
import 'package:flutter_application/utils/constants/colors.dart';
import 'package:flutter_application/common/widgets/buttons.dart';
import 'package:flutter_application/common/widgets/inputs.dart';
import 'package:flutter_application/common/widgets/navbar.dart';
import 'package:get/get.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  final List<Map<String, dynamic>> _products = [
    {
      'isTester': true,
      'quantity': 1,
      'category': 'hair',
      'sex': 'f',
      'age': 'all',
      'conditions': ['thin hair', 'dandruff'],
      'hypoallergenic': true,
      'name': 'Hair Mousse',
      'price': 120.0,
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
      'isTester': false,
      'quantity': 1,
      'category': 'hair',
      'sex': 'f',
      'age': 'all',
      'conditions': ['thin hair', 'dandruff'],
      'hypoallergenic': true,
      'name': 'Shampoo',
      'price': 95.0,
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
      'isTester': false,
      'quantity': 2,
      'category': 'hair',
      'sex': 'f',
      'age': 'all',
      'conditions': ['thin hair', 'dandruff'],
      'hypoallergenic': true,
      'name': 'Conditioner',
      'price': 70.0,
      'reviewsNo': 6,
      'rating': 5.0,
      'favorite': false,
      'outOfStock': false,
      'noOfOrders': 2,
      'promotion': 0,
      'description':
          'This is a very long message meant for completing the text area input in order to make it look better. This is a very long message meant for completing the text area input in order to make it look better.',
      'ingredients': ['Water', 'Jojoba oil', 'Glycerin', 'Rose extract']
    },
  ];

  final List<Map<String, dynamic>> promoCodes = [
    {'code': 'XHDG-156-D', 'promotion': 10, 'difference': 0},
    {'code': 'Carmen20', 'promotion': 20, 'difference': 0},
    {'code': 'Extra30', 'promotion': -30, 'difference': 0},
    {'code': 'Extra15', 'promotion': -15, 'difference': 0},
  ];

  final List<Map<String, dynamic>> promoCodesAdded = [
    {'code': 'Carmen20', 'promotion': 20, 'difference': 0},
    {'code': 'Extra15', 'promotion': -15, 'difference': 0},
  ];

  final TextEditingController promoCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;
    for (var product in _products) {
      totalPrice += product['isTester']
          ? 0
          : product['promotion'] == 0
              ? (product['price'] * product['quantity'])
              : (product['promotion'] < 0
                  ? ((product['price'] + product['promotion']) *
                      product['quantity'])
                  : ((product['price'] * (100 - product['promotion']) / 100) *
                      product['quantity']));
    }

    // if (widget.isLogged){
    //   bool ok;
    //   if (points >= 3000) {
    //     ok = true;
    //     for(var product in promoCodesAdded) {
    //       if (product['code'] == 'Gold member') ok = false;
    //     }
    //     if (ok) promoCodesAdded.add({'code': 'Gold member', 'promotion': 20, 'difference': 0});
    //   } else if (points >= 2000) {
    //     ok = true;
    //     for(var product in promoCodesAdded) {
    //       if (product['code'] == 'Silver member') ok = false;
    //     }
    //     promoCodesAdded.add({'code': 'Silver member', 'promotion': 10, 'difference': 0});
    //   } else if (points >= 1000) {
    //     ok = true;
    //     for(var product in promoCodesAdded) {
    //       if (product['code'] == 'Bronze member') ok = false;
    //     }
    //     promoCodesAdded.add({'code': 'Bronze member', 'promotion': 5, 'difference': 0});
    //   }
    // }

    double reducedPrice = totalPrice;
    for (var promotion in promoCodesAdded) {
      promotion['difference'] = reducedPrice;
      reducedPrice += promotion['promotion'] < 0
          ? promotion['promotion']
          : -(reducedPrice * promotion['promotion'] / 100);
      promotion['difference'] -= reducedPrice;
    }

    return Scaffold(
      bottomNavigationBar: const BottomNavBar(selectedOption: 'cart',),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bkg1),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: context.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(bkg1),
                  fit: BoxFit.cover,
                ),
                border: Border(
                    bottom: BorderSide(color: Color(0xFFB23A48), width: 3)),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Shopping cart',
                    style: h4.copyWith(color: red5),
                  ),
                  const SizedBox(
                    height: 12,
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  _products.isEmpty
                      ? Container(
                          padding: const EdgeInsets.all(20),
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
                          child: Text('No items in the shopping cart',
                              textAlign: TextAlign.center,
                              style: tButton.copyWith(color: black)))
                      : Column(
                          children: [
                            for (var product in _products)
                              OrderProductBox(
                                name: product['name'],
                                isTester: product['isTester'],
                                quantity: product['quantity'],
                                price: product['price'],
                                promotion: product['promotion'],
                                onPressedChange: () {
                                  setState(() {
                                    product['isTester'] = false;
                                  });
                                },
                                onPressedMinus: () {
                                  setState(() {
                                    product['quantity']--;
                                    if (product['quantity'] == 0) {
                                      _products.remove(product);
                                    }
                                  });
                                },
                                onPressedPlus: () {
                                  setState(() {
                                    product['quantity']++;
                                  });
                                },
                                onPressedX: () {
                                  setState(() {
                                    _products.remove(product);
                                  });
                                },
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
                                  children: [
                                    InputType(
                                        type: 'one-line',
                                        inputType: TextInputType.text,
                                        placeholder: 'Promo code',
                                        mustBeFilled: true,
                                        ),
                                    if (promoCodesAdded.isNotEmpty)
                                      for (var code in promoCodesAdded)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 12),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('${code['code']}',
                                                  style: tParagraph.copyWith(
                                                      color: blue7)),
                                              Text(
                                                  code['promotion'] < 0
                                                      ? '${code['promotion']} RON'
                                                      : '-${code['promotion']}%',
                                                  style: tMenu.copyWith(
                                                      color: red5))
                                            ],
                                          ),
                                        )
                                  ],
                                )),
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
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Total:',
                                            style:
                                                tMenu.copyWith(color: black)),
                                        Text(
                                            '${totalPrice.toStringAsFixed(1)} RON',
                                            style:
                                                tButton.copyWith(color: blue7))
                                      ],
                                    ),
                                    if (promoCodesAdded.isNotEmpty)
                                      for (var promotion in promoCodesAdded)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 12),
                                          child: Text(
                                              '-${promotion['difference'].toStringAsFixed(1)} RON',
                                              style: tButton.copyWith(
                                                  color: red5)),
                                        ),
                                    const SizedBox(height: 12),
                                    Container(
                                      alignment: Alignment.topRight,
                                      decoration: BoxDecoration(
                                          border: Border(
                                              top: BorderSide(
                                                  color: black, width: 1))),
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 12),
                                        child: Text(
                                            '${reducedPrice.toStringAsFixed(1)} RON',
                                            style:
                                                tMenu.copyWith(color: blue7)),
                                      ),
                                    )
                                  ],
                                )),
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
                                      offset: Offset(0, 8),
                                    )
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Loyalty points:',
                                        style: tMenu.copyWith(color: black)),
                                    Text(totalPrice.toStringAsFixed(1),
                                        style: tMenu.copyWith(color: blue7))
                                  ],
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            ButtonTypeIcon(
                              text: 'Go to checkout',
                              icon: CupertinoIcons.cart,
                              color: red5,
                              type: 'primary',
                              onPressed: () => Get.to(() => const CheckoutScreen()),
                            ),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OrderProductBox extends StatelessWidget {
  const OrderProductBox(
      {super.key,
      required this.name,
      required this.isTester,
      required this.quantity,
      required this.price,
      required this.promotion,
      required this.onPressedChange,
      required this.onPressedMinus,
      required this.onPressedPlus,
      required this.onPressedX});

  final String name;
  final bool isTester;
  final int quantity;
  final double price;
  final int promotion;
  final VoidCallback onPressedChange;
  final VoidCallback onPressedMinus;
  final VoidCallback onPressedPlus;
  final VoidCallback onPressedX;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(name, style: tMenu.copyWith(color: black)),
                IconButton(
                    onPressed: onPressedX,
                    icon: Icon(CupertinoIcons.xmark, color: red5, size: 24))
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(product, height: 48),
                isTester
                    ? SizedBox(
                        width: 180,
                        child: ButtonType(
                            text: 'Change to full',
                            color: red5,
                            type: 'primary',
                            onPressed: onPressedChange))
                    : Row(
                        children: [
                          SizedBox(
                              width: 48,
                              child: ButtonTypeIcon(
                                text: '',
                                icon: CupertinoIcons.minus,
                                color: blue7,
                                type: 'primary',
                                onPressed: onPressedMinus,
                              )),
                          const SizedBox(
                            width: 8,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: blue4ltrans,
                            ),
                            child: Text(
                              '$quantity',
                              style: tMenu.copyWith(color: black),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          SizedBox(
                              width: 48,
                              child: ButtonTypeIcon(
                                text: '',
                                icon: CupertinoIcons.add,
                                color: blue7,
                                type: 'primary',
                                onPressed: onPressedPlus,
                              )),
                        ],
                      ),
                isTester
                    ? Text('Tester', style: tMenu.copyWith(color: blue7))
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('$quantity x $price RON',
                              style: tParagraph.copyWith(color: black)),
                          const SizedBox(height: 4),
                          Text('${quantity * price} RON',
                              style: tFilter.copyWith(
                                  color: blue7, fontWeight: FontWeight.w800))
                        ],
                      ),
              ],
            )
          ],
        ));
  }
}
