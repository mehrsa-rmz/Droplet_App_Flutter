import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/features/appointments/screens/future_appointments.dart';
import 'package:flutter_application/features/appointments/screens/new_appointment/new_appointments.dart';
import 'package:flutter_application/features/authentication/screens/login/login.dart';
import 'package:flutter_application/features/authentication/screens/signup/signup.dart';
import 'package:flutter_application/utils/constants/asset_strings.dart';
import 'package:flutter_application/common/widgets/buttons.dart';
import 'package:flutter_application/utils/constants/colors.dart';
import 'package:flutter_application/utils/constants/text_styles.dart';
import 'package:flutter_application/common/widgets/inputs.dart';
import 'package:flutter_application/common/widgets/navbar.dart';
import 'package:get/get.dart';

class AppointmentsHistoryScreen extends StatefulWidget {
  const AppointmentsHistoryScreen({super.key});

  @override
  State<AppointmentsHistoryScreen> createState() =>
      _AppointmentsHistoryScreenState();
}

class _AppointmentsHistoryScreenState extends State<AppointmentsHistoryScreen> {
  double value = 0;
  User? user = FirebaseAuth.instance.currentUser;

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
                                onPressed: () => Get.back(),
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
                                          8), // (0, -8) for BottomBarNavigation
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
                              const SpecialistBox(
                                  name: 'Pop Laura',
                                  position: 'Dermatology Specialist',
                                  date: 'May 30th 2023\n13:30',
                                  location: 'Droplet - Afi Palace Mall',
                                  image: specialist1),
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
                                    0, 8), // (0, -8) for BottomBarNavigation
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
                                    0, 8), // (0, -8) for BottomBarNavigation
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
    required this.name,
    required this.position,
    required this.date,
    required this.location,
    required this.image,
  });

  final String name;
  final String position;
  final String date;
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
                                        // Handle the rating change here
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
                                            onPressed: () =>
                                                Navigator.of(context).pop())),
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
                                      type: 'calendar',
                                      inputType: TextInputType.text,
                                      placeholder: 'Day',
                                      mustBeFilled: true,
                                      ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  InputType(
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
                                            onPressed: () =>
                                                Navigator.of(context).pop())),
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
