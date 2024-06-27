import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/features/products/controllers/conditions_controller.dart';
import 'package:flutter_application/features/products/controllers/favorites_controller.dart';
import 'package:flutter_application/features/products/controllers/ingredinets_controller.dart';
import 'package:flutter_application/features/products/controllers/product_conditions_controller.dart';
import 'package:flutter_application/features/products/controllers/product_controller.dart';
import 'package:flutter_application/features/products/controllers/product_ingredients_controller.dart';
import 'package:flutter_application/features/products/controllers/product_review_controller.dart';
import 'package:flutter_application/features/products/models/condition_model.dart';
import 'package:flutter_application/features/products/models/favorites_model.dart';
import 'package:flutter_application/features/products/models/ingredient_model.dart';
import 'package:flutter_application/features/products/models/product_condition_model.dart';
import 'package:flutter_application/features/products/models/product_ingredient_model.dart';
import 'package:flutter_application/features/products/models/product_model.dart';
import 'package:flutter_application/features/products/models/product_review_model.dart';
import 'package:flutter_application/features/products/screens/product_page.dart';
import 'package:flutter_application/features/profile/controllers/user_allergies_controller.dart';
import 'package:flutter_application/features/profile/controllers/user_conditions_controller.dart';
import 'package:flutter_application/features/profile/controllers/user_controller.dart';
import 'package:flutter_application/features/profile/models/user_allergy_model.dart';
import 'package:flutter_application/features/profile/models/user_condition_model.dart';
import 'package:flutter_application/features/profile/models/user_model.dart';
import 'package:flutter_application/utils/constants/asset_strings.dart';
import 'package:flutter_application/utils/constants/text_styles.dart';
import 'package:flutter_application/utils/constants/colors.dart';
import 'package:flutter_application/common/widgets/buttons.dart';
import 'package:flutter_application/common/widgets/inputs.dart';
import 'package:flutter_application/common/widgets/navbar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PersonalRecScreen extends StatefulWidget {
  const PersonalRecScreen({super.key});

  @override
  State<PersonalRecScreen> createState() => _PersonalRecScreenState();
}

