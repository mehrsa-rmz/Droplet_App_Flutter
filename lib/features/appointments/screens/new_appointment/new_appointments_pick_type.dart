import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/features/appointments/controllers/specialist_controller.dart';
import 'package:flutter_application/features/appointments/controllers/specialist_review_controller.dart';
import 'package:flutter_application/features/appointments/models/specialist_model.dart';
import 'package:flutter_application/features/appointments/models/specialist_review_model.dart';
import 'package:flutter_application/features/appointments/screens/new_appointment/new_appointments_pick_time.dart';
import 'package:flutter_application/utils/constants/asset_strings.dart';
import 'package:flutter_application/common/widgets/buttons.dart';
import 'package:flutter_application/utils/constants/colors.dart';
import 'package:flutter_application/utils/constants/text_styles.dart';
import 'package:flutter_application/common/widgets/navbar.dart';
import 'package:get/get.dart';

class NewAppointmentsPickTypeScreen extends StatefulWidget {
  const NewAppointmentsPickTypeScreen({super.key, required this.specialistId});

  final String specialistId;

  @override
  State<NewAppointmentsPickTypeScreen> createState() => _NewAppointmentsPickTypeScreenState();
}

class _NewAppointmentsPickTypeScreenState extends State<NewAppointmentsPickTypeScreen> {
  SpecialistModel? specialistModel;
  Map<String, dynamic> currentSpecialist = {
    'id': '',
    'name': '',
    'position': '',
    'rating': 0.0,
    'years': 0,
    'location': '',
    'image': specialist2,
  };

  @override
  void initState() {
    super.initState();
    fetchSpecialistData().then((_) {setState(() {});});
  }

  Future<void> fetchSpecialistData() async {
    List<SpecialistReviewModel> specialistReviews = await SpecialistReviewController.instance.fetchSpecialistReviews(widget.specialistId);
    SpecialistModel? thisSpecialist = await SpecialistController.instance.getSpecialistById(widget.specialistId);

    // Calculating reviews
    double rating = 0.0;
    for (var sr in specialistReviews) {
      rating += sr.rating;
    }
    rating /= specialistReviews.length;

      currentSpecialist = {
        'id': widget.specialistId,
        'name': thisSpecialist?.name ?? '',
        'position': thisSpecialist?.title ?? '',
        'rating': rating,
        'years': thisSpecialist?.noYearsExperience ?? 0,
        'location': thisSpecialist?.location ?? '',
        'image': specialist2,
      };
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
                        SpecialistBox(
                          name: currentSpecialist['name'],
                          position: currentSpecialist['position'],
                          rating: currentSpecialist['rating'],
                          years: currentSpecialist['years'],
                          location: currentSpecialist['location'],
                          image: currentSpecialist['image']),
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
                              Text('Now pick the type of appointment',
                                  style: tButton.copyWith(color: blue7)),
                              const SizedBox(height: 8)
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        ButtonTypeIcon(
                            text: 'Online consultation',
                            icon: CupertinoIcons.chevron_right,
                            color: blue7,
                            type: 'primary',
                            onPressed: () => Get.to(() => NewAppointmentsPickTimeScreen(specialistId: widget.specialistId, location: currentSpecialist['location']))),
                        const SizedBox(height: 20),
                        ButtonTypeIcon(
                            text: 'On-site consultation',
                            icon: CupertinoIcons.chevron_right,
                            color: blue7,
                            type: 'primary',
                            onPressed: () => Get.to(() => NewAppointmentsPickTimeScreen(specialistId: widget.specialistId, location: 'online')))
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
          color: red4,
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
