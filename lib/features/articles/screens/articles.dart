import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/features/articles/screens/opened_article.dart';
import 'package:flutter_application/utils/constants/asset_strings.dart';
import 'package:flutter_application/utils/constants/colors.dart';
import 'package:flutter_application/utils/constants/text_styles.dart';
import 'package:flutter_application/common/widgets/inputs.dart';
import 'package:flutter_application/common/widgets/navbar.dart';
import 'package:get/get.dart';

class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({super.key});

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, dynamic>> _articles = [
    {'id': 1, 'title': 'Thinning hair', 'color': pink6},
    {'id': 2, 'title': 'Sensitive skin', 'color': red6},
    {'id': 3, 'title': 'New Mothers', 'color': blue7},
    {'id': 4, 'title': 'Acne scars', 'color': pink6},
    {'id': 5, 'title': 'About SPF', 'color': red6},
    {'id': 6, 'title': 'Getting rid of Dandruff', 'color': blue7},
  ];
  late List<Map<String, dynamic>> _filteredArticles;

  @override
  void initState() {
    super.initState();
    _filteredArticles = _articles;
    _searchController.addListener(_filterArticles);
  }

  void _filterArticles() {
    setState(() {
      _filteredArticles = _articles
          .where((article) => article['title']
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterArticles);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const BottomNavBar(selectedOption: 'explore',),
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(bkg4),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
                child: Column(children: [
              Container(
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage(bkg4),
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
                        Text('Advice', style: h4.copyWith(color: blue7)),
                        const SizedBox(width: 32),
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
                          const SizedBox(height: 32),
                          MySearchBar(searchController: _searchController),
                          const SizedBox(height: 32),
                          _filteredArticles.isEmpty
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
                                            8),
                                      )
                                    ],
                                  ),
                                  child: Text('No articles found',
                                      style: tButton.copyWith(color: black)))
                              : Column(children: <Widget>[
                                  for (var article in _filteredArticles)
                                    Column(
                                      children: [
                                        ArticleButton(
                                            id: article['id'],
                                            title: article['title'],
                                            color: article['color']),
                                        const SizedBox(height: 32)
                                      ],
                                    )
                                ]),
                        ],
                      ),
                    ]),
              ),
            ]))));
  }
}

class ArticleButton extends StatelessWidget {
  const ArticleButton({super.key, required this.id, required this.title, required this.color});

  final int id;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(191, 255, 249, 245),
        border: Border.all(color: color, width: 1),
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x59223944),
            spreadRadius: 0,
            blurRadius: 30,
            offset: Offset(0, 8), 
          ),
        ],
      ),
      child: TextButton(
          style: TextButton.styleFrom(
            minimumSize: Size.zero,
            overlayColor: const Color.fromARGB(0, 255, 255, 255),
          ),
          child: Row(
            children: [
              SizedBox(
                  width: context.width - 32 - 24 - 24 - 2,
                  child: Text(title, style: tMenu.copyWith(color: color))),
              Icon(CupertinoIcons.chevron_right, color: color, size: 24)
            ],
          ),
          onPressed:  () => Get.to(() => OpenedArticleScreen(id: id)),
      )
    );
  }
}