class _PersonalRecScreenState extends State<PersonalRecScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel? userModel;
  Map<String, dynamic> userDetails = {
    'id': '',
    'gender': 'all',
    'ageGroup': 'all',
    'conditions': [],
    'allergies': []
  };
  List<Map<String, dynamic>> allProducts = [];

  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> _filteredProducts = [];
  String category = 'all';
  String sex = 'all';
  String age = 'all';
  List<String> conditions = [];
  bool hypoallergenic = false;
  RangeValues priceRange = const RangeValues(0, 560);
  List<String> ingredients = [];
  String sortBy = 'Alphabetical';

  @override
  void initState() {
    super.initState();
    fetchUserData();
    fetchAndCombineData().then((_) {
      setState(() {
        _filterProducts();
      });
    });
    _searchController.addListener(_filterProducts);
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

      List<UserConditionModel> userConditions = await UserConditionController.instance.fetchAllUserConditions();
      List<UserAllergyModel> userAllergies = await UserAllergyController.instance.fetchAllUserAllergies();
      List<IngredientModel> ingredients = await IngredientController.instance.getIngredients();
      List<ConditionModel> conditions = await ConditionController.instance.getConditions();

      // Mapping ingredients to their IDs for quick lookup
      Map<String, IngredientModel> ingredientMap = {for (var i in ingredients) i.id: i};
      Map<String, ConditionModel> conditionMap = {for (var c in conditions) c.id: c};

      // Creating a map for user conditions and allergies
      Map<String, List<String>> userConditionMap = {};
      for (var uc in userConditions) {
        if (!userConditionMap.containsKey(uc.userId)) {
          userConditionMap[uc.userId] = [];
        }
        userConditionMap[uc.userId]!.add(uc.conditionId);
      }

      Map<String, List<String>> userAllergyMap = {};
      for (var ui in userAllergies) {
        if (!userAllergyMap.containsKey(ui.userId)) {
          userAllergyMap[ui.userId] = [];
        }
        userAllergyMap[ui.userId]!.add(ui.ingredientId);
      }

      // Constructing the current product data
      List<String> allergyIds = userAllergyMap[userId] ?? [];
      List<String> conditionIds = userConditionMap[userId] ?? [];

      String getAgeRange(String birthdayString) {
        if (birthdayString.isEmpty) {
          return 'all';
        }

        DateFormat formatter = DateFormat('dd-MM-yyyy');
        DateTime birthday;

        try {
          birthday = formatter.parse(birthdayString);
        } catch (e) {
          return 'Invalid date format';
        }

        DateTime today = DateTime.now();
        int age = today.year - birthday.year;

        if (today.month < birthday.month || (today.month == birthday.month && today.day < birthday.day)) {
          age--;
        }

        if (age >= 16 && age <= 24) {
          return '16-24 y';
        } else if (age >= 25 && age <= 49) {
          return '25-49 y';
        } else {
          return '50+ years';
        } 
      }

      userDetails = {
        'id': userId,
        'gender': userModel?.gender ?? 'all',
        'ageGroup': getAgeRange(userModel?.birthday ?? ''),
        'conditions': conditionIds.map((id) => conditionMap[id]?.name ?? 'Unknown').toList(),
        'allergies': allergyIds.map((id) => ingredientMap[id]?.name ?? 'Unknown').toList(),
      };

      setState(() {});

    } else {
      print('No user is currently signed in.');
    }
  }

  Future<void> fetchAndCombineData() async {
    // TODO: move these in the repositories
    // Fetching future data
    List<ProductConditionModel> productConditions = await ProductConditionController.instance.fetchAllProductConditions();
    List<ProductIngredientModel> productIngredients = await ProductIngredientController.instance.fetchAllProductIngredients();
    List<FavoriteModel> favorites = await FavoritesController.instance.fetchCurrentUserFavorites();
    List<ProductReviewModel> productReviews = await ProductReviewController.instance.fetchAllProductsReviews();

    // Fetching stream data
    List<ProductModel> products = await ProductController.instance.fetchAllProducts();
    List<ConditionModel> conditions = await ConditionController.instance.getConditions();
    List<IngredientModel> ingredients = await IngredientController.instance.getIngredients();

    // Mapping conditions and ingredients to their IDs for quick lookup
    Map<String, ConditionModel> conditionMap = {for (var c in conditions) c.id: c};
    Map<String, IngredientModel> ingredientMap = {for (var i in ingredients) i.id: i};

    // Creating a map for product conditions and ingredients
    Map<String, List<String>> productConditionMap = {};
    for (var pc in productConditions) {
      if (!productConditionMap.containsKey(pc.productId)) {
        productConditionMap[pc.productId] = [];
      }
      productConditionMap[pc.productId]!.add(pc.conditionId);
    }

    Map<String, List<String>> productIngredientMap = {};
    for (var pi in productIngredients) {
      if (!productIngredientMap.containsKey(pi.productId)) {
        productIngredientMap[pi.productId] = [];
      }
      productIngredientMap[pi.productId]!.add(pi.ingredientId);
    }

    // Creating a map for product reviews
    Map<String, List<ProductReviewModel>> productReviewMap = {};
    for (var pr in productReviews) {
      if (!productReviewMap.containsKey(pr.productId)) {
        productReviewMap[pr.productId] = [];
      }
      productReviewMap[pr.productId]!.add(pr);
    }

    // Creating a map for favorites
    Set<String> favoriteProductIds = favorites.map((f) => f.productId).toSet();

    // Combining the data into the desired structure
    allProducts = products.map((product) {
      String productId = product.id;
      List<String> conditionIds = productConditionMap[productId] ?? [];
      List<String> ingredientIds = productIngredientMap[productId] ?? [];

      // Calculating reviews
      List<ProductReviewModel> reviews = productReviewMap[productId] ?? [];
      double rating = reviews.isNotEmpty
          ? reviews.map((r) => r.rating).reduce((a, b) => a + b) / reviews.length
          : 0.0;

      return {
        'id': productId,
        'category': product.category,
        'sex': product.gender,
        'age': product.ageGroup,
        'conditions': conditionIds.map((id) => conditionMap[id]?.name ?? 'Unknown').toList(),
        'hypoallergenic': product.isHypoallergenic,
        'name': product.name,
        'price': product.price,
        'reviewsNo': reviews.length,
        'rating': rating,
        'favorite': favoriteProductIds.contains(productId),
        'outOfStock': product.stock == 0,
        'promotion': product.promotion,
        'ingredients': ingredientIds.map((id) => ingredientMap[id]?.name ?? 'Unknown').toList(),
      };
    }).toList();
  }

  void _filterProducts() {
    setState(() {
      _filteredProducts = allProducts.where((product) {
        bool matchesCategory =
            category == 'all' ? true : product['category'] == category;
        bool matchesSex =
            product['sex'] == userDetails['gender'] || product['sex'] == 'all'; 
        bool matchesAge =
            product['age'] == userDetails['ageGroup'] || product['age'] == 'all';
        bool matchesConditions = userDetails['conditions'].isEmpty ||
            (userDetails['conditions'] as List<String>).any((condition) =>
                (product['conditions'] as List<String>).contains(condition));
        bool matchesIngredients = userDetails['allergies'].isEmpty ||
            (userDetails['allergies'] as List<String>).every((ingredient) =>
                !(product['ingredients'] as List<String>).contains(ingredient));
        bool matchesPrice = product['price'] >= priceRange.start &&
            product['price'] <= priceRange.end;
        bool matchesSearch = product['name']
            .toLowerCase()
            .contains(_searchController.text.toLowerCase());

        return matchesCategory &&
            matchesSex &&
            matchesAge &&
            matchesConditions &&
            matchesIngredients &&
            matchesPrice &&
            matchesSearch;
      }).toList();

      _sortProducts();
    });
  }

  void _sortProducts() {
    switch (sortBy) {
      case 'Alphabetical':
        _filteredProducts.sort((a, b) => a['name'].compareTo(b['name']));
        break;
      case 'Ascending Price':
        _filteredProducts.sort((a, b) => a['price'].compareTo(b['price']));
        break;
      case 'Descending Price':
        _filteredProducts.sort((a, b) => b['price'].compareTo(a['price']));
        break;
      case 'Rating':
        _filteredProducts.sort((a, b) => b['rating'].compareTo(a['rating']));
        break;
      case 'Most Popular':
        _filteredProducts
            .sort((a, b) => b['noOfOrders'].compareTo(a['noOfOrders']));
        break;
      default:
        break;
    }
  }

  void _showFilterAndSort() {
    final originalSortBy = sortBy;
    final originalPriceRange = priceRange;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: white1,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
      ),
      builder: (context) {
        return FilterAndSortWidget(
          onApply: () {
            _filterProducts();
            Navigator.pop(context);
          },
          onCancel: () {
            setState(() {
              sortBy = originalSortBy;
              priceRange = originalPriceRange;
            });
            Navigator.pop(context);
          },
          onSortByChanged: (value) {
            setState(() {
              sortBy = value;
            });
          },
          onPriceRangeChanged: (values) {
            setState(() {
              priceRange = values;
            });
          },
          category: category,
          sortBy: sortBy,
          priceRange: priceRange,
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterProducts);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Scaffold(
        bottomNavigationBar: const BottomNavBar(selectedOption: 'explore',),
        floatingActionButton: FloatingActionButton(
          backgroundColor: blue4dtrans,
          foregroundColor: white1,
          elevation: 0,
          shape: CircleBorder(side: BorderSide(color: white1, width: 2)),
          onPressed: () {
            scrollController.animateTo(
              0,
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeInOut,
            );
          },
          child: const Icon(CupertinoIcons.chevron_up),
        ),
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(bkg2),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
                child: Column(children: [
              Container(
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage(bkg2),
                    fit: BoxFit.cover,
                  ),
                  border: Border(
                    bottom: BorderSide(color: blue7, width: 3),
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
                              color: blue7, size: 32),
                          onPressed: () => Get.back(),
                        ),
                        Text('Your selection',
                            style: h4.copyWith(color: blue7)),
                        const SizedBox(width: 32)
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
              Expanded(
                  child: ListView(
                      controller: scrollController,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          MySearchBar(searchController: _searchController),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              categoryToggleButton(
                                  'All',
                                  category == 'all',
                                  () => setState(() {
                                        category = 'all';
                                        _filterProducts();
                                      })),
                              const SizedBox(width: 12),
                              categoryToggleButton(
                                  'Skincare',
                                  category == 'Skin',
                                  () => setState(() {
                                        category = 'Skin';
                                        _filterProducts();
                                      })),
                              const SizedBox(width: 12),
                              categoryToggleButton(
                                  'Haircare',
                                  category == 'Hair',
                                  () => setState(() {
                                        category = 'Hair';
                                        _filterProducts();
                                      })),
                              const SizedBox(width: 12),
                              categoryToggleButton(
                                  'Body',
                                  category == 'Body',
                                  () => setState(() {
                                        category = 'Body';
                                        _filterProducts();
                                      })),
                              const SizedBox(width: 12),
                              categoryToggleButton(
                                  'Perfume',
                                  category == 'Perfume',
                                  () => setState(() {
                                        category = 'Perfume';
                                        _filterProducts();
                                      })),
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: white1,
                              border: Border.all(color: grey8, width: 2),
                            ),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                minimumSize: Size.zero,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                overlayColor:
                                    const Color.fromARGB(0, 255, 255, 255),
                              ),
                              onPressed: _showFilterAndSort,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Filter and Sort',
                                      style: tFilter.copyWith(color: grey8)),
                                  const SizedBox(width: 8),
                                  Icon(CupertinoIcons.slider_horizontal_3,
                                      color: grey8, size: 24)
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          _filteredProducts.isEmpty
                              ? Container(
                                  alignment: Alignment.center,
                                  width: context.width,
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
                                  child: Text('No products found',
                                      style: tButton.copyWith(color: black)))
                              : Wrap(
                                  spacing: 16,
                                  runSpacing: 16,
                                  children: <Widget>[
                                      for (var product in _filteredProducts)
                                        productBox(
                                          context.width,
                                          product['name'],
                                          product['price'],
                                          product['reviewsNo'],
                                          product['rating'],
                                          product['favorite'],
                                          product['outOfStock'],
                                          product['promotion'],
                                          () => Get.to(() => ProductDetailsScreen(currentProductId: product['id'],)),
                                          user != null
                                          ? () async {
                                            setState(() {
                                              product['favorite'] = !product['favorite'];
                                            });

                                            if (product['favorite'] == true) {
                                              await FavoritesController.instance.addFavorite(
                                                FavoriteModel(
                                                  id: 'FAV_${userModel!.firstName}_${product['id']}',
                                                  userId: userModel!.id,
                                                  productId: product['id'],
                                                ),
                                              );
                                            } else {
                                              String favToDeleteId = await FavoritesController.instance.getFavoriteDocumentIdByItemId('FAV_${userModel!.firstName}_${product['id']}') ?? '';
                                              await FavoritesController.instance.deleteFavorite(favToDeleteId);
                                            }

                                            // Fetch the updated data after the operation
                                            await fetchAndCombineData();

                                            // Update the state synchronously
                                            setState(() {
                                              _filterProducts();
                                            });
                                          }
                                          : () {}
                                        ),
                                    ]),
                          const SizedBox(
                            height: 20,
                          )
                        ])
                  ]))
            ]))));
  }
}

