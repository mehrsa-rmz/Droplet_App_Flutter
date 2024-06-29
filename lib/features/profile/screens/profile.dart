import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/data/repositories/appointments_repository.dart';
import 'package:flutter_application/data/repositories/order_repository.dart';
import 'package:flutter_application/features/authentication/screens/login/login.dart';
import 'package:flutter_application/features/authentication/screens/signup/signup.dart';
import 'package:flutter_application/features/order/controllers/product_order_controller.dart';
import 'package:flutter_application/features/order/models/order_model.dart';
import 'package:flutter_application/features/order/models/product_order_model.dart';
import 'package:flutter_application/features/products/controllers/conditions_controller.dart';
import 'package:flutter_application/features/products/controllers/ingredinets_controller.dart';
import 'package:flutter_application/features/products/controllers/product_controller.dart';
import 'package:flutter_application/features/products/controllers/product_review_controller.dart';
import 'package:flutter_application/features/products/models/condition_model.dart';
import 'package:flutter_application/features/products/models/ingredient_model.dart';
import 'package:flutter_application/features/products/models/product_model.dart';
import 'package:flutter_application/features/profile/controllers/user_allergies_controller.dart';
import 'package:flutter_application/features/profile/controllers/user_conditions_controller.dart';
import 'package:flutter_application/features/profile/controllers/user_controller.dart';
import 'package:flutter_application/features/profile/models/user_allergy_model.dart';
import 'package:flutter_application/features/profile/models/user_condition_model.dart';
import 'package:flutter_application/features/profile/models/user_model.dart';
import 'package:flutter_application/features/profile/screens/edit_profile.dart';
import 'package:flutter_application/features/profile/screens/loyalty_program.dart';
import 'package:flutter_application/utils/constants/asset_strings.dart';
import 'package:flutter_application/utils/constants/text_styles.dart';
import 'package:flutter_application/utils/constants/colors.dart';
import 'package:flutter_application/common/widgets/buttons.dart';
import 'package:flutter_application/common/widgets/navbar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:math';

