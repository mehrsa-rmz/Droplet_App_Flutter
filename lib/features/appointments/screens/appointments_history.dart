import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/data/repositories/appointments_repository.dart';
import 'package:flutter_application/features/appointments/controllers/specialist_controller.dart';
import 'package:flutter_application/features/appointments/controllers/specialist_review_controller.dart';
import 'package:flutter_application/features/appointments/models/appointment_model.dart';
import 'package:flutter_application/features/appointments/models/specialist_model.dart';
import 'package:flutter_application/features/appointments/models/specialist_review_model.dart';
import 'package:flutter_application/features/appointments/screens/future_appointments.dart';
import 'package:flutter_application/features/appointments/screens/new_appointment/new_appointments.dart';
import 'package:flutter_application/features/authentication/screens/login/login.dart';
import 'package:flutter_application/features/authentication/screens/signup/signup.dart';
import 'package:flutter_application/features/explore/screens/explore.dart';
import 'package:flutter_application/features/profile/models/user_model.dart';
import 'package:flutter_application/utils/constants/asset_strings.dart';
import 'package:flutter_application/common/widgets/buttons.dart';
import 'package:flutter_application/utils/constants/colors.dart';
import 'package:flutter_application/utils/constants/text_styles.dart';
import 'package:flutter_application/common/widgets/inputs.dart';
import 'package:flutter_application/common/widgets/navbar.dart';
import 'package:flutter_application/utils/formatters/formatter.dart';
import 'package:flutter_application/utils/popups/loaders.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AppointmentsHistoryScreen extends StatefulWidget {
  const AppointmentsHistoryScreen({super.key});

  @override
  State<AppointmentsHistoryScreen> createState() =>
      _AppointmentsHistoryScreenState();
}

class _AppointmentsHistoryScreenState extends State<AppointmentsHistoryScreen> {
  double value = 0;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel? userModel;

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

  List<Map<String, dynamic>> oldApps = [];

  @override
  void initState() {
    super.initState();
    fetchAppData().then((_) {setState(() {});});
  }

  Future<void> fetchAppData() async {
    if (user != null) {
      String userId = user!.uid;
      List<AppointmentModel> appModels = await AppointmentRepository.instance.fetchUserOldAppointments(userId);

      for(var app in appModels) {
        SpecialistModel? thisSpecialist = await SpecialistController.instance.getSpecialistById(app.specialistId);
        oldApps.add({
          'specialistId': app.specialistId,
          'userId': app.userId,
          'specialistName': thisSpecialist?.name ?? '',
          'position': thisSpecialist?.title ?? '',
          'specialistImage': specialist2,
          'dateTime': app.dateTime,
          'location': app.location,
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return user != null
        ? Scaffold(
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
                          bottom:
                              BorderSide(color: Color(0xFFB23A48), width: 3),
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
                                onPressed: () => Get.offAll(() => const ExploreScreen()),
                              ),
                              Text('Appointments',
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
                                decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0x59223944),
                                      spreadRadius: 0,
                                      blurRadius: 30,
                                      offset: Offset(0,
                                          8), 
                                    ),
                                  ],
                                ),
                                child: ButtonTypeIcon(
                                  text: 'Add an appointment',
                                  icon: CupertinoIcons.add_circled,
                                  color: red5,
                                  type: 'primary',
                                  onPressed: () => Get.to(() => const NewAppointmentsScreen()),
                                ),
                              ),
                              const SizedBox(height: 32),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                      bottom:
                                          BorderSide(color: blue7, width: 2)),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: blue7,
                                          ),
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                              minimumSize: Size.zero,
                                              padding: EdgeInsets.zero,
                                              overlayColor:
                                                  const Color.fromARGB(
                                                      0, 255, 255, 255),
                                            ),
                                            onPressed: () => Get.to(() => const AppointmentsHistoryScreen()),
                                            child: Text(' History ',
                                                style: tMenu.copyWith(
                                                    color: white1)),
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            minimumSize: Size.zero,
                                            padding: EdgeInsets.zero,
                                            overlayColor: const Color.fromARGB(
                                                0, 255, 255, 255),
                                          ),
                                          onPressed: () => Get.to(() => const FutureAppointmentsScreen()),
                                          child: Text('Future appointments',
                                              style:
                                                  tMenu.copyWith(color: blue7)),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              Wrap(
                                spacing: 20,
                                runSpacing: 20,
                                children: <Widget>[
                                  for (var oa in oldApps)
                                    SpecialistBox(uid: oa['userId'], id: oa['specialistId'], name: oa['specialistName'], date: oa['dateTime'], location: oa['location'], position: oa['position'], image: specialist2,)
                                ]
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
            bottomNavigationBar: const BottomNavBar(selectedOption: 'explore',),
            body: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(bkg1),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SafeArea(
                    child: Column(children: [
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
                          children: [
                            IconButton(
                              icon: Icon(CupertinoIcons.chevron_left,
                                  color: red5, size: 32),
                              onPressed: () => Get.back(),
                            ),
                            const SizedBox(width: 49),
                            Text('Appointments',
                                style: h4.copyWith(color: red5)),
                          ],
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Text(
                            'In order to make appointments and see your history, log into your account.',
                            style: tParagraph.copyWith(color: black)),
                        const SizedBox(height: 24),
                        Container(
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x59223944),
                                spreadRadius: 0,
                                blurRadius: 30,
                                offset: Offset(
                                    0, 8), 
                              ),
                            ],
                          ),
                          child: ButtonTypeIcon(
                            text: 'Login',
                            icon: CupertinoIcons.square_arrow_right,
                            color: blue7,
                            type: 'primary',
                            onPressed: () => Get.to(() => const LoginScreen()),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x59223944),
                                spreadRadius: 0,
                                blurRadius: 30,
                                offset: Offset(
                                    0, 8), 
                              ),
                            ],
                          ),
                          child: ButtonTypeIcon(
                            text: 'Sign up',
                            icon: CupertinoIcons.person_badge_plus,
                            color: red5,
                            type: 'primary',
                            onPressed: () => Get.to(() => const SignupScreen()),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]))));
  }
}

