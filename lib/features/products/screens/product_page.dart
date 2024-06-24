import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/features/authentication/screens/login/login.dart';
import 'package:flutter_application/features/authentication/screens/signup/signup.dart';
import 'package:flutter_application/utils/constants/asset_strings.dart';
import 'package:flutter_application/utils/constants/text_styles.dart';
import 'package:flutter_application/utils/constants/colors.dart';
import 'package:flutter_application/common/widgets/buttons.dart';
import 'package:flutter_application/common/widgets/inputs.dart';
import 'package:flutter_application/common/widgets/navbar.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ScrollController scrollController = ScrollController();
  final Map<String, dynamic> _product = {
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
    'promotion': -10,
    'description':
        'This is a very long message meant for completing the text area input in order to make it look better. This is a very long message meant for completing the text area input in order to make it look better.',
    'ingredients': ['Water', 'Jojoba oil', 'Glycerin', 'Rose extract']
  };

  int inCart = 0;
  bool testerAdded = false;
  bool testerLimitReached = false;
  bool expanded1 = false;
  bool expanded2 = false;
  bool expanded3 = false;

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
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
                child: ListView(controller: scrollController, children: [
              Container(
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage(bkg2),
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
                        Text(_product['name'], style: h4.copyWith(color: red5)),
                        const SizedBox(width: 32)
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Image.asset(product, height: 248),
                    const SizedBox(height: 32),
                    _product['promotion'] == 0
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${_product['price']} RON',
                                style: h4.copyWith(color: black),
                              ),
                              IconButton(
                                  icon: Icon(
                                      _product['favorite']
                                          ? CupertinoIcons.heart_fill
                                          : CupertinoIcons.heart,
                                      color: red5,
                                      size: 40),
                                  onPressed: () => setState(() {
                                        _product['favorite'] =
                                            !_product['favorite'];
                                      }))
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${_product['price']} RON',
                                style: h5Crossed.copyWith(color: black),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _product['promotion'] < 0
                                        ? '${_product['price'] + _product['promotion']} RON'
                                        : '${_product['price'] * (100 - _product['promotion']) / 100} RON',
                                    style: h4.copyWith(color: red5),
                                  ),
                                  IconButton(
                                      icon: Icon(
                                          _product['favorite']
                                              ? CupertinoIcons.heart_fill
                                              : CupertinoIcons.heart,
                                          color: red5,
                                          size: 40),
                                      onPressed: () => setState(() {
                                            _product['favorite'] =
                                                !_product['favorite'];
                                          }))
                                ],
                              ),
                            ],
                          ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Text('${_product['rating']}',
                            style: h5.copyWith(color: grey8)),
                        const SizedBox(
                          width: 4,
                        ),
                        Icon(CupertinoIcons.star_fill, color: grey8, size: 24),
                        const SizedBox(width: 24),
                        ButtonType(
                          text: 'See ${_product['reviewsNo']} reviews',
                          color: red5,
                          type: 'tertiary',
                          onPressed: () {
                            setState(() {
                              expanded3 = true;
                              scrollController.animateTo(
                                1100,
                                duration: const Duration(milliseconds: 100),
                                curve: Curves.easeInOut,
                              );
                            });
                          },
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    inCart == 0
                        ? (_product['outOfStock']
                            ? ButtonType(
                                text: 'Out of stock',
                                color: red5,
                                type: 'primary')
                            : ButtonType(
                                text: 'Add to shopping cart',
                                color: red5,
                                type: 'primary',
                                onPressed: () {
                                  setState(() {
                                    inCart = 1;
                                  });
                                },
                              ))
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  width: 48,
                                  child: ButtonTypeIcon(
                                    text: '',
                                    icon: CupertinoIcons.minus,
                                    color: red5,
                                    type: 'primary',
                                    onPressed: () {
                                      setState(() {
                                        inCart--;
                                      });
                                    },
                                  )),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: blue4ltrans,
                                ),
                                child: Text(
                                  '$inCart in shopping cart',
                                  style: tMenu.copyWith(color: black),
                                ),
                              ),
                              SizedBox(
                                  width: 48,
                                  child: ButtonTypeIcon(
                                    text: '',
                                    icon: CupertinoIcons.add,
                                    color: red5,
                                    type: 'primary',
                                    onPressed: () {
                                      setState(() {
                                        inCart++;
                                      });
                                    },
                                  )),
                            ],
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    user != null
                        ? Column(
                            children: [
                              testerLimitReached
                                  ? ButtonType(
                                      text: 'Tester limit reached',
                                      color: red5,
                                      type: 'primary')
                                  : testerAdded
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const SizedBox(width: 48),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 24,
                                                      vertical: 8),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: blue4ltrans,
                                              ),
                                              child: Text(
                                                'Tester added',
                                                style: tMenu.copyWith(
                                                    color: black),
                                              ),
                                            ),
                                            SizedBox(
                                                width: 48,
                                                child: ButtonTypeIcon(
                                                  text: '',
                                                  icon: CupertinoIcons.xmark,
                                                  color: pink5,
                                                  type: 'primary',
                                                  onPressed: () {
                                                    setState(() {
                                                      testerAdded = false;
                                                    });
                                                  },
                                                )),
                                          ],
                                        )
                                      : ButtonType(
                                          text: 'Not sure yet? Try a tester',
                                          color: pink5,
                                          type: 'primary',
                                          onPressed: () {
                                            setState(() {
                                              testerAdded = true;
                                            });
                                          },
                                        ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Every month you can try up to 5 distinct testers for free (in the same order or different ones).',
                                style: tParagraph.copyWith(color: grey8),
                              )
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Wanna try a tester first?',
                                  style: tMenu.copyWith(color: black)),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                  'Every month you can try up to 5 distinct testers for free (in the same order or different ones).',
                                  style: tParagraph.copyWith(color: grey8)),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                      width: context.width / 2 - 16 - 6,
                                      child: ButtonTypeIcon(
                                        text: 'Login',
                                        icon: CupertinoIcons.square_arrow_right,
                                        color: blue7,
                                        type: 'primary',
                                        onPressed: () => Get.to(() => const LoginScreen()),
                                      )),
                                  const SizedBox(width: 12),
                                  SizedBox(
                                      width: context.width / 2 - 16 - 6,
                                      child: ButtonTypeIcon(
                                        text: 'Sign up',
                                        icon: CupertinoIcons.person_badge_plus,
                                        color: pink5,
                                        type: 'primary',
                                        onPressed: () => Get.to(() => const SignupScreen()),
                                      )),
                                ],
                              )
                            ],
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: blue7, width: 2))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Description',
                              style: tButton.copyWith(color: blue7)),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  expanded1 = !expanded1;
                                });
                              },
                              icon: Icon(
                                  expanded1
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
                    expanded1
                        ? Container(
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
                                  offset: Offset(
                                      0, 8), // (0, -8) for BottomBarNavigation
                                )
                              ],
                            ),
                            child: Text(
                              _product['description'],
                              style: tParagraph.copyWith(color: grey8),
                            ))
                        : const SizedBox(
                            height: 20,
                          ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: blue7, width: 2))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Ingredients',
                              style: tButton.copyWith(color: blue7)),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  expanded2 = !expanded2;
                                });
                              },
                              icon: Icon(
                                  expanded2
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
                    expanded2
                        ? Container(
                            width: context.width,
                            margin: const EdgeInsets.only(bottom: 20),
                            padding: const EdgeInsets.only(
                                left: 20, top: 20, right: 20, bottom: 8),
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
                              children: _product['ingredients']
                                  .expand<Widget>((ingredient) => [
                                        Text('- $ingredient',
                                            style:
                                                tButton.copyWith(color: blue4)),
                                        const SizedBox(height: 12),
                                      ])
                                  .toList(),
                            ),
                          )
                        : const SizedBox(
                            height: 20,
                          ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: blue7, width: 2))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Reviews',
                              style: tButton.copyWith(color: blue7)),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  expanded3 = !expanded3;
                                });
                              },
                              icon: Icon(
                                  expanded3
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
                    if (user == null)
                      ButtonType(
                          text: 'Login to leave review',
                          color: blue7,
                          type: 'primary'),
                    if (user != null)
                      ButtonType(
                        text: 'Leave review',
                        color: blue7,
                        type: 'primary',
                        onPressed: () => showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                insetPadding: const EdgeInsets.all(16),
                                backgroundColor: white1,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                shadowColor: blue7dtrans,
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      icon: Icon(CupertinoIcons.xmark,
                                          color: red5, size: 24),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    SizedBox(
                                        width: context.width,
                                        child: Text('Review',
                                            textAlign: TextAlign.center,
                                            style: h5.copyWith(color: black))),
                                    const SizedBox(height: 24),
                                    Text(
                                        'We hope you enjoyed your appointment! Leave a rating and a review for Pop Laura.',
                                        style:
                                            tParagraph.copyWith(color: grey8)),
                                    const SizedBox(height: 24),
                                    SizedBox(
                                      width: context.width,
                                      child: AnimatedRatingStars(
                                        initialRating: 0.0,
                                        minRating: 0.0,
                                        maxRating: 5.0,
                                        filledColor: red5,
                                        emptyColor: red5,
                                        filledIcon: CupertinoIcons.star_fill,
                                        halfFilledIcon:
                                            CupertinoIcons.star_lefthalf_fill,
                                        emptyIcon: CupertinoIcons.star,
                                        onChanged: (double rating) {
                                          // Handle the rating change here
                                        },
                                        displayRatingValue: true,
                                        interactiveTooltips: true,
                                        customFilledIcon:
                                            CupertinoIcons.star_fill,
                                        customHalfFilledIcon:
                                            CupertinoIcons.star_lefthalf_fill,
                                        customEmptyIcon: CupertinoIcons.star,
                                        starSize: 40.0,
                                        animationDuration:
                                            const Duration(milliseconds: 300),
                                        animationCurve: Curves.easeInOut,
                                        readOnly: false,
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    InputType(
                                        type: 'text-area',
                                        inputType: TextInputType.multiline,
                                        placeholder: 'Message',
                                        mustBeFilled: true,
                                        ),
                                    const SizedBox(height: 24),
                                    Row(children: [
                                      SizedBox(
                                          width: context.width / 2 - 6 - 40,
                                          child: ButtonType(
                                              text: 'Save',
                                              color: blue7,
                                              type: "primary",
                                              onPressed: () =>
                                                  Navigator.of(context).pop())),
                                      const SizedBox(width: 12),
                                      SizedBox(
                                          width: context.width / 2 - 6 - 40,
                                          child: ButtonType(
                                              text: 'Cancel',
                                              color: red5,
                                              type: "secondary",
                                              onPressed: () =>
                                                  Navigator.of(context).pop()))
                                    ]),
                                  ],
                                ),
                              );
                            }),
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    expanded3
                        ? const ReviewBox(
                            name: 'Ana G.',
                            rating: 3.5,
                            date: 'February 26th 2024',
                            review:
                                'This is a general review message to fill this space.')
                        : const SizedBox(
                            height: 20,
                          ),
                  ],
                ),
              )
            ]))));
  }
}