// ignore: must_be_immutable
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool expanded = false;

  User? user = FirebaseAuth.instance.currentUser;
  final controller = UserController.instance; // for logout
  UserModel? userModel;
  Map<String, dynamic> userDetails = {
    'id': '-',
    'firstName': '-',
    'lastName': '-',
    'phone': '-',
    'email': '-',
    'address': '-',
    'birthday': '-',
    'gender': '-'
  };
  List<String> skinCond = [];
  List<String> bodyCond = [];
  List<String> hairCond = [];
  List<String> prefCond = [];
  List<String> allergies = [];
  int points = 100;
  bool leftProductReview = false;
  bool wentToAppointment = false;

  int testersNo = 0;
  List<String> testersOrder = [];
  List<Map<String, dynamic>> userOrders = [];

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  bool isSameMonth(String dateTimeString) {
    // Parse the input string to a DateTime object
    DateTime inputDate = DateFormat('yyyy-MM-dd-HH:mm:ss').parse(dateTimeString);
    
    // Get the current date
    DateTime currentDate = DateTime.now();
    
    // Compare the month and year
    return inputDate.year == currentDate.year && inputDate.month == currentDate.month;
  }

  Future<void> fetchUserData() async {
    if (user != null) {
      String userId = user!.uid;
      userModel = await UserController.fetchUserById(userId);

      if (userModel != null) {
        print('User fetched successfully: ${userModel!.fullName}');
      } else {
        print('User not found.');
      }

      leftProductReview = await ProductReviewController.instance.hasUserLeftReview(userId);
      if(leftProductReview) points += 50;
      wentToAppointment = await AppointmentRepository.instance.hasUserBeenToAppointment(userId);
      if(wentToAppointment) points += 50;

      List<UserConditionModel> currentUserConditions = await UserConditionController.instance.fetchUserConditionForUserId(userId);
      List<UserAllergyModel> currentUserAllergies = await UserAllergyController.instance.fetchUserAllergiesForUserId(userId);
      List<OrderModel> currentUserOrders = await OrderRepository.instance.fetchCurrentUserOrders();

      userDetails = {
        'id': userId,
        'firstName': userModel?.firstName ?? '-',
        'lastName': userModel?.lastName ?? '-',
        'phone': userModel?.phoneNo ?? '-',
        'email': userModel?.email ?? '-',
        'address': userModel?.address ?? '-',
        'birthday': userModel?.birthday ?? '-',
        'gender': (userModel?.gender != 'all') ? (userModel?.gender ?? '-') : '-',
      };

      for(var uc in currentUserConditions){
        ConditionModel? conditionToAdd = await ConditionController.instance.getConditionById(uc.conditionId);
        var condType = conditionToAdd?.type ?? '';
        var condName = conditionToAdd?.name ?? '';
        if (condType == 'Body'){
          bodyCond.add(condName);
        }
        if (condType == 'Hair'){
          hairCond.add(condName);
        }
        if (condType == 'Perfume'){
          prefCond.add(condName);
        }
        if (condType == 'Skin'){
          skinCond.add(condName);
        }
      }

      for(var ua in currentUserAllergies){
        IngredientModel? allergyToAdd = await IngredientController.instance.getIngredientById(ua.ingredientId);
        var algName = allergyToAdd?.name ?? '';
        allergies.add(algName);
      }

      for(var o in currentUserOrders){
        points += o.points;
        List<Map<String, dynamic>> prodList = [];
        List<ProductOrderModel> thisOrderProducts = await ProductOrderController.instance.fetchOrderProductsForOrderId(o.id);
        for(var po in thisOrderProducts){
          ProductModel? thisProduct = await ProductController.instance.getProductById(po.productId);
          Map<String, dynamic> prod = {'name': thisProduct?.name ?? '', 'quantity': po.quantity, 'price': po.finalPrice, 'isTester': po.isTester};
          prodList.add(prod);
          if(po.isTester && isSameMonth(o.orderDate)){
            testersOrder.add(thisProduct?.name ?? '');
            testersNo = testersOrder.length;
          }
        }
        
        userOrders.add({
          'id': o.id,
          'status': o.shipmentStatus,
          'price': o.finalPrice,
          'points': o.points,
          'orderDate': o.orderDate,
          'deliveryDate': o.deliveryDate,
          'products': prodList
        });

        // Sorting by descending orderDate
        userOrders.sort((a, b) => b['orderDate'].compareTo(a['orderDate']));
      }

      print(userOrders);

      setState(() {});

    } else {
      print('No user is currently signed in.');
    }
  }

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
                                  onPressed: () => Get.to(() => LoyaltyProgramScreen(points: points, leftReview: leftProductReview, hadAppointment: wentToAppointment)),
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
                                              8), 
                                        )
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text('${userDetails['firstName']} ${userDetails['lastName']}',
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
                                                    userDetails['id'],
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
                                                    points.toString(),
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
                                              width: context.width / 2 - 6 - 20 - 16,
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
                                                    userDetails['phone'] == '' ? '-' : userDetails['phone'],
                                                    style: tParagraphMed
                                                        .copyWith(color: grey8),
                                                  )
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            SizedBox(
                                              width: context.width / 2 - 6 - 20 - 16,
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
                                                    userDetails['email'],
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
                                              userDetails['address'] == '' ? '-' : userDetails['address'],
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
                                              width: context.width / 2 - 6 - 20 - 16,
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
                                                    userDetails['birthday'] == '' ? '-' : userDetails['birthday'],
                                                    style: tParagraphMed
                                                        .copyWith(color: grey8),
                                                  )
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            SizedBox(
                                              width: context.width / 2 - 6 - 20 - 16,
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
                                                    userDetails['gender'],
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
                                              width: context.width / 2 - 6 - 20 - 16,
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
                                                    skinCond.isEmpty? '-' : skinCond.join(', '),
                                                    style: tParagraphMed
                                                        .copyWith(color: grey8),
                                                  )
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            SizedBox(
                                              width: context.width / 2 - 6 - 20 - 16,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Body skin type',
                                                    style: tParagraph.copyWith(
                                                        color: black),
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(
                                                    bodyCond.isEmpty? '-' : bodyCond.join(', '),
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
                                              width: context.width / 2 - 6 - 20 - 16,
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
                                                    hairCond.isEmpty? '-' : hairCond.join(', '),
                                                    style: tParagraphMed
                                                        .copyWith(color: grey8),
                                                  )
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            SizedBox(
                                              width: context.width / 2 - 6 - 20 - 16,
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
                                                    prefCond.isEmpty? '-' : prefCond.join(', '),
                                                    style: tParagraphMed
                                                        .copyWith(color: grey8),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 20,),
                                        Column(
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
                                              allergies.isEmpty ? '-' : allergies.join(', '),
                                              style: tParagraphMed.copyWith(
                                                  color: grey8),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 20,),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                                width: context.width / 2 - 6 - 20 - 16,
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
                                                width: context.width / 2 - 6 - 20 - 16,
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
                                    padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
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
                                      const SizedBox(height: 20),
                                      Column(children: <Widget>[
                                        for (var tester in testersOrder)
                                          Column(
                                            children: [
                                              Row(
                                                children:[
                                                  Image.asset(product, height: 20),
                                                  const SizedBox(width: 12,),
                                                  Text(tester, style: tParagraph.copyWith(color: black))
                                                ]
                                              ),
                                              const SizedBox(height: 20),
                                            ],
                                          ),
                                        ]
                                      ),
                                    ]
                                  )
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: blue7, width: 2))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [Text('Order history', style: tButton.copyWith(color: blue7)),
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
                                          size: 24
                                        )
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                expanded
                                    ? Column(
                                      children: <Widget>[
                                        for (var uo in userOrders)
                                          Column(
                                            children: [
                                              OrderBox(
                                                status: uo['status'],
                                                totalPrice: uo['price'],
                                                points: uo['points'],
                                                orderDate: uo['orderDate'],
                                                arivalDate: uo['deliveryDate'],
                                                products: uo['products']
                                              ),
                                              const SizedBox(height: 20),
                                            ],
                                          ),
                                      ],
                                    )
                                    : const SizedBox(height: 20),
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

