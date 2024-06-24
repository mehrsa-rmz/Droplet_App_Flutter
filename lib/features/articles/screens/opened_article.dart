import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/utils/constants/asset_strings.dart';
import 'package:flutter_application/utils/constants/colors.dart';
import 'package:flutter_application/utils/constants/text_styles.dart';
import 'package:flutter_application/common/widgets/navbar.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class OpenedArticleScreen extends StatelessWidget {
  const OpenedArticleScreen({super.key, this.id});
  final int? id;

  @override
  Widget build(BuildContext context) {
    final articleId = id ?? 1;
    final List<Map<String, dynamic>> articles = [
      {'id': 1, 'title': 'Thinning hair', 'author': 'Pop Ana', 'date': 'Nov. 2023'},
      {'id': 2, 'title': 'Sensitive skin', 'author': 'Ionescu Maria', 'date': 'Dec. 2023'},
      {'id': 3, 'title': 'New Mothers', 'author': 'Doncu Alexandru', 'date': 'Jan. 2024'},
      {'id': 4, 'title': 'Acne scars', 'author': 'Rosu Florentina', 'date': 'Feb. 2024'},
      {'id': 5, 'title': 'About SPF', 'author': 'Popescu Denisa', 'date': 'Mar. 2024'},
      {'id': 6, 'title': 'Getting rid of Dandruff', 'author': 'Stoenescu Ema', 'date': 'Apr. 2024'},
    ];
    Map<String, dynamic> selectedArticle = articles.firstWhere(
      (article) => article['id'] == articleId,
      orElse: () => {'id': -1, 'title': 'Not Found', 'author': 'Unknown', 'date': 'N/A'}
    );
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
            image: AssetImage(bkg4),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
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
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 32),
                        Text(selectedArticle['title'],
                            style: h5.copyWith(color: black)),
                        const SizedBox(height: 8),
                        Text('Written by ${selectedArticle['author']}, ${selectedArticle['date']}',
                            style: tInput.copyWith(color: grey8)),
                        const SizedBox(height: 24),
                        Text(
                          'Lorem ipsum dolor sit amet consectetur. Non sit ut ut diam eget nec eu blandit. Orci scelerisque rutrum magna fringilla suspendisse rhoncus in imperdiet urna. Quam neque nulla malesuada tempus id nulla mi scelerisque ultrices. Enim integer volutpat consectetur libero eu ut augue. Vestibulum quisque consectetur fermentum senectus pulvinar mattis egestas.\n\nVel risus purus mattis est senectus id auctor elit. Vitae interdum nulla ullamcorper fermentum at volutpat. Tortor tincidunt hendrerit malesuada amet commodo. Mauris pretium pellentesque tempus duis non viverra. Pretium lectus sit mauris diam senectus nisl nunc eu. Nisi dignissim commodo faucibus consectetur. Nec lectus iaculis dictumst arcu eu molestie imperdiet. Faucibus facilisis risus cursus a suspendisse eros porttitor pharetra ut. Libero quam pellentesque tempor feugiat. Enim ut sapien ullamcorper cum placerat nisi.\n\nEt suscipit id fringilla aliquam diam. Tristique massa tempus tristique amet suspendisse id arcu suspendisse vestibulum. Leo adipiscing fusce arcu risus euismod. Mi nec mi sit quam. Fringilla netus vel dolor erat tincidunt senectus porta turpis orci. Orci purus sollicitudin in duis duis. Senectus maecenas a auctor tempor iaculis porta vel. Dolor fermentum tortor sem egestas feugiat malesuada hac. Non ac ullamcorper scelerisque ornare. Sit velit tellus egestas quis. Et viverra dictum lorem sit. Morbi fermentum non interdum et ut. Donec volutpat volutpat viverra tempor pellentesque blandit congue. Turpis proin nulla velit mauris tempus habitant etiam netus risus. Eleifend ultrices lobortis pellentesque scelerisque.',
                          style: tParagraph.copyWith(color: grey8),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
