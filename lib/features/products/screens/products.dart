import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/utils/constants/asset_strings.dart';
import 'package:flutter_application/utils/constants/text_styles.dart';
import 'package:flutter_application/utils/constants/colors.dart';
import 'package:flutter_application/common/widgets/buttons.dart';
import 'package:flutter_application/common/widgets/inputs.dart';
import 'package:flutter_application/common/widgets/navbar.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ProductsScreen extends StatefulWidget {
  String category;

  ProductsScreen({
    super.key,
    this.category = 'all',
  });
  
  @override
  State<StatefulWidget> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
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
  // ignore: unused_field
  late List<Map<String, dynamic>> _filteredProducts;
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
    _filteredProducts = _products.where((product) {
        bool matchesCategory =
            widget.category == 'all' ? true : product['category'] == widget.category;
        return matchesCategory;
      }).toList();
    _searchController.addListener(_filterProducts);
  }

  void _filterProducts() {
    setState(() {
      _filteredProducts = _products.where((product) {
        bool matchesCategory =
            widget.category == 'all' ? true : product['category'] == widget.category;
        bool matchesSex = sex == 'all'
            ? true
            : product['sex'] == sex || product['sex'] == 'all';
        bool matchesAge = age == 'all'
            ? true
            : product['age'] == age || product['age'] == 'all';
        bool matchesConditions = conditions.isEmpty ||
            conditions
                .any((condition) => product['conditions'].contains(condition));
        bool matchesIngredients = ingredients.isEmpty ||
            ingredients.any(
                (ingredient) => product['ingredients'].contains(ingredient));
        bool matchesHypoallergenic =
            !hypoallergenic || (hypoallergenic && product['hypoallergenic']);
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
            matchesHypoallergenic &&
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
    final originalConditions = List<String>.from(conditions);

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
              conditions = originalConditions;
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
          onTypeChanged: (value) {
            setState(() {
              conditions = value;
            });
          },
          category: widget.category,
          appliedTypes: conditions,
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
        bottomNavigationBar: const BottomNavBar(selectedOption: 'products',),
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
                child: ListView(
                    controller: scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        MySearchBar(searchController: _searchController),
                        const SizedBox(height: 32),
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: red5, width: 2)),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  genderToggleButton(
                                      "All",
                                      sex == 'all',
                                      () => setState(() {
                                            sex = 'all';
                                            _filterProducts();
                                          })),
                                  const SizedBox(width: 16),
                                  genderToggleButton(
                                      "Women",
                                      sex == 'f',
                                      () => setState(() {
                                            sex = 'f';
                                            _filterProducts();
                                          })),
                                  const SizedBox(width: 16),
                                  genderToggleButton(
                                      "Men",
                                      sex == 'm',
                                      () => setState(() {
                                            sex = 'm';
                                            _filterProducts();
                                          })),
                                ],
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            categoryToggleButton(
                                'All',
                                widget.category == 'all',
                                () => setState(() {
                                      widget.category = 'all';
                                      _filterProducts();
                                    })),
                            const SizedBox(width: 12),
                            categoryToggleButton(
                                'Skincare',
                                widget.category == 'skin',
                                () => setState(() {
                                      widget.category = 'skin';
                                      _filterProducts();
                                    })),
                            const SizedBox(width: 12),
                            categoryToggleButton(
                                'Haircare',
                                widget.category == 'hair',
                                () => setState(() {
                                      widget.category = 'hair';
                                      _filterProducts();
                                    })),
                            const SizedBox(width: 12),
                            categoryToggleButton(
                                'Body',
                                widget.category == 'body',
                                () => setState(() {
                                      widget.category = 'body';
                                      _filterProducts();
                                    })),
                            const SizedBox(width: 12),
                            categoryToggleButton(
                                'Perfume',
                                widget.category == 'perfume',
                                () => setState(() {
                                      widget.category = 'perfume';
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
                ]))));
  }
}

Widget genderToggleButton(
    String title, bool isSelected, VoidCallback onPressed) {
  return Container(
    padding: isSelected
        ? const EdgeInsets.symmetric(horizontal: 3)
        : const EdgeInsets.all(0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: isSelected ? red5 : Colors.transparent,
    ),
    child: TextButton(
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        overlayColor: const Color.fromARGB(0, 255, 255, 255),
      ),
      onPressed: onPressed,
      child:
          Text(title, style: tMenu.copyWith(color: isSelected ? white1 : red5)),
    ),
  );
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

class FilterAndSortWidget extends StatefulWidget {
  final VoidCallback onApply;
  final VoidCallback onCancel;
  final ValueChanged<String> onSortByChanged;
  final ValueChanged<RangeValues> onPriceRangeChanged;
  final ValueChanged<List<String>> onTypeChanged;
  final String category;
  final List<String> appliedTypes;
  final String sortBy;
  final RangeValues priceRange;

  const FilterAndSortWidget({
    super.key,
    required this.onApply,
    required this.onCancel,
    required this.onSortByChanged,
    required this.onPriceRangeChanged,
    required this.onTypeChanged,
    required this.category,
    required this.appliedTypes,
    required this.sortBy,
    required this.priceRange,
  });

  @override
  // ignore: library_private_types_in_public_api
  _FilterAndSortWidgetState createState() => _FilterAndSortWidgetState();
}

class _FilterAndSortWidgetState extends State<FilterAndSortWidget> {
  late RangeValues _currentPriceRange;
  late List<String> _selectedTypes;
  late String _sortBy;

  @override
  void initState() {
    super.initState();
    _currentPriceRange = widget.priceRange;
    _selectedTypes = List.from(widget.appliedTypes);
    _sortBy = widget.sortBy;
  }

  List<String> getTypeOptions() {
    switch (widget.category) {
      case 'skin':
        return ['Dry', 'Oily', 'Acnee Prone', 'Combination', 'Sensitive'];
      case 'hair':
        return [
          'Dry',
          'Oily',
          'Dyed',
          'Dandruff',
          'Thin',
          'Thick',
          'Frizzy',
          'Straight',
          'Wavy',
          'Curly',
          'Coily'
        ];
      case 'body':
        return ['Dry', 'Acnee Prone', 'Scars', 'Sensitive'];
      case 'perfume':
        return [
          'Sweet',
          'Floral',
          'Fruity',
          'Musky',
          'Woody',
          'Spiced',
          'Fresh',
          'Oriental'
        ];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> typeOptions = getTypeOptions();

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
            (_selectedTypes.isEmpty &&
                    _currentPriceRange == const RangeValues(0, 560) &&
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
            if (widget.category != 'all')
              Text('${widget.category.capitalizeFirst} type',
                  style: tFilter.copyWith(color: black)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children:
                  typeOptions.map((type) => _buildTypeButton(type)).toList(),
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
    filters.addAll(_selectedTypes.map((type) => _buildFilterChip(type, () {
          setState(() {
            _selectedTypes.remove(type);
          });
          widget.onTypeChanged(_selectedTypes);
        })));
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

  Widget _buildTypeButton(String title) {
    bool isSelected = _selectedTypes.contains(title);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isSelected ? grey1 : white1,
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
            if (isSelected) {
              _selectedTypes.remove(title);
            } else {
              _selectedTypes.add(title);
            }
            widget.onTypeChanged(_selectedTypes);
          });
        },
        child: Text(title, style: tParagraph.copyWith(color: grey8)),
      ),
    );
  }
}
