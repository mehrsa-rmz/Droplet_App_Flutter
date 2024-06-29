import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/features/appointments/controllers/specialist_controller.dart';
import 'package:flutter_application/features/appointments/controllers/specialist_review_controller.dart';
import 'package:flutter_application/features/appointments/models/specialist_model.dart';
import 'package:flutter_application/features/appointments/models/specialist_review_model.dart';
import 'package:flutter_application/features/appointments/screens/new_appointment/new_appointments_pick_time.dart';
import 'package:flutter_application/features/appointments/screens/new_appointment/new_appointments_specialist_reviews.dart';
import 'package:flutter_application/features/profile/models/user_model.dart';
import 'package:flutter_application/utils/constants/asset_strings.dart';
import 'package:flutter_application/common/widgets/buttons.dart';
import 'package:flutter_application/utils/constants/colors.dart';
import 'package:flutter_application/utils/constants/text_styles.dart';
import 'package:flutter_application/common/widgets/inputs.dart';
import 'package:flutter_application/common/widgets/navbar.dart';
import 'package:get/get.dart';

class NewAppointmentsPickSpecialistScreen extends StatefulWidget {
  const NewAppointmentsPickSpecialistScreen({super.key, required this.location});

  final String location;

  @override
  State<NewAppointmentsPickSpecialistScreen> createState() =>
      _NewAppointmentsPickSpecialistScreenState();
}

class _NewAppointmentsPickSpecialistScreenState extends State<NewAppointmentsPickSpecialistScreen> {
  final TextEditingController _searchController = TextEditingController();

  User? user = FirebaseAuth.instance.currentUser;
  UserModel? userModel;

  List<Map<String, dynamic>> allSpecialists = [];
  List<Map<String, dynamic>> _filteredSpecialists = [];

  TextEditingController locationController = TextEditingController();


  @override
  void initState() {
    super.initState();
    fetchSpecialistsData().then((_) {
      setState(() {
        _filterSpecialists();
      });
    });
    _searchController.addListener(_filterSpecialists);
  }

  Future<void> fetchSpecialistsData() async {
    List<SpecialistModel> specialistModels = await SpecialistController.instance.fetchAllSpecialists();
    List<SpecialistReviewModel> specialistReviews = await SpecialistReviewController.instance.fetchAllSpecialistsReviews();

    // Creating a map for specialist reviews
    Map<String, List<SpecialistReviewModel>> specialistReviewMap = {};
    for (var sr in specialistReviews) {
      if (!specialistReviewMap.containsKey(sr.specialistId)) {
        specialistReviewMap[sr.specialistId] = [];
      }
      specialistReviewMap[sr.specialistId]!.add(sr);
    }

    // Combining the data into the desired structure
    allSpecialists = specialistModels.map((specialist) {
      String specialistId = specialist.id;

      // Calculating reviews
      List<SpecialistReviewModel> reviews = specialistReviewMap[specialistId] ?? [];
      double rating = reviews.isNotEmpty
          ? reviews.map((r) => r.rating).reduce((a, b) => a + b) / reviews.length
          : 0.0;

      return {
        'id': specialistId,
        'name': specialist.name,
        'position': specialist.title,
        'rating': rating,
        'years': specialist.noYearsExperience,
        'location': specialist.location,
        'image': specialist2,
      };
    }).toList();

    _filteredSpecialists = allSpecialists;
  }

  void _filterSpecialists(){
    setState(() {
      _filteredSpecialists = allSpecialists.where((specialist) {
        bool matchesLocation =
            widget.location == 'online' ? true : specialist['location'] == widget.location;
        bool matchesSearch = specialist['name']
            .toLowerCase()
            .contains(_searchController.text.toLowerCase());
        
        return matchesLocation &&matchesSearch;
      }).toList();
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
                                        id: specialist['id'],
                                        name: specialist['name'],
                                        position: specialist['position'],
                                        rating: specialist['rating'],
                                        years: specialist['years'],
                                        location: specialist['location'],
                                        givenLocation: widget.location,
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
    required this.id,
    required this.name,
    required this.position,
    required this.rating,
    required this.years,
    required this.location,
    required this.givenLocation,
    required this.image,
  });

  final String id;
  final String name;
  final String position;
  final double rating;
  final int years;
  final String location;
  final String givenLocation;
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
                    onPressed: () => Get.to(() => NewAppointmentsReviewsScreen(specialistId: id)))),
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
                    onPressed: () => Get.to(() => NewAppointmentsPickTimeScreen(specialistId: id, location: givenLocation,))))
              ],
            )
          ],
        ));
  }
}
