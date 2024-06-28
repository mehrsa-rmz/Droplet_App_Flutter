import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/data/repositories/cart_repository.dart';
import 'package:flutter_application/features/order/controllers/cart_item_controller.dart';
import 'package:flutter_application/features/order/controllers/promotion_cart_controller.dart';
import 'package:flutter_application/features/order/controllers/promotion_controller.dart';
import 'package:flutter_application/features/order/models/cart_item_model.dart';
import 'package:flutter_application/features/order/models/cart_model.dart';
import 'package:flutter_application/features/order/models/promotion_cart_model.dart';
import 'package:flutter_application/features/order/models/promotion_model.dart';
import 'package:flutter_application/features/order/screens/checkout.dart';
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
import 'package:get/get.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel? userModel;
  TextEditingController promoCodeController= TextEditingController();
  final _cartItemsController = Get.put(CartItemsController());
  final _cartPromosController = Get.put(PromotionCartController());
  final _userController = Get.put(UserController());
  double totalPrice = 0;
  double reducedPrice = 0;
  late CartModel currentCart;
  late String currentCartId;
  
  List<Map<String, dynamic>> currentCartItems = [];
  List<CartItemModel> cartItemModels = [];
  List<Map<String, dynamic>> currentCartPromos = [];
  List<PromotionCartModel> cartPromoModels = [];

  @override
  void initState() {
    super.initState();
    fetchCartData();
  }

  Future<void> fetchCartData() async {
    if (user != null) {
      String userId = user!.uid;
      userModel = await UserController.fetchUserById(userId);

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

    currentCartItems = [];
    currentCartId = _userController.currentCart.value.id;
    print('currentCartId: $currentCartId');
    cartItemModels = await _cartItemsController.fetchCartItemsForCartId(currentCartId);
    print('cartItemModels: $cartItemModels');
    cartPromoModels = await _cartPromosController.fetchCartPromotionsForCartId(currentCartId);
    print('cartPromoModels: $cartPromoModels');
    
    for(var ci in cartItemModels){
      ProductModel? productToAdd = await ProductController.instance.getProductById(ci.productId);
      currentCartItems.add(
        {
          'id': ci.id,
          'name': productToAdd?.name ?? '',
          'price': productToAdd?.price ?? 0,
          'isTester': ci.isTester,
          'quantity': ci.quantity,
          'promotion': productToAdd?.promotion ?? 0,
          'stock': productToAdd?.stock ?? 0,
        }
      );
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
    print('currentCartItems: $currentCartItems');
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
    print('reducedPrice: $reducedPrice');

    setState(() {});
  }

  Future<void> updateCartItem(CartItemModel cartItem, int quantity) async {
    cartItem.quantity = quantity;
    if (quantity > 0) {
      await _cartItemsController.updateCartItem(cartItem.id, cartItem);
    } else {
      await _cartItemsController.deleteCartItem(cartItem.id);
    }
    await _cartItemsController.fetchCartItemsForCartId(cartItem.cartId);
  }

  Future<void> updateTesterItem(CartItemModel cartItem) async {
    bool found = false;
    for(var ci in cartItemModels){
      if(ci.productId == cartItem.productId && ci.isTester == false) {
        await updateCartItem(ci, ci.quantity + 1);
        await _cartItemsController.deleteCartItem(cartItem.id);
        found = true;
      }
    }
    if (found == false){
      cartItem.isTester = false;
      await _cartItemsController.updateCartItem(cartItem.id, cartItem);
    }

    await _cartItemsController.fetchCartItemsForCartId(cartItem.cartId);
    await fetchCartData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    // TODO loyalty program deduction

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
                  currentCartItems.isEmpty
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
                                offset: Offset(0, 8),
                              )
                            ],
                          ),
                          child: Text('No items in the shopping cart',
                              textAlign: TextAlign.center,
                              style: tButton.copyWith(color: black)))
                      : Column(
                          children: [
                            for (var product in currentCartItems)
                              CartItemBox(
                                name: product['name'],
                                isTester: product['isTester'],
                                quantity: product['quantity'],
                                price: product['promotion'] == 0 ? product['price'].toDouble() : product['promotion'] < 0 ? (product['price'] + product['promotion']).toDouble() : (product['price'] - product['price'] * product['promotion'] / 100).toDouble(),
                                promotion: product['promotion'],
                                onPressedChange: () async {
                                  final cartItemToUpdate = await _cartItemsController.getCartItemById(product['id']);
                                  updateTesterItem(cartItemToUpdate!);
                                  fetchCartData();
                                  setState(() {});
                                },
                                onPressedMinus: () async {
                                  final cartItemToUpdate = await _cartItemsController.getCartItemById(product['id']);
                                  updateCartItem(cartItemToUpdate!, cartItemToUpdate.quantity - 1);
                                  fetchCartData();
                                  setState(() {});
                                },
                                onPressedPlus: () async {
                                  final cartItemToUpdate = await _cartItemsController.getCartItemById(product['id']);
                                  updateCartItem(cartItemToUpdate!, cartItemToUpdate.quantity + 1);
                                  fetchCartData();
                                  setState(() {});
                                },
                                onPressedX: () async {
                                  await _cartItemsController.deleteCartItem(product['id']);
                                  fetchCartData();
                                  setState(() {});
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
                                          8), 
                                    )
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    InputType(
                                      controller: promoCodeController,
                                      type: 'one-line',
                                      inputType: TextInputType.text,
                                      placeholder: 'Promo code',
                                      mustBeFilled: true,
                                    ),
                                    const SizedBox(height: 16),
                                    ButtonType(text: 'Add code', color: red5, type: 'primary', onPressed: () async {
                                      PromotionModel? promoToAdd = await PromotionController.instance.getPromotionById(promoCodeController.text.trim());
                                      if (promoToAdd == null){
                                        TLoaders.errorSnackBar(title: 'Error', message: 'No such promo code.');
                                      } else {
                                        var ok = true;
                                        for(var cp in cartPromoModels){
                                          if (cp.promotionId == promoToAdd.id){
                                            ok = false;
                                          }
                                        }
                                        if (ok) {
                                          await PromotionCartController.instance.addCartPromotion(PromotionCartModel(id: 'PromoCart_${promoToAdd.id}_$currentCartId', promotionId: promoToAdd.id, cartId: currentCartId));
                                          fetchCartData();
                                          setState(() {});
                                        } else {
                                          TLoaders.errorSnackBar(title: 'Error', message: 'Promo code already applied.');
                                        }
                                      }
                                    },),
                                    if (currentCartPromos.isNotEmpty)
                                      for (var code in currentCartPromos)
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
                                          8), 
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
                                            style: tMenu.copyWith(color: blue7)),
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

class CartItemBox extends StatelessWidget {
  const CartItemBox(
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
              offset: Offset(0, 8), 
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
                          Text('$quantity x ${price.toStringAsFixed(1)} RON',
                              style: tParagraph.copyWith(color: black)),
                          const SizedBox(height: 4),
                          Text('${(quantity * price).toStringAsFixed(1)} RON',
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
