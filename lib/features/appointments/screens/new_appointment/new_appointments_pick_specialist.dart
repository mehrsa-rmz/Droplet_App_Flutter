import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/features/appointments/screens/new_appointment/new_appointments_pick_type.dart';
import 'package:flutter_application/features/appointments/screens/new_appointment/new_appointments_specialist_reviews.dart';
import 'package:flutter_application/utils/constants/asset_strings.dart';
import 'package:flutter_application/common/widgets/buttons.dart';
import 'package:flutter_application/utils/constants/colors.dart';
import 'package:flutter_application/utils/constants/text_styles.dart';
import 'package:flutter_application/common/widgets/inputs.dart';
import 'package:flutter_application/common/widgets/navbar.dart';
import 'package:get/get.dart';

class NewAppointmentsPickSpecialistScreen extends StatefulWidget {
  const NewAppointmentsPickSpecialistScreen({super.key});

  @override
  State<NewAppointmentsPickSpecialistScreen> createState() =>
      _NewAppointmentsPickSpecialistScreenState();
}

class _NewAppointmentsPickSpecialistScreenState
    extends State<NewAppointmentsPickSpecialistScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, dynamic>> _specialists = [
    {
      'name': 'Pop Laura',
      'position': 'Dermatology Specialist',
      'rating': 4.85,
      'years': 4,
      'location': 'Droplet - Afi Palace Mall',
      'image': specialist1
    },
    {
      'name': 'Moise Andreea',
      'position': 'Dermatology Specialist',
      'rating': 4.65,
      'years': 2,
      'location': 'Droplet - Mega Mall',
      'image': specialist2
    },
    {
      'name': 'Ionescu Ana',
      'position': 'Dermatology Specialist',
      'rating': 4.90,
      'years': 7,
      'location': 'Droplet - ParkLake Mall',
      'image': specialist3
    },
  ];
  late List<Map<String, dynamic>> _filteredSpecialists;

  @override
  void initState() {
    super.initState();
    _filteredSpecialists = _specialists;
    _searchController.addListener(_filterSpecialists);
  }

  void _filterSpecialists() {
    setState(() {
      _filteredSpecialists = _specialists
          .where((specialist) => specialist['name']
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterSpecialists);
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
                        Text('New appointment',
                            style: h4.copyWith(color: red5)),
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
                        Container(
                          width: context.width,
                          decoration: BoxDecoration(
                              border: Border(
                            bottom: BorderSide(color: blue7, width: 2),
                          )),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Now pick a specialist',
                                  style: tButton.copyWith(color: blue7)),
                              const SizedBox(height: 8)
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        MySearchBar(searchController: _searchController),
                        const SizedBox(height: 20),
                        _filteredSpecialists.isEmpty
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
                                child: Text('No specialists found',
                                    style: tButton.copyWith(color: black)))
                            : Column(children: <Widget>[
                                for (var specialist in _filteredSpecialists)
                                  Column(
                                    children: [
                                      SpecialistBox(
                                          name: specialist['name'],
                                          position: specialist['position'],
                                          rating: specialist['rating'],
                                          years: specialist['years'],
                                          location: specialist['location'],
                                          image: specialist['image']),
                                      const SizedBox(height: 20)
                                    ],
                                  )
                              ]),
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
                  Text(name, style: tMenu.copyWith(color: black)),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(position, style: tParagraph.copyWith(color: grey8))
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
                    style: tParagraph.copyWith(color: black),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '$rating',
                    style: tParagraphMed.copyWith(color: grey8),
                  ),
                  const SizedBox(width: 4),
                  Icon(CupertinoIcons.star_fill, color: grey8, size: 20)
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
                    style: tParagraph.copyWith(color: black),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '$years years',
                    style: tParagraphMed.copyWith(color: grey8),
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
                    style: tParagraph.copyWith(color: black),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    location,
                    style: tParagraphMed.copyWith(color: grey8),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                    width: context.width / 2 - 6 - 20 - 16,
                    child: ButtonTypeIcon(
                        icon: CupertinoIcons.star,
                        text: 'Reviews',
                        color: pink5,
                        type: "primary",
                        onPressed: () => Get.to(() => const NewAppointmentsReviewsScreen()))),
                const SizedBox(
                  width: 12,
                ),
                SizedBox(
                    width: context.width / 2 - 6 - 20 - 16,
                    child: ButtonTypeIcon(
                        icon: CupertinoIcons.chevron_right,
                        text: 'Next step',
                        color: blue7,
                        type: "primary",
                        onPressed: () => Get.to(() => const NewAppointmentsPickTypeScreen())))
              ],
            )
          ],
        ));
  }
}
