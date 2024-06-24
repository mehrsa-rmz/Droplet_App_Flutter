import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/features/appointments/screens/appointments_history.dart';
import 'package:flutter_application/features/appointments/screens/new_appointment/new_appointments.dart';
import 'package:flutter_application/utils/constants/asset_strings.dart';
import 'package:flutter_application/common/widgets/buttons.dart';
import 'package:flutter_application/utils/constants/colors.dart';
import 'package:flutter_application/utils/constants/text_styles.dart';
import 'package:flutter_application/common/widgets/inputs.dart';
import 'package:flutter_application/common/widgets/navbar.dart';
import 'package:get/get.dart';

class FutureAppointmentsScreen extends StatefulWidget {
  const FutureAppointmentsScreen({super.key});

  @override
  State<FutureAppointmentsScreen> createState() =>
      _FutureAppointmentsScreenState();
}

class _FutureAppointmentsScreenState extends State<FutureAppointmentsScreen> {
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
                        Text('Appointments', style: h4.copyWith(color: red5)),
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
                                offset: Offset(
                                    0, 8), // (0, -8) for BottomBarNavigation
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
                                bottom: BorderSide(color: blue7, width: 2)),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      minimumSize: Size.zero,
                                      padding: EdgeInsets.zero,
                                      overlayColor: const Color.fromARGB(
                                          0, 255, 255, 255),
                                    ),
                                    onPressed: () => Get.to(() => const AppointmentsHistoryScreen()),
                                    child: Text('History',
                                        style: tMenu.copyWith(color: blue7)),
                                  ),
                                  const SizedBox(width: 16),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: blue7,
                                    ),
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        minimumSize: Size.zero,
                                        padding: EdgeInsets.zero,
                                        overlayColor: const Color.fromARGB(
                                            0, 255, 255, 255),
                                      ),
                                      onPressed: () => Get.to(() => const FutureAppointmentsScreen()),
                                      child: Text('  Future appointments  ',
                                          style: tMenu.copyWith(color: white1)),
                                    ),
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
    );
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
                      text: 'Reschedule',
                      color: blue7,
                      type: "secondary",
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
                                      child: Text('Reschedule appointment',
                                          textAlign: TextAlign.center,
                                          style: h5.copyWith(color: black))),
                                  const SizedBox(height: 24),
                                  Text(
                                      'Select another timeframe from the available spots.',
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
                      text: 'Cancel',
                      color: red5,
                      type: "secondary",
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
                                      child: Text('Warning',
                                          textAlign: TextAlign.center,
                                          style: h5.copyWith(color: black))),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  Text(
                                      'Are you sure you want to cancel the appointment?',
                                      style: tParagraph.copyWith(color: grey8)),
                                  const SizedBox(height: 24),
                                  Row(children: [
                                    SizedBox(
                                        width: context.width / 2 - 6 - 40,
                                        child: ButtonType(
                                            text: 'Yes, cancel',
                                            color: red5,
                                            type: "primary",
                                            onPressed: () =>
                                                Navigator.of(context).pop())),
                                    const SizedBox(width: 12),
                                    SizedBox(
                                        width: context.width / 2 - 6 - 40,
                                        child: ButtonType(
                                            text: 'No, keep',
                                            color: blue7,
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