Widget categoryToggleButton(
    String title, bool isSelected, VoidCallback onPressed) {
  return Container(
    padding: isSelected
        ? const EdgeInsets.symmetric(horizontal: 3)
        : const EdgeInsets.all(0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: isSelected ? white1 : Colors.transparent,
      border: isSelected ? Border.all(color: blue7, width: 2) : null,
    ),
    child: TextButton(
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        overlayColor: const Color.fromARGB(0, 255, 255, 255),
      ),
      onPressed: onPressed,
      child: Text(title, style: tFilter.copyWith(color: blue7)),
    ),
  );
}

Widget productBox(
    double width,
    String name,
    int price,
    int reviewsNo,
    double rating,
    bool favorite,
    bool outOfStock,
    int promotion,
    VoidCallback onPressed,
    VoidCallback iconOnPressed) {
  return Stack(children: [
    Container(
        width: width / 2 - 16 - 8,
        padding: const EdgeInsets.all(12),
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
            promotion == 0
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          icon: Icon(
                              favorite
                                  ? CupertinoIcons.heart_fill
                                  : CupertinoIcons.heart,
                              color: red5,
                              size: 24),
                          onPressed: iconOnPressed)
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 12),
                        decoration: BoxDecoration(
                            color: red5,
                            borderRadius: BorderRadius.circular(24)),
                        child: Text(
                          promotion < 0 ? '$promotion RON' : '-$promotion %',
                          style: tButton.copyWith(color: white1),
                        ),
                      ),
                      IconButton(
                          icon: Icon(
                              favorite
                                  ? CupertinoIcons.heart_fill
                                  : CupertinoIcons.heart,
                              color: red5,
                              size: 24),
                          onPressed: iconOnPressed)
                    ],
                  ),
            TextButton(
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                  overlayColor: const Color.fromARGB(0, 255, 255, 255),
                ),
                onPressed: onPressed,
                child: Column(children: [
                  Image.asset(product, height: 120),
                  const SizedBox(height: 16),
                  Text(
                    name,
                    style: tMenu.copyWith(color: black),
                  ),
                  const SizedBox(height: 4),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: '$reviewsNo reviews:  ',
                        style: tParagraphMed.copyWith(color: grey8)),
                    TextSpan(
                        text: '$rating ★',
                        style: tParagraphMed.copyWith(color: black))
                  ])),
                  const SizedBox(height: 16),
                  promotion == 0
                      ? Text(
                          '$price RON',
                          style: h5.copyWith(color: black),
                        )
                      : Text(
                          promotion < 0
                              ? '${price + promotion} RON'
                              : '${price * (100 - promotion) / 100} RON',
                          style: h5.copyWith(color: red5),
                        )
                ]))
          ],
        )),
    if (outOfStock)
      Positioned(
          top: 100,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 40),
            color: grey8,
            child: Text('out of stock', style: tButton.copyWith(color: white1)),
          )),
  ]);
}

