import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/features/authentication/screens/login/login.dart';
import 'package:flutter_application/features/authentication/screens/signup/signup.dart';
import 'package:flutter_application/features/order/controllers/cart_item_controller.dart';
import 'package:flutter_application/features/products/controllers/favorites_controller.dart';
import 'package:flutter_application/features/products/controllers/ingredinets_controller.dart';
import 'package:flutter_application/features/products/controllers/product_controller.dart';
import 'package:flutter_application/features/products/controllers/product_ingredients_controller.dart';
import 'package:flutter_application/features/products/controllers/product_review_controller.dart';
import 'package:flutter_application/features/products/models/favorites_model.dart';
import 'package:flutter_application/features/products/models/ingredient_model.dart';
import 'package:flutter_application/features/products/models/product_ingredient_model.dart';
import 'package:flutter_application/features/products/models/product_model.dart';
import 'package:flutter_application/features/products/models/product_review_model.dart';
import 'package:flutter_application/features/profile/controllers/user_controller.dart';
import 'package:flutter_application/features/profile/models/user_model.dart';
import 'package:flutter_application/features/order/models/cart_item_model.dart';
import 'package:flutter_application/utils/constants/asset_strings.dart';
import 'package:flutter_application/utils/constants/text_styles.dart';
import 'package:flutter_application/utils/constants/colors.dart';
import 'package:flutter_application/common/widgets/buttons.dart';
import 'package:flutter_application/common/widgets/inputs.dart';
import 'package:flutter_application/common/widgets/navbar.dart';
import 'package:flutter_application/utils/formatters/formatter.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.currentProductId});

  final String currentProductId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel? userModel;
  Map<String, dynamic> currentProduct = {
    'id': '',
    'name': '',
    'price': 0,
    'reviewsNo': 0,
    'rating': 0,
    'favorite': false,
    'outOfStock': false,
    'promotion': 0,
    'ingredients': [],
    'stock': 0,
  };
  
  final ScrollController scrollController = ScrollController();

  int newReviewRating = 0;
  TextEditingController newReviewController = TextEditingController();
  List<ProductReviewModel> currentProductReviews = [];
  List<Map<String, dynamic>> currentProductReviewsMap = [];

  int inCart = 0;
  bool testerAdded = false;
  bool testerLimitReached = false; // TODO
  bool expanded1 = false;
  bool expanded2 = false;
  bool expanded3 = false;

  final _cartItemsController = Get.put(CartItemsController());
  final _userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    fetchUserData();
    fetchProductData();
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
    } else {
      print('No user is currently signed in.');
    }
  }

  Future<void> fetchProductData() async {
    // Fetching future data
    List<ProductIngredientModel> productIngredients = await ProductIngredientController.instance.fetchAllProductIngredients();
    List<FavoriteModel> favorites = await FavoritesController.instance.fetchCurrentUserFavorites();
    currentProductReviews = await ProductReviewController.instance.fetchAllProductsReviews();
    await _cartItemsController.fetchCartItemsForCartId(_userController.currentCart.value.id);

    // Fetching product data
    ProductModel? fetchedProduct = await ProductController.instance.getProductById(widget.currentProductId);
    List<IngredientModel> ingredients = await IngredientController.instance.getIngredients();

    if (fetchedProduct == null) {
      print('Product not found.');
      return;
    }

    // Mapping ingredients to their IDs for quick lookup
    Map<String, IngredientModel> ingredientMap = {for (var i in ingredients) i.id: i};

    // Creating a map for product ingredients
    Map<String, List<String>> productIngredientMap = {};
    for (var pi in productIngredients) {
      if (!productIngredientMap.containsKey(pi.productId)) {
        productIngredientMap[pi.productId] = [];
      }
      productIngredientMap[pi.productId]!.add(pi.ingredientId);
    }

    // Creating a map for product reviews
    Map<String, List<ProductReviewModel>> productReviewMap = {};
    for (var pr in currentProductReviews) {
      if (!productReviewMap.containsKey(pr.productId)) {
        productReviewMap[pr.productId] = [];
        productReviewMap[pr.productId]!.add(pr);
        if(pr.productId == widget.currentProductId) {
          currentProductReviewsMap.add({
            'userName': await UserController.fetchUserNameById(pr.userId),
            'rating': pr.rating,
            'dateTime': pr.dateTime,
            'message': pr.message!
          });
        }
      }
    }

    // Creating a set for favorites
    Set<String> isFavoriteMap = favorites.map((f) => f.productId).toSet();

    // Constructing the current product data
    String productId = fetchedProduct.id;
    List<String> ingredientIds = productIngredientMap[productId] ?? [];

    // Calculating reviews
    List<ProductReviewModel> reviews = productReviewMap[productId] ?? [];
    double rating = reviews.isNotEmpty
        ? reviews.map((r) => r.rating).reduce((a, b) => a + b) / reviews.length
        : 0.0;

    currentProduct = {
      'id': productId,
      'name': fetchedProduct.name,
      'price': fetchedProduct.price,
      'reviewsNo': reviews.length,
      'rating': rating,
      'favorite': isFavoriteMap.contains(productId),
      'outOfStock': fetchedProduct.stock == 0,
      'promotion': fetchedProduct.promotion,
      'ingredients': ingredientIds.map((id) => ingredientMap[id]?.name ?? 'Unknown').toList(),
      'stock': fetchedProduct.stock,
    };

    setState(() {});
  }

  Future<void> addToCart() async {
    final cartId = _userController.currentCart.value.id;
    final cartItem = CartItemModel(
      id: 'CartItem_${cartId}_${currentProduct['id']}',
      productId: currentProduct['id'],
      cartId: cartId,
      isTester: false,
      quantity: 1,
    );

    await _cartItemsController.addCartItem(cartItem);
    await _cartItemsController.fetchCartItemsForCartId(cartId);
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

  Future<void> addTester() async {
    final cartId = _userController.currentCart.value.id;
    final cartItem = CartItemModel(
      id: '',
      productId: currentProduct['id'],
      cartId: cartId,
      isTester: true,
      quantity: 1,
    );

    await _cartItemsController.addCartItem(cartItem);
    await _cartItemsController.fetchCartItemsForCartId(cartId);
  }

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
                        Text(currentProduct['name'], style: h5.copyWith(color: red5)),
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
                    currentProduct['promotion'] == 0
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${currentProduct['price']} RON',
                                style: h4.copyWith(color: black),
                              ),
                              IconButton(
                                icon: Icon(
                                  currentProduct['favorite']
                                      ? CupertinoIcons.heart_fill
                                      : CupertinoIcons.heart,
                                  color: red5,
                                  size: 40),
                                onPressed: user != null
                                  ? () async {
                                    setState(() {
                                      currentProduct['favorite'] = !currentProduct['favorite'];
                                    });

                                    if (currentProduct['favorite'] == true) {
                                      await FavoritesController.instance.addFavorite(
                                        FavoriteModel(
                                          id: 'FAV_${userModel!.firstName}_${currentProduct['id']}',
                                          userId: userModel!.id,
                                          productId: currentProduct['id'],
                                        ),
                                      );
                                    } else {
                                      String favToDeleteId = await FavoritesController.instance.getFavoriteDocumentIdByItemId('FAV_${userModel!.firstName}_${currentProduct['id']}') ?? '';
                                      await FavoritesController.instance.deleteFavorite(favToDeleteId);
                                    }

                                    // Fetch the updated data after the operation
                                    await fetchProductData();

                                    // Update the state synchronously
                                    setState(() {
                                    });
                                  }
                                  : () => showDialog(
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
                                                child: Text( 'You must be logged in to add products to favorites', style: tParagraph.copyWith(color: grey8))),
                                            const SizedBox(height: 24),
                                            Row(children: [
                                              SizedBox(
                                                width: context.width /2 -6 -40,
                                                child: ButtonTypeIcon(
                                                  text: 'Login',
                                                  icon: CupertinoIcons.square_arrow_right,
                                                  color: blue7,
                                                  type: 'primary',
                                                  onPressed: () => Get.to(() => const LoginScreen()),
                                                )
                                              ),
                                              const SizedBox(width: 12),
                                              SizedBox(
                                                width: context.width / 2 - 6 - 40,
                                                child: ButtonTypeIcon(
                                                  text: 'Sign up',
                                                  icon: CupertinoIcons.person_badge_plus,
                                                  color: red5,
                                                  type: 'primary',
                                                  onPressed: () => Get.to(() => const SignupScreen()),
                                                )
                                              )
                                            ]),
                                          ],
                                        ),
                                      );
                                    }
                                  ),
                                )
                            ]
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${currentProduct['price']} RON',
                                style: h5Crossed.copyWith(color: black),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    currentProduct['promotion'] < 0
                                        ? '${currentProduct['price'] + currentProduct['promotion']} RON'
                                        : '${currentProduct['price'] * (100 - currentProduct['promotion']) / 100} RON',
                                    style: h4.copyWith(color: red5),
                                  ),
                                  IconButton(
                                      icon: Icon(
                                          currentProduct['favorite']
                                              ? CupertinoIcons.heart_fill
                                              : CupertinoIcons.heart,
                                          color: red5,
                                          size: 40),
                                      onPressed: user != null
                                      ? () async {
                                        setState(() {
                                          currentProduct['favorite'] = !currentProduct['favorite'];
                                        });

                                        if (currentProduct['favorite'] == true) {
                                          await FavoritesController.instance.addFavorite(
                                            FavoriteModel(
                                              id: 'FAV_${userModel!.firstName}_${currentProduct['id']}',
                                              userId: userModel!.id,
                                              productId: currentProduct['id'],
                                            ),
                                          );
                                        } else {
                                          String favToDeleteId = await FavoritesController.instance.getFavoriteDocumentIdByItemId('FAV_${userModel!.firstName}_${currentProduct['id']}') ?? '';
                                          await FavoritesController.instance.deleteFavorite(favToDeleteId);
                                        }

                                        // Fetch the updated data after the operation
                                        await fetchProductData();

                                        // Update the state synchronously
                                        setState(() {
                                        });
                                      }
                                      : () => showDialog(
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
                                                    child: Text( 'You must be logged in to add products to favorites', style: tParagraph.copyWith(color: grey8))),
                                                const SizedBox(height: 24),
                                                Row(children: [
                                                  SizedBox(
                                                    width: context.width /2 -6 -40,
                                                    child: ButtonTypeIcon(
                                                      text: 'Login',
                                                      icon: CupertinoIcons.square_arrow_right,
                                                      color: blue7,
                                                      type: 'primary',
                                                      onPressed: () => Get.to(() => const LoginScreen()),
                                                    )
                                                  ),
                                                  const SizedBox(width: 12),
                                                  SizedBox(
                                                    width: context.width / 2 - 6 - 40,
                                                    child: ButtonTypeIcon(
                                                      text: 'Sign up',
                                                      icon: CupertinoIcons.person_badge_plus,
                                                      color: red5,
                                                      type: 'primary',
                                                      onPressed: () => Get.to(() => const SignupScreen()),
                                                    )
                                                  )
                                                ]),
                                              ],
                                            ),
                                          );
                                        }),
                                  )
                                ],
                              ),
                            ],
                          ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Text('${currentProduct['rating']}',
                            style: h5.copyWith(color: grey8)),
                        const SizedBox(
                          width: 4,
                        ),
                        Icon(CupertinoIcons.star_fill, color: grey8, size: 24),
                        const SizedBox(width: 24),
                        ButtonType(
                          text: 'See ${currentProduct['reviewsNo']} reviews',
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
                    Obx(() {
                      final cartItems = _cartItemsController.cartItems
                          .where((item) =>
                              item.productId == currentProduct['id'] &&
                              !item.isTester)
                          .toList();

                      final testerItem = _cartItemsController.cartItems
                          .firstWhereOrNull((item) =>
                              item.productId == currentProduct['id'] &&
                              item.isTester);

                      inCart = cartItems.isNotEmpty
                          ? cartItems.first.quantity
                          : 0;
                      testerAdded = testerItem != null;

                      return Column(
                        children: [
                          inCart == 0
                              ? (currentProduct['outOfStock']
                                  ? ButtonType(
                                      text: 'Out of stock',
                                      color: red5,
                                      type: 'primary')
                                  : ButtonType(
                                      text: 'Add to shopping cart',
                                      color: red5,
                                      type: 'primary',
                                      onPressed: () async {
                                        await addToCart();
                                        setState(() {});
                                      },
                                    ))
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                        width: 48,
                                        child: ButtonTypeIcon(
                                          text: '',
                                          icon: CupertinoIcons.minus,
                                          color: red5,
                                          type: 'primary',
                                          onPressed: () async {
                                            if (cartItems.isNotEmpty) {
                                              final cartItem = cartItems.first;
                                              await updateCartItem(cartItem, cartItem.quantity - 1);
                                              setState(() {});
                                            }
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
                                      child: currentProduct['stock'] > inCart ? ButtonTypeIcon(
                                        text: '',
                                        icon: CupertinoIcons.add,
                                        color: red5,
                                        type: 'primary',
                                        onPressed: () async {
                                          if (currentProduct['stock'] > inCart) {
                                            if (cartItems.isNotEmpty) {
                                              final cartItem = cartItems.first;
                                              await updateCartItem(cartItem, cartItem.quantity + 1);
                                              setState(() {});
                                            }
                                          }
                                        },
                                      ) 
                                      : ButtonTypeIcon(
                                        text: '',
                                        icon: CupertinoIcons.add,
                                        color: red5,
                                        type: 'primary'
                                      )
                                    ),
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const SizedBox(width: 48),
                                                  Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 24,
                                                        vertical: 8),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
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
                                                        onPressed: () async {
                                                          if (testerItem != null) {
                                                            await _cartItemsController.deleteCartItem(testerItem.id);
                                                            setState(() {});
                                                          }
                                                        },
                                                      )),
                                                ],
                                              )
                                            : ButtonType(
                                                text:
                                                    'Not sure yet? Try a tester',
                                                color: pink5,
                                                type: 'primary',
                                                onPressed: () async {
                                                  await addTester();
                                                  setState(() {});
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text('Wanna try a tester first?',
                                        style: tMenu.copyWith(color: black)),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                        'Every month you can try up to 5 distinct testers for free (in the same order or different ones).',
                                        style: tParagraph.copyWith(
                                            color: grey8)),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                            width: context.width / 2 - 16 - 6,
                                            child: ButtonTypeIcon(
                                              text: 'Login',
                                              icon: CupertinoIcons
                                                  .square_arrow_right,
                                              color: blue7,
                                              type: 'primary',
                                              onPressed: () =>
                                                  Get.to(() =>
                                                      const LoginScreen()),
                                            )),
                                        const SizedBox(width: 12),
                                        SizedBox(
                                            width: context.width / 2 - 16 - 6,
                                            child: ButtonTypeIcon(
                                              text: 'Sign up',
                                              icon: CupertinoIcons
                                                  .person_badge_plus,
                                              color: pink5,
                                              type: 'primary',
                                              onPressed: () =>
                                                  Get.to(() =>
                                                      const SignupScreen()),
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                        ],
                      );
                    }),
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
                                      0, 8), 
                                )
                              ],
                            ),
                            child: Text(
                              'This is a very long message meant for completing the text area input in order to make it look better. This is a very long message meant for completing the text area input in order to make it look better.',
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
                                      0, 8), 
                                )
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: currentProduct['ingredients']
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
                                        'We hope you enjoyed this product! Leave a rating and a review for Pop Laura.',
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
                                          newReviewRating = rating.round();
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
                                      controller: newReviewController,
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
                                            onPressed: () async => {
                                              await ProductReviewController.instance.addProductReview(ProductReviewModel(
                                                id: '', 
                                                productId: widget.currentProductId, 
                                                userId: userModel!.id, 
                                                rating: newReviewRating, 
                                                message: newReviewController.text, 
                                                dateTime: TFormatter.formatAppointmentDate(DateTime.now())
                                              )),
                                              fetchProductData(),
                                              Navigator.of(context).pop(),
                                              setState(() {})
                                            }
                                          )
                                      ),
                                      const SizedBox(width: 12),
                                      SizedBox(
                                        width: context.width / 2 - 6 - 40,
                                        child: ButtonType(
                                          text: 'Cancel',
                                          color: red5,
                                          type: "secondary",
                                          onPressed: () => {
                                            newReviewController.text = '',
                                            Navigator.of(context).pop()
                                          }
                                        )
                                      )
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
                        ? Wrap(
                          spacing: 20,
                          children: <Widget>[
                            for (var pr in currentProductReviewsMap)
                              ReviewBox(name: pr['userName'], rating: pr['rating'], date: pr['dateTime'], review: pr['message'])
                          ]
                        )
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
  final int rating;
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
              offset: Offset(0, 8), 
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