class OrderBox extends StatelessWidget {
  const OrderBox({
    super.key,
    required this.status,
    required this.totalPrice,
    required this.points,
    required this.orderDate,
    required this.arivalDate,
    required this.products,
  });

  final String status;
  final String orderDate;
  final String arivalDate;
  final List<Map<String, dynamic>> products;
  final int totalPrice;
  final int points;

  @override
  Widget build(BuildContext context) {
    final Random random = Random();
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
            offset: Offset(0, 8), 
          )
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Order ${String.fromCharCodes(Iterable.generate(10, (_) => '0123456789'.codeUnitAt(random.nextInt(10))))}',
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
            Text('$totalPrice RON', style: tParagraph.copyWith(color: grey8))
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
            Text(orderDate.substring(0, 10), style: tParagraph.copyWith(color: grey8))
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            SizedBox(
                width: 78,
                child:
                    Text('Arrived:', style: tParagraph.copyWith(color: black))),
            Text(arivalDate == '' ? '-' : arivalDate.substring(0, 10), style: tParagraph.copyWith(color: grey8))
          ],
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: blue7, width: 1))),
        ),
        const SizedBox(height: 12),
        Column(children: <Widget>[
          for (var prod in products)
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
                            prod['quantity'] > 1
                                ? '${prod['quantity']} x ${prod['name']}'
                                : '${prod['name']}',
                            style: tParagraph.copyWith(color: black))
                      ],
                    ),
                    Text(
                      prod['isTester'] ? 'Tester'
                      : prod['quantity'] > 1
                          ? '${prod['quantity'] * prod['price']} RON'
                          : '${prod['price']} RON',
                      style: tParagraph.copyWith(color: grey8)),
                  ],
                ),
                const SizedBox(height: 12),
              ],
            ),
        ]),
      ]),
    );
  }
}