class FilterAndSortWidget extends StatefulWidget {
  final VoidCallback onApply;
  final VoidCallback onCancel;
  final ValueChanged<String> onSortByChanged;
  final ValueChanged<RangeValues> onPriceRangeChanged;
  final String category;
  final String sortBy;
  final RangeValues priceRange;

  const FilterAndSortWidget({
    super.key,
    required this.onApply,
    required this.onCancel,
    required this.onSortByChanged,
    required this.onPriceRangeChanged,
    required this.category,
    required this.sortBy,
    required this.priceRange,
  });

  @override
  // ignore: library_private_types_in_public_api
  _FilterAndSortWidgetState createState() => _FilterAndSortWidgetState();
}

class _FilterAndSortWidgetState extends State<FilterAndSortWidget> {
  late RangeValues _currentPriceRange;
  late String _sortBy;

  @override
  void initState() {
    super.initState();
    _currentPriceRange = widget.priceRange;
    _sortBy = widget.sortBy;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Filter and Sort', style: h5.copyWith(color: black)),
                IconButton(
                  icon: Icon(CupertinoIcons.xmark, color: red5),
                  onPressed: widget.onCancel,
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text('Applied filters:', style: tFilter.copyWith(color: black)),
            const SizedBox(height: 12),
            (_currentPriceRange == const RangeValues(0, 560) &&
                    _sortBy == 'Alphabetical')
                ? Text('No filters.', style: tParagraph.copyWith(color: grey8))
                : Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: _buildAppliedFilters(),
                  ),
            const SizedBox(height: 24),
            Text('Sort by', style: tFilter.copyWith(color: black)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildSortButton('Alphabetical'),
                _buildSortButton('Ascending Price'),
                _buildSortButton('Descending Price'),
                _buildSortButton('Rating'),
                _buildSortButton('Most Popular'),
              ],
            ),
            const SizedBox(height: 24),
            Text('Price range', style: tFilter.copyWith(color: black)),
            const SizedBox(height: 12),
            Center(
                child: Text(
                    '${_currentPriceRange.start.round()} - ${_currentPriceRange.end.round()} RON',
                    style: tParagraph.copyWith(color: black))),
            const SizedBox(height: 12),
            SliderTheme(
              data: SliderThemeData(
                trackHeight: 4,
                trackShape: const RoundedRectSliderTrackShape(),
                activeTrackColor: blue4,
                inactiveTrackColor: pink3,
                thumbColor: blue4,
                overlayColor: blue4ltrans,
                activeTickMarkColor: blue4,
                inactiveTickMarkColor: pink3,
              ),
              child: RangeSlider(
                values: _currentPriceRange,
                min: 0,
                max: 560,
                divisions: 112,
                onChanged: (values) {
                  setState(() {
                    _currentPriceRange = values;
                  });
                  widget.onPriceRangeChanged(values);
                },
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                SizedBox(
                    width: context.width / 2 - 16 - 6,
                    child: ButtonType(
                        text: 'Apply changes',
                        color: blue7,
                        type: 'primary',
                        onPressed: widget.onApply)),
                const SizedBox(
                  width: 12,
                ),
                SizedBox(
                    width: context.width / 2 - 16 - 6,
                    child: ButtonType(
                        text: 'Cancel',
                        color: red5,
                        type: 'secondary',
                        onPressed: widget.onCancel))
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildAppliedFilters() {
    List<Widget> filters = [];
    if (_sortBy.isNotEmpty) {
      filters.add(_buildFilterChip(_sortBy, () {
        setState(() {
          _sortBy = '';
        });
        widget.onSortByChanged('');
      }));
    }
    filters.add(_buildFilterChip(
        '${_currentPriceRange.start.round()} - ${_currentPriceRange.end.round()} RON',
        () {
      setState(() {
        _currentPriceRange = const RangeValues(0, 560);
      });
      widget.onPriceRangeChanged(_currentPriceRange);
    }));
    return filters;
  }

  Widget _buildFilterChip(String label, VoidCallback onDeleted) {
    return Chip(
      label: Text(label, style: tParagraph.copyWith(color: grey8)),
      shape: RoundedRectangleBorder(
          side: BorderSide(color: grey8, width: 2),
          borderRadius: BorderRadius.circular(8)),
      onDeleted: onDeleted,
      deleteIcon: Icon(CupertinoIcons.xmark, color: grey8, size: 24),
      backgroundColor: grey1,
    );
  }

  Widget _buildSortButton(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: _sortBy == title ? grey1 : white1,
        border: Border.all(color: grey8, width: 2),
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          minimumSize: Size.zero,
          padding: EdgeInsets.zero,
          overlayColor: const Color.fromARGB(0, 255, 255, 255),
        ),
        onPressed: () {
          setState(() {
            _sortBy = title;
          });
          widget.onSortByChanged(title);
        },
        child: Text(title, style: tParagraph.copyWith(color: grey8)),
      ),
    );
  }
}
