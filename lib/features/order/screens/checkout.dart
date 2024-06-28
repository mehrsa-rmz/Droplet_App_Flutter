import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/data/repositories/cart_repository.dart';
import 'package:flutter_application/data/repositories/order_repository.dart';
import 'package:flutter_application/features/order/controllers/cart_item_controller.dart';
import 'package:flutter_application/features/order/controllers/order_controller.dart';
import 'package:flutter_application/features/order/controllers/product_order_controller.dart';
import 'package:flutter_application/features/order/controllers/promotion_cart_controller.dart';
import 'package:flutter_application/features/order/controllers/promotion_controller.dart';
import 'package:flutter_application/features/order/controllers/promotion_order_controller.dart';
import 'package:flutter_application/features/order/models/cart_item_model.dart';
import 'package:flutter_application/features/order/models/cart_model.dart';
import 'package:flutter_application/features/order/models/order_model.dart';
import 'package:flutter_application/features/order/models/product_order_model.dart';
import 'package:flutter_application/features/order/models/promotion_cart_model.dart';
import 'package:flutter_application/features/order/models/promotion_model.dart';
import 'package:flutter_application/features/order/models/promotion_order_model.dart';
import 'package:flutter_application/features/order/screens/order_success.dart';
import 'package:flutter_application/features/products/controllers/product_controller.dart';
import 'package:flutter_application/features/products/models/product_model.dart';
import 'package:flutter_application/features/profile/controllers/user_controller.dart';
import 'package:flutter_application/features/profile/models/user_model.dart';
import 'package:flutter_application/utils/constants/asset_strings.dart';
import 'package:flutter_application/utils/constants/text_styles.dart';
import 'package:flutter_application/utils/constants/colors.dart';
import 'package:flutter_application/common/widgets/buttons.dart';
import 'package:flutter_application/common/widgets/inputs.dart';
import 'package:flutter_application/common/widgets/navbar.dart';
import 'package:flutter_application/utils/popups/loaders.dart';
import 'package:flutter_application/utils/validators/validation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel? userModel;
  TextEditingController pickupLocationController = TextEditingController();
  final _cartItemsController = Get.put(CartItemsController());
  final _cartPromosController = Get.put(PromotionCartController());
  final _orderProductController = Get.put(ProductOrderController());
  final _orderPromosController = Get.put(PromotionOrderController());
  final _checkoutController = Get.put(OrderController());
  final _userController = Get.put(UserController());
  double totalPrice = 0;
  double reducedPrice = 0;
  late CartModel currentCart;
  late String currentCartId;
  String selectedDelivery = 'standard';
  String lastDeliveryMethodSelected = 'standard';
  String selectedPayment = 'cash on arrival';
  
  List<CartItemModel> cartItemModels = [];
  List<PromotionCartModel> cartPromoModels = [];
  List<Map<String, dynamic>> currentCartPromos = [];

  @override
  void initState() {
    super.initState();
    fetchCartData();
  }

  Future<void> fetchCartData() async {
    if (user != null) {
      String userId = user!.uid;
      userModel = await UserController.fetchUserById(userId);
      _checkoutController.firstName.text = userModel?.firstName ?? '';
      _checkoutController.lastName.text = userModel?.lastName ?? '';
      _checkoutController.email.text = userModel?.email ?? '';
      _checkoutController.phoneNo.text = userModel?.phoneNo ?? '';
      _checkoutController.address.text = userModel?.address ?? '';
      if (userModel != null) {
        print('User fetched successfully: ${userModel!.fullName}');
        currentCart = await CartRepository.instance.fetchUserCart(userId);
        currentCartId = currentCart.id;
        print('currentCartId: $currentCartId');
      } else {
        print('User not found.');
        currentCart = await CartRepository.instance.fetchUserCart('');
        currentCartId = currentCart.id;
        print('currentCartId: $currentCartId');
      }
    } else {
      print('No user is currently signed in.');
      currentCart = await CartRepository.instance.fetchUserCart('');
      currentCartId = currentCart.id;
      print('currentCartId: $currentCartId');
    }

    totalPrice = 0;
    reducedPrice = 0;

    currentCartId = _userController.currentCart.value.id;
    print('currentCartId: $currentCartId');
    cartItemModels = await _cartItemsController.fetchCartItemsForCartId(currentCartId);
    print('cartItemModels: $cartItemModels');
    cartPromoModels = await _cartPromosController.fetchCartPromotionsForCartId(currentCartId);
    print('cartPromoModels: $cartPromoModels');
    
    for(var ci in cartItemModels){
      ProductModel? productToAdd = await ProductController.instance.getProductById(ci.productId);
      if (!ci.isTester) {
        int productPrice = productToAdd?.price ?? 0;
        int promotion = productToAdd?.promotion ?? 0;

        double finalProductPrice;
        if (promotion < 0) {
          finalProductPrice = (productPrice + promotion).toDouble();
        } else if (promotion > 0) {
          finalProductPrice = productPrice * (100 - promotion) / 100;
        } else {
          finalProductPrice = productPrice.toDouble();
        }

        totalPrice += ci.quantity * finalProductPrice;
      }
    }

    reducedPrice = totalPrice;
    print('totalPrice: $totalPrice');

    currentCartPromos = [];
    for (var pc in cartPromoModels) {
      PromotionModel? promoToAdd = await PromotionController.instance.getPromotionById(pc.promotionId);
      if (promoToAdd != null) {
        int promotionAmount = promoToAdd.amount;
        double deduction;
        if (promotionAmount < 0) {
          deduction = promotionAmount.toDouble();
        } else {
          deduction = reducedPrice * promotionAmount / 100;
        }
        reducedPrice -= deduction;

        currentCartPromos.add({
          'code': promoToAdd.id,
          'promotion': promotionAmount,
          'difference': deduction,
        });
      }
    }

    print('currentCartPromos: $currentCartPromos');
    setState(() {});
  }

  Future<void> createOrder(OrderController controller) async {
    final date = DateFormat('yyyy-MM-dd-HH:mm:ss').format(DateTime.now());
    OrderModel orderModel = OrderModel(
      id: 'ORDER_${date}_${controller.email.text.trim()}', 
      userId: userModel?.id ?? '', 
      address: controller.address.text, 
      firstName: controller.firstName.text.trim(), 
      lastName: controller.lastName.text.trim(), 
      email: controller.email.text.trim(), 
      phoneNo: controller.phoneNo.text.trim(), 
      shipmentStatus: 'recieved', 
      deliveryMethod: selectedDelivery, 
      paymentMethod: selectedPayment, 
      orderDate: date, 
      deliveryDate: '', 
      pickupLocation: selectedDelivery == 'pick-up in store' ? pickupLocationController.text : '',
      finalPrice: reducedPrice.round(),
      points: totalPrice.round()
    );
    await OrderRepository.instance.addOrder(orderModel);
    for(var ci in cartItemModels){
      ProductModel? productToAdd = await ProductController.instance.getProductById(ci.productId);
      int finalProductPrice = 0;
      if (!ci.isTester) {
        int productPrice = productToAdd?.price ?? 0;
        int promotion = productToAdd?.promotion ?? 0;

        if (promotion < 0) {
          finalProductPrice = (productPrice + promotion);
        } else if (promotion > 0) {
          finalProductPrice = (productPrice * (100 - promotion) / 100).round();
        } else {
          finalProductPrice = productPrice;
        }
      }

      ProductOrderModel productOrderModel = ProductOrderModel(
        id: 'ProductOrder_${ci.cartId}_${ci.productId}', 
        productId: ci.productId, 
        orderId: orderModel.id, 
        isTester: ci.isTester, 
        quantity: ci.quantity, 
        finalPrice: finalProductPrice
      );
      await _orderProductController.addOrderProduct(productOrderModel);
    }
    for(var cp in cartPromoModels){
      PromotionOrderModel promotionOrderModel = PromotionOrderModel(id: 'PromotionOrder_${cp.cartId}_${cp.promotionId}', promotionId: cp.promotionId, orderId: orderModel.id);
      await _orderPromosController.addOrderPromotion(promotionOrderModel);
    }

    
    for(var ci in cartItemModels){
      await _cartItemsController.deleteCartItem(ci.id);
    }
    for(var cp in cartPromoModels){
      await _cartPromosController.deleteCartPromotion(cp.id);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      Column(
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
                                          0, 8), 
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
                                      key: _checkoutController.checkoutKey,
                                      child: Column(children: [
                                        InputType(
                                          controller: _checkoutController.firstName,
                                          validator: (value) => TValidator.validateEmptyText('First name', value),
                                          type: 'one-line',
                                          inputType: TextInputType.name,
                                          placeholder: 'First name',
                                          mustBeFilled: true,
                                        ),
                                        const SizedBox(height: 20),
                                        InputType(
                                          controller: _checkoutController.lastName,
                                          validator: (value) => TValidator.validateEmptyText('Last name', value),
                                          type: 'one-line',
                                          inputType: TextInputType.name,
                                          placeholder: 'Last name',
                                          mustBeFilled: true,
                                        ),
                                        const SizedBox(height: 20),
                                        InputType(
                                          controller: _checkoutController.phoneNo,
                                          validator: TValidator.validatePhoneNumber,
                                          type: 'one-line',
                                          inputType: TextInputType.phone,
                                          placeholder: 'Phone',
                                          mustBeFilled: true,
                                        ),
                                        const SizedBox(height: 20),
                                        InputType(
                                          controller: _checkoutController.email,
                                          validator: TValidator.validateEmail,
                                          type: 'one-line',
                                          inputType: TextInputType.emailAddress,
                                          placeholder: 'Email',
                                          mustBeFilled: true,
                                        ),
                                        const SizedBox(height: 20),
                                        InputType(
                                          controller: _checkoutController.address,
                                          validator: (value) => TValidator.validateEmptyText('Address', value),
                                          type: 'text-area',
                                          inputType: TextInputType.multiline,
                                          placeholder: 'Address',
                                          mustBeFilled: true,
                                        ),
                                      ])
                                    )
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
                                          0, 8), 
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
                                                    if(lastDeliveryMethodSelected == 'fast') reducedPrice -= 15;
                                                    lastDeliveryMethodSelected = 'pick-up in store';
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
                                            controller: pickupLocationController,
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
                                                    if(lastDeliveryMethodSelected == 'fast') reducedPrice -= 15;
                                                    lastDeliveryMethodSelected = 'standard';
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
                                                    lastDeliveryMethodSelected = 'fast';
                                                    reducedPrice += 15;
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
                                          0, 8), 
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
                                          0, 8), 
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
                                    if (currentCartPromos.isNotEmpty)
                                      for (var promotion in currentCartPromos)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 12),
                                          child: Text(
                                              '-${promotion['difference'].toStringAsFixed(1)} RON',
                                              style: tButton.copyWith(
                                                  color: red5)),
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
                                            '${reducedPrice.toStringAsFixed(1)} RON',
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
                              onPressed: () async => {
                                await _checkoutController.checkout(),
                                if (_checkoutController.firstName.text.trim() != '' && _checkoutController.lastName.text.trim() != '' && _checkoutController.email.text.trim() != '' && _checkoutController.phoneNo.text.trim() != '' && _checkoutController.address.text.trim() != ''){
                                  await createOrder(_checkoutController),
                                  Get.offAll(() => const OrderSuccessScreen())
                                } else TLoaders.errorSnackBar(title: 'Error', message: 'Order info missing.')
                              } 
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                  ]
                )
              )
            ]
          )
        )
      )
    );
  }
}
