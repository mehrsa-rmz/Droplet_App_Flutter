import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/features/order/screens/order_success.dart';
import 'package:flutter_application/utils/constants/asset_strings.dart';
import 'package:flutter_application/utils/constants/text_styles.dart';
import 'package:flutter_application/utils/constants/colors.dart';
import 'package:flutter_application/common/widgets/buttons.dart';
import 'package:flutter_application/common/widgets/inputs.dart';
import 'package:flutter_application/common/widgets/navbar.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
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

  final List<Map<String, dynamic>> promoCodesAdded = [
    {'code': 'Carmen20', 'promotion': 20, 'difference': 0},
    {'code': 'Extra15', 'promotion': -15, 'difference': 0},
    {'code': 'Silver member', 'promotion': 10, 'difference': 0}
  ];

  String selectedDelivery = 'standard';
  String selectedPayment = 'cash on arrival';

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
            child: SafeArea(
                child: Column(children: [
              Container(
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage(bkg1),
                    fit: BoxFit.cover,
                  ),
                  border: Border(
                    bottom: BorderSide(color: red5, width: 3),
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
                              color: red5, size: 32),
                          onPressed: () => Get.back(),
                        ),
                        Text('Checkout', style: h4.copyWith(color: red5)),
                        const SizedBox(width: 32)
                      ],
                    ),
                    const SizedBox(height: 12),
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
                              offset: Offset(
                                  0, 8), // (0, -8) for BottomBarNavigation
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('All fields are mandatory!',
                                style: tParagraph.copyWith(color: red5)),
                            const SizedBox(
                              height: 20,
                            ),
                            Form(
                                child: Column(children: [
                              InputType(
                                type: 'one-line',
                                inputType: TextInputType.name,
                                placeholder: 'First name',
                                mustBeFilled: true,
                              ),
                              const SizedBox(height: 20),
                              InputType(
                                type: 'one-line',
                                inputType: TextInputType.name,
                                placeholder: 'Last name',
                                mustBeFilled: true,
                              ),
                              const SizedBox(height: 20),
                              InputType(
                                type: 'one-line',
                                inputType: TextInputType.phone,
                                placeholder: 'Phone',
                                mustBeFilled: true,
                              ),
                              const SizedBox(height: 20),
                              InputType(
                                type: 'one-line',
                                inputType: TextInputType.emailAddress,
                                placeholder: 'Email',
                                mustBeFilled: true,
                              ),
                              const SizedBox(height: 20),
                              InputType(
                                type: 'text-area',
                                inputType: TextInputType.multiline,
                                placeholder: 'Address',
                                mustBeFilled: true,
                              ),
                            ]))
                          ],
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 20, right: 20),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const SizedBox(width: 20),
                                Text('Delivery method',
                                    style: tMenu.copyWith(color: blue7)),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: RadioListTile(
                                        activeColor: red5,
                                        title: Text('Pick-up in store',
                                            style: tParagraph.copyWith(
                                                color: grey8)),
                                        value: 'pick-up in store',
                                        groupValue: selectedDelivery,
                                        onChanged: (String? value) {
                                          setState(() {
                                            selectedDelivery = value!;
                                          });
                                        })),
                                Text(
                                  'FREE',
                                  style: tButton.copyWith(color: blue7),
                                )
                              ],
                            ),
                            if (selectedDelivery == 'pick-up in store')
                              Row(
                                children: [
                                  const SizedBox(width: 20),
                                  InputType(
                                    type: 'dropdown',
                                    inputType: TextInputType.text,
                                    placeholder: 'Location',
                                    mustBeFilled: true,
                                    dropdownList: const [
                                      DropdownMenuEntry(
                                          value: 1,
                                          label: 'Droplet - Mega Mall'),
                                      DropdownMenuEntry(
                                          value: 2,
                                          label: 'Droplet - Baneasa Mall'),
                                      DropdownMenuEntry(
                                          value: 3,
                                          label: 'Droplet - AFI Palace Mall'),
                                      DropdownMenuEntry(
                                          value: 4,
                                          label: 'Droplet - Plaza Romania Mall'),
                                      DropdownMenuEntry(
                                          value: 5,
                                          label: 'Droplet - Unirii Shopping Center'),
                                      DropdownMenuEntry(
                                          value: 6,
                                          label: 'Droplet - ParkLake Mall'),
                                      DropdownMenuEntry(
                                          value: 7,
                                          label: 'Droplet - Sun Plaza Mall'),
                                      DropdownMenuEntry(
                                          value: 8,
                                          label: 'Droplet - Promenada Mall'),
                                    ],
                                    dropdownWidth: context.width - 32 - 40,
                                  ),
                                ],
                              ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: RadioListTile(
                                        activeColor: red5,
                                        title: Text(
                                            'Standard delivery (3-5 days)',
                                            style: tParagraph.copyWith(
                                                color: grey8)),
                                        value: 'standard',
                                        groupValue: selectedDelivery,
                                        onChanged: (String? value) {
                                          setState(() {
                                            selectedDelivery = value!;
                                          });
                                        })),
                                Text(
                                  'FREE',
                                  style: tButton.copyWith(color: blue7),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: RadioListTile(
                                        activeColor: red5,
                                        title: Text('Fast delivery (under 24h)',
                                            style: tParagraph.copyWith(
                                                color: grey8)),
                                        value: 'fast',
                                        groupValue: selectedDelivery,
                                        onChanged: (String? value) {
                                          setState(() {
                                            selectedDelivery = value!;
                                          });
                                        })),
                                Text(
                                  '+15 RON',
                                  style: tButton.copyWith(color: blue7),
                                )
                              ],
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 20, right: 20),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const SizedBox(width: 20),
                                Text('Payment method',
                                    style: tMenu.copyWith(color: blue7)),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            RadioListTile(
                                activeColor: red5,
                                title: Text('Cash on arrival',
                                    style: tParagraph.copyWith(color: grey8)),
                                value: 'cash on arrival',
                                groupValue: selectedPayment,
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedPayment = value!;
                                  });
                                }),
                            RadioListTile(
                                activeColor: red5,
                                title: Text('Card on arrival',
                                    style: tParagraph.copyWith(color: grey8)),
                                value: 'card on arrival',
                                groupValue: selectedPayment,
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedPayment = value!;
                                  });
                                }),
                            RadioListTile(
                                activeColor: red5,
                                title: Text('Card online',
                                    style: tParagraph.copyWith(color: grey8)),
                                value: 'card online',
                                groupValue: selectedPayment,
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedPayment = value!;
                                  });
                                }),
                            RadioListTile(
                                activeColor: red5,
                                title: Image.asset(eWallet,
                                    height: 36,
                                    alignment: Alignment.centerLeft),
                                value: 'e-wallet',
                                groupValue: selectedPayment,
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedPayment = value!;
                                  });
                                }),
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
                              offset: Offset(
                                  0, 8), // (0, -8) for BottomBarNavigation
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Total:',
                                    style: tMenu.copyWith(color: black)),
                                Text('${totalPrice.toStringAsFixed(1)} RON',
                                    style: tButton.copyWith(color: blue7))
                              ],
                            ),
                            if (promoCodesAdded.isNotEmpty)
                              for (var promotion in promoCodesAdded)
                                Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Text(
                                      '-${promotion['difference'].toStringAsFixed(1)} RON',
                                      style: tButton.copyWith(color: red5)),
                                ),
                            if (selectedDelivery == 'fast')
                              Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: Text('+15 RON',
                                    style: tButton.copyWith(color: red5)),
                              ),
                            const SizedBox(height: 12),
                            Container(
                              alignment: Alignment.topRight,
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide(color: black, width: 1))),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: Text(
                                    selectedDelivery == 'fast'
                                        ? '${(reducedPrice + 15).toStringAsFixed(1)} RON'
                                        : '${reducedPrice.toStringAsFixed(1)} RON',
                                    style: tMenu.copyWith(color: blue7)),
                              ),
                            )
                          ],
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    ButtonTypeIcon(
                        text: 'Finish order',
                        icon: CupertinoIcons.bag,
                        color: red5,
                        type: 'primary',
                        onPressed: () =>
                            Get.to(() => const OrderSuccessScreen())),
                    const SizedBox(
                      height: 20,
                    ),
                  ]))
            ]))));
  }
}
