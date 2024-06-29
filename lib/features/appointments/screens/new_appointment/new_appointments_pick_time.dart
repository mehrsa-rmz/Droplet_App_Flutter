import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/data/repositories/appointments_repository.dart';
import 'package:flutter_application/features/appointments/controllers/specialist_controller.dart';
import 'package:flutter_application/features/appointments/controllers/specialist_review_controller.dart';
import 'package:flutter_application/features/appointments/models/appointment_model.dart';
import 'package:flutter_application/features/appointments/models/specialist_model.dart';
import 'package:flutter_application/features/appointments/models/specialist_review_model.dart';
import 'package:flutter_application/features/appointments/screens/appointments_history.dart';
import 'package:flutter_application/features/appointments/screens/new_appointment/new_appointments_success.dart';
import 'package:flutter_application/utils/constants/asset_strings.dart';
import 'package:flutter_application/common/widgets/buttons.dart';
import 'package:flutter_application/utils/constants/colors.dart';
import 'package:flutter_application/utils/constants/text_styles.dart';
import 'package:flutter_application/common/widgets/inputs.dart';
import 'package:flutter_application/common/widgets/navbar.dart';
import 'package:flutter_application/utils/popups/loaders.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NewAppointmentsPickTimeScreen extends StatefulWidget {
  const NewAppointmentsPickTimeScreen({super.key, required this.specialistId, required this.location});

  final String specialistId;
  final String location;

  @override
  State<NewAppointmentsPickTimeScreen> createState() => _NewAppointmentsPickTimeScreenState();
}

class _NewAppointmentsPickTimeScreenState extends State<NewAppointmentsPickTimeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

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

  List<DropdownMenuEntry> timeSlots = [
    const DropdownMenuEntry(value: 0, label: '12:00'), 
    //const DropdownMenuEntry(value: 1, label: '12:30'), 
    const DropdownMenuEntry(value: 2, label: '13:00'), 
    //const DropdownMenuEntry(value: 3, label: '13:30'), 
    const DropdownMenuEntry(value: 4, label: '14:00'), 
    //const DropdownMenuEntry(value: 5, label: '14:30'), 
    const DropdownMenuEntry(value: 6, label: '15:00'), 
    //const DropdownMenuEntry(value: 7, label: '15:30'), 
    const DropdownMenuEntry(value: 8, label: '16:00'), 
    //const DropdownMenuEntry(value: 9, label: '16:30'), 
    const DropdownMenuEntry(value: 10, label: '17:00'), 
    //const DropdownMenuEntry(value: 11, label: '17:30'), 
    const DropdownMenuEntry(value: 12, label: '18:00')
  ];

  @override
  void initState() {
    super.initState();
    //fetchAvailableTimeslots(dateController.text);
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

  // Future<void> fetchAvailableTimeslots(String date) async {
  //   if (date.isNotEmpty) {
  //     DateTime datePicked = DateFormat('dd-MM-yyyy').parse(date);
  //     List<String> availableTimes = await AppointmentRepository.instance.fetchAvailableTimeslots(datePicked, widget.specialistId);
  //     setState(() {
  //       timeSlots = availableTimes.map((time) => DropdownMenuEntry(value: time, label: time)).toList();
  //     });
  //   }
  // }

  Future<void> createAppointment(String date, String time) async {
    print('Here');
    String dateTimeString = '$date $time';
    print('dateTimeString: $dateTimeString');
    DateTime dateTime = DateFormat('dd-MM-yyyy HH:mm').parse(dateTimeString);
    dateTimeString = DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
    print('dateTimeString: $dateTimeString');

    if (user != null) {
      print('Here 2');
      String userId = user!.uid;
      AppointmentModel newApp = AppointmentModel(id: 'APP_${widget.specialistId}_${userId}_$dateTimeString', userId: userId, specialistId: widget.specialistId, dateTime: dateTimeString, location: widget.location);
      print('newapp: ${newApp.dateTime} ${newApp.location} ${newApp.userId} ${newApp.specialistId}');
      await AppointmentRepository.instance.saveAppointmentRecord(newApp);
    }
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
                              Text('Now pick an available timeframe',
                                  style: tButton.copyWith(color: blue7)),
                              const SizedBox(height: 8)
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        InputType(
                          controller: dateController,
                          calendarStart: DateTime.now(),
                          calendarEnd: DateTime(2026),
                          type: 'calendar',
                          inputType: TextInputType.text,
                          placeholder: 'Day',
                          mustBeFilled: true,
                          // onChanged: (value) async {
                          //   await fetchAvailableTimeslots(value);
                          //   setState(() {});
                          // },
                        ),
                        const SizedBox(height: 20),
                        InputType(
                          controller: timeController,
                          type: 'dropdown',
                          inputType: TextInputType.text,
                          placeholder: 'Time',
                          mustBeFilled: true,
                          dropdownWidth: context.width - 32,
                          dropdownList: timeSlots
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            SizedBox(
                              width: context.width / 2 - 6 - 16,
                              child: ButtonType(
                                text: 'Book',
                                color: blue7,
                                type: 'primary',
                                onPressed: () async => {
                                  if(dateController.text != '' && timeController.text != '') {
                                    await createAppointment(dateController.text, timeController.text),
                                    Get.to(() => const NewAppointmentsSuccessScreen()),
                                  } else {
                                    TLoaders.errorSnackBar(title: 'Error', message: 'Must pick date and time.')
                                  }
                                }
                              )
                            ),
                            const SizedBox(width: 12),
                            SizedBox(
                              width: context.width / 2 - 6 - 16,
                              child: ButtonType(
                                text: 'Cancel',
                                color: red5,
                                type: 'secondary',
                                onPressed: () => showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        insetPadding: const EdgeInsets.all(16),
                                        backgroundColor: white1,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        shadowColor: blue7dtrans,
                                        title: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
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
                                                child: Text('Warning',
                                                    textAlign: TextAlign.center,
                                                    style: h5.copyWith(
                                                        color: black))),
                                            const SizedBox(
                                              height: 24,
                                            ),
                                            Text(
                                                'Are you sure you want to cancel the process?',
                                                style: tParagraph.copyWith(
                                                    color: grey8)),
                                            const SizedBox(height: 24),
                                            Row(children: [
                                              SizedBox(
                                                  width: context.width / 2 - 6 - 40,
                                                  child: ButtonType(
                                                      text: 'Yes, cancel',
                                                      color: red5,
                                                      type: "primary",
                                                      onPressed: () => Get.offAll(() => const AppointmentsHistoryScreen()))),
                                              const SizedBox(width: 12),
                                              SizedBox(
                                                  width: context.width / 2 - 6 - 40,
                                                  child: ButtonType(
                                                      text: 'No, keep',
                                                      color: blue7,
                                                      type: "secondary",
                                                      onPressed: () => Navigator.of(context).pop()))
                                            ]),
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                            )
                          ],
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