class SpecialistBox extends StatelessWidget {
  const SpecialistBox({
    super.key,
    required this.uid,
    required this.id,
    required this.name,
    required this.position,
    required this.date,
    required this.location,
    required this.image,
  });

  final String uid;
  final String id;
  final String name;
  final String position;
  final String date;
  final String location;
  final String image;

  @override
  Widget build(BuildContext context) {
    
  int newReviewRating = 0;
  TextEditingController newReviewController = TextEditingController();
  
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  Future<void> createAppointment(String date, String time, String specialistId, String location) async {
    String dateTimeString = '$date $time';
    DateTime dateTime = DateFormat('dd-MM-yyyy HH:mm').parse(dateTimeString);
    dateTimeString = DateFormat('yyyy-MM-dd HH:mm').format(dateTime);

    AppointmentModel newApp = AppointmentModel(id: 'APP_${specialistId}_${uid}_$dateTimeString', userId: uid, specialistId: specialistId, dateTime: dateTimeString, location: location);
    print('newapp: ${newApp.dateTime} ${newApp.location} ${newApp.userId} ${newApp.specialistId}');
    await AppointmentRepository.instance.saveAppointmentRecord(newApp);
  }

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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: context.width / 2 - 6 - 20 - 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date',
                        style: tParagraph.copyWith(color: black),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        date,
                        style: tParagraphMed.copyWith(color: grey8),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: context.width / 2 - 6 - 20 - 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Location',
                        style: tParagraph.copyWith(color: black),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        location,
                        style: tParagraphMed.copyWith(color: grey8),
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                    width: context.width / 2 - 6 - 20 - 16,
                    child: ButtonType(
                      text: 'Leave review',
                      color: blue7,
                      type: "primary",
                      onPressed: () => showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              insetPadding: const EdgeInsets.all(16),
                              backgroundColor: white1,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              shadowColor: blue7dtrans,
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
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
                                      child: Text('Review',
                                          textAlign: TextAlign.center,
                                          style: h5.copyWith(color: black))),
                                  const SizedBox(height: 24),
                                  Text(
                                      'We hope you enjoyed your appointment! Leave a rating and a review for Pop Laura.',
                                      style: tParagraph.copyWith(color: grey8)),
                                  const SizedBox(height: 24),
                                  SizedBox(
                                    width: context.width,
                                    child: AnimatedRatingStars(
                                      initialRating: 0.0,
                                      minRating: 0.0,
                                      maxRating: 5.0,
                                      filledColor: red5,
                                      emptyColor: red5,
                                      filledIcon: CupertinoIcons.star_fill,
                                      halfFilledIcon:
                                          CupertinoIcons.star_lefthalf_fill,
                                      emptyIcon: CupertinoIcons.star,
                                      onChanged: (double rating) {
                                        newReviewRating = rating.round();
                                      },
                                      displayRatingValue: true,
                                      interactiveTooltips: true,
                                      customFilledIcon:
                                          CupertinoIcons.star_fill,
                                      customHalfFilledIcon:
                                          CupertinoIcons.star_lefthalf_fill,
                                      customEmptyIcon: CupertinoIcons.star,
                                      starSize: 40.0,
                                      animationDuration:
                                          const Duration(milliseconds: 300),
                                      animationCurve: Curves.easeInOut,
                                      readOnly: false,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  InputType(
                                      controller: newReviewController,
                                      type: 'text-area',
                                      inputType: TextInputType.multiline,
                                      placeholder: 'Message',
                                      mustBeFilled: true,
                                      ),
                                  const SizedBox(height: 24),
                                  Row(children: [
                                    SizedBox(
                                        width: context.width / 2 - 6 - 40,
                                        child: ButtonType(
                                            text: 'Save',
                                            color: blue7,
                                            type: "primary",
                                            onPressed: () async => {
                                              await SpecialistReviewController.instance.addSpecialistReview(SpecialistReviewModel(
                                                id: '', 
                                                specialistId: id, 
                                                userId: uid, 
                                                rating: newReviewRating, 
                                                message: newReviewController.text, 
                                                dateTime: TFormatter.formatAppointmentDate(DateTime.now())
                                              )),
                                              Navigator.of(context).pop(),
                                            })),
                                    const SizedBox(width: 12),
                                    SizedBox(
                                        width: context.width / 2 - 6 - 40,
                                        child: ButtonType(
                                            text: 'Cancel',
                                            color: red5,
                                            type: "secondary",
                                            onPressed: () =>
                                                Navigator.of(context).pop()))
                                  ]),
                                ],
                              ),
                            );
                          }),
                    )),
                const SizedBox(
                  width: 12,
                ),
                SizedBox(
                    width: context.width / 2 - 6 - 20 - 16,
                    child: ButtonType(
                      text: 'Book again',
                      color: pink5,
                      type: "primary",
                      onPressed: () => showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              insetPadding: const EdgeInsets.all(16),
                              backgroundColor: white1,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              shadowColor: blue7dtrans,
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
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
                                      child: Text('Book appointment again',
                                          textAlign: TextAlign.center,
                                          style: h5.copyWith(color: black))),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  Text(
                                      'Select a timeframe from the available spots.',
                                      style: tParagraph.copyWith(color: grey8)),
                                  const SizedBox(height: 24),
                                  InputType(
                                      controller: dateController,
                                      calendarStart: DateTime.now(),
                                      calendarEnd: DateTime(2026),
                                      type: 'calendar',
                                      inputType: TextInputType.text,
                                      placeholder: 'Day',
                                      mustBeFilled: true,
                                      ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  InputType(
                                    controller: timeController,
                                    type: 'dropdown',
                                    inputType: TextInputType.text,
                                    placeholder: 'Time',
                                    mustBeFilled: true,
                                    dropdownWidth: context.width - 80,
                                    dropdownList: const [
                                      DropdownMenuEntry(
                                          value: 1, label: '10:00'),
                                      DropdownMenuEntry(
                                          value: 2, label: '11:00'),
                                      DropdownMenuEntry(
                                          value: 3, label: '12:00'),
                                      DropdownMenuEntry(
                                          value: 4, label: '13:00'),
                                      DropdownMenuEntry(
                                          value: 5, label: '14:00'),
                                      DropdownMenuEntry(
                                          value: 6, label: '16:00')
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  Row(children: [
                                    SizedBox(
                                        width: context.width / 2 - 6 - 40,
                                        child: ButtonType(
                                            text: 'Book',
                                            color: blue7,
                                            type: "primary",
                                            onPressed: () async => {
                                              if(dateController.text != '' && timeController.text != '') {
                                                await createAppointment(dateController.text, timeController.text, id, location),
                                                Navigator.of(context).pop(),
                                                TLoaders.successSnackBar(title: 'Success', message: 'Appointment was rebooked')
                                              } else {
                                                TLoaders.errorSnackBar(title: 'Error', message: 'Must pick date and time.')
                                              }
                                            }
                                                )),
                                    const SizedBox(width: 12),
                                    SizedBox(
                                        width: context.width / 2 - 6 - 40,
                                        child: ButtonType(
                                            text: 'Cancel',
                                            color: red5,
                                            type: "secondary",
                                            onPressed: () =>
                                                Navigator.of(context).pop()))
                                  ]),
                                ],
                              ),
                            );
                          }),
                    ))
              ],
            )
          ],
        ));
  }
}