class ReviewBox extends StatelessWidget {
  const ReviewBox(
      {super.key,
      required this.name,
      required this.rating,
      required this.date,
      required this.review});

  final String name;
  final double rating;
  final String date;
  final String review;

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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                SizedBox(
                  width: context.width - 32 - 40 - 132,
                  child: Text(
                    name,
                    style: tMenu.copyWith(color: black),
                  ),
                ),
                rating < 1
                    ? (rating < 0.5
                        ? Icon(CupertinoIcons.star, color: red5, size: 20)
                        : Icon(CupertinoIcons.star_lefthalf_fill,
                            color: red5, size: 20))
                    : Icon(CupertinoIcons.star_fill, color: red5, size: 20),
                const SizedBox(width: 8),
                rating < 2
                    ? (rating < 1.5
                        ? Icon(CupertinoIcons.star, color: red5, size: 20)
                        : Icon(CupertinoIcons.star_lefthalf_fill,
                            color: red5, size: 20))
                    : Icon(CupertinoIcons.star_fill, color: red5, size: 20),
                const SizedBox(width: 8),
                rating < 3
                    ? (rating < 2.5
                        ? Icon(CupertinoIcons.star, color: red5, size: 20)
                        : Icon(CupertinoIcons.star_lefthalf_fill,
                            color: red5, size: 20))
                    : Icon(CupertinoIcons.star_fill, color: red5, size: 20),
                const SizedBox(width: 8),
                rating < 4
                    ? (rating < 3.5
                        ? Icon(CupertinoIcons.star, color: red5, size: 20)
                        : Icon(CupertinoIcons.star_lefthalf_fill,
                            color: red5, size: 20))
                    : Icon(CupertinoIcons.star_fill, color: red5, size: 20),
                const SizedBox(width: 8),
                rating < 5
                    ? (rating < 4.5
                        ? Icon(CupertinoIcons.star, color: red5, size: 20)
                        : Icon(CupertinoIcons.star_lefthalf_fill,
                            color: red5, size: 20))
                    : Icon(CupertinoIcons.star_fill, color: red5, size: 20),
              ],
            ),
            const SizedBox(height: 4),
            Text(date, style: tParagraph.copyWith(color: grey8)),
            const SizedBox(height: 20),
            Text(review, style: tParagraph.copyWith(color: black)),
          ],
        ));
  }
}
