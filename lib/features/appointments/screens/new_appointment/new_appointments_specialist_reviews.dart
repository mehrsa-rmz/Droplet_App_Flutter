import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/utils/constants/asset_strings.dart';
import 'package:flutter_application/utils/constants/colors.dart';
import 'package:flutter_application/utils/constants/text_styles.dart';
import 'package:flutter_application/common/widgets/navbar.dart';
import 'package:get/get.dart';

class NewAppointmentsReviewsScreen extends StatefulWidget {
  const NewAppointmentsReviewsScreen({super.key});

  @override
  State<NewAppointmentsReviewsScreen> createState() =>
      _NewAppointmentsReviewsScreenState();
}

class _NewAppointmentsReviewsScreenState
    extends State<NewAppointmentsReviewsScreen> {
  double value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(selectedOption: 'explore',),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bkg1),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(bkg1),
                    fit: BoxFit.cover,
                  ),
                  border: Border(
                    bottom: BorderSide(color: Color(0xFFB23A48), width: 3),
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
                        Text('Reviews', style: h4.copyWith(color: red5)),
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
                        const SpecialistBox(
                            name: 'Pop Laura',
                            position: 'Dermatology Specialist',
                            rating: 4.85,
                            years: 4,
                            location: 'Droplet - Afi Palace Mall',
                            image: specialist1),
                        const SizedBox(height: 24),
                        Container(
                          width: context.width,
                          decoration: BoxDecoration(
                              border: Border(
                            bottom: BorderSide(color: blue7, width: 2),
                          )),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Reviews',
                                  style: tButton.copyWith(color: blue7)),
                              const SizedBox(height: 8)
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        const ReviewBox(
                            name: 'Ana G.',
                            rating: 3.5,
                            date: 'February 26th 2024',
                            review:
                                'This is a general review message to fill this space.'),
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

class SpecialistBox extends StatelessWidget {
  const SpecialistBox({
    super.key,
    required this.name,
    required this.position,
    required this.rating,
    required this.years,
    required this.location,
    required this.image,
  });

  final String name;
  final String position;
  final double rating;
  final int years;
  final String location;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: red4,
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(children: [
              Container(
                  height: 48,
                  width: 48,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: Image.asset(image, fit: BoxFit.fill)),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: tMenu.copyWith(color: white1)),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(position, style: tParagraph.copyWith(color: grey1))
                ],
              )
            ]),
            const SizedBox(height: 20),
            SizedBox(
              width: context.width - 40 - 32,
              child: Row(
                children: [
                  Text(
                    'Rating:',
                    style: tParagraph.copyWith(color: white1),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '$rating',
                    style: tParagraphMed.copyWith(color: grey1),
                  ),
                  const SizedBox(width: 4),
                  Icon(CupertinoIcons.star_fill, color: grey1, size: 20)
                ],
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: context.width - 40 - 32,
              child: Row(
                children: [
                  Text(
                    'Years of experience:',
                    style: tParagraph.copyWith(color: white1),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '$years years',
                    style: tParagraphMed.copyWith(color: grey1),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: context.width - 40 - 32,
              child: Row(
                children: [
                  Text(
                    'Location:',
                    style: tParagraph.copyWith(color: white1),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    location,
                    style: tParagraphMed.copyWith(color: grey1),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
