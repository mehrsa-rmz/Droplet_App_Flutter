import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/utils/constants/colors.dart';
import 'package:flutter_application/utils/constants/text_styles.dart';
import 'package:flutter_application/utils/constants/asset_strings.dart';
import 'package:flutter_application/common/widgets/inputs.dart';
import 'package:flutter_application/common/widgets/navbar.dart';
import 'package:get/get.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, dynamic>> _products = [
    {
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
      'category': 'hair',
      'sex': 'f',
      'age': 'all',
      'conditions': ['thin hair', 'dandruff'],
      'hypoallergenic': false,
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
      'category': 'hair',
      'sex': 'f',
      'age': 'all',
      'conditions': ['curly', 'dry', 'dandruff'],
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

  late List<Map<String, dynamic>> _filteredProducts;
  String category = 'all';

  @override
  void initState() {
    super.initState();
    _filteredProducts = _products.where((product) {
      bool isFavorite = product['favorite'];
      return isFavorite;
    }).toList();
    _searchController.addListener(_filterProducts);
  }

  void _filterProducts() {
    setState(() {
      _filteredProducts = _products.where((product) {
        bool matchesCategory =
            category == 'all' ? true : product['category'] == category;
        bool isFavorite = product['favorite'];
        bool matchesSearch = product['name']
            .toLowerCase()
            .contains(_searchController.text.toLowerCase());

        return matchesCategory && isFavorite && matchesSearch;
      }).toList();
    });
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
        bottomNavigationBar: const BottomNavBar(selectedOption: 'favorites',),
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
                    bottom: BorderSide(color: red5, width: 3),
                  ),
                ),
                child: SizedBox(
                  width: context.width,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Text('Favorites', style: h4.copyWith(color: red5)),
                      const SizedBox(height: 12),
                    ],
                  ),
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
                                  category == 'skin',
                                  () => setState(() {
                                        category = 'skin';
                                        _filterProducts();
                                      })),
                              const SizedBox(width: 12),
                              categoryToggleButton(
                                  'Haircare',
                                  category == 'hair',
                                  () => setState(() {
                                        category = 'hair';
                                        _filterProducts();
                                      })),
                              const SizedBox(width: 12),
                              categoryToggleButton(
                                  'Body',
                                  category == 'body',
                                  () => setState(() {
                                        category = 'body';
                                        _filterProducts();
                                      })),
                              const SizedBox(width: 12),
                              categoryToggleButton(
                                  'Perfume',
                                  category == 'perfume',
                                  () => setState(() {
                                        category = 'perfume';
                                        _filterProducts();
                                      })),
                            ],
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
                                            () {},
                                            () => setState(() {
                                                  product['favorite'] =
                                                      !product['favorite'];
                                                })),
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
      border: isSelected ? Border.all(color: red5, width: 2) : null,
    ),
    child: TextButton(
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        overlayColor: const Color.fromARGB(0, 255, 255, 255),
      ),
      onPressed: onPressed,
      child: Text(title, style: tFilter.copyWith(color: red5)),
    ),
  );
}

Widget productBox(
    double width,
    String name,
    double price,
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
