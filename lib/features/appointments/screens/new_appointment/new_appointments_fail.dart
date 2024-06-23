import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/features/appointments/screens/new_appointment/new_appointments.dart';
import 'package:flutter_application/features/customer_service/screens/customer_service.dart';
import 'package:flutter_application/utils/constants/asset_strings.dart';
import 'package:flutter_application/utils/constants/colors.dart';
import 'package:flutter_application/utils/constants/text_styles.dart';
import 'package:flutter_application/common/widgets/buttons.dart';
import 'package:flutter_application/common/widgets/navbar.dart';
import 'package:get/get.dart';

class NewAppointmentsFailScreen extends StatelessWidget {
  const NewAppointmentsFailScreen({super.key});

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
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 32),
                    decoration: BoxDecoration(
                      color: white1,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x59223944),
                          spreadRadius: 0,
                          blurRadius: 30,
                          offset:
                              Offset(0, 8), // (0, -8) for BottomBarNavigation
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(
                                  text: 'Appointment ',
                                  style: h41.copyWith(color: blue7)),
                              TextSpan(
                                  text: 'failed',
                                  style: h41.copyWith(color: red5))
                            ])),
                        const SizedBox(height: 32),
                        Text(
                            'We ran into some difficulties when booking your appointment. Try again and if the problem persists, contact technical support.',
                            style: tParagraph.copyWith(color: grey8)),
                        const SizedBox(height: 32),
                        ButtonType(
                          text: 'Contact support',
                          color: blue7,
                          type: 'primary',
                          onPressed: () => Get.to(() => const CustomerSupportScreen()),
                        ),
                        const SizedBox(height: 12),
                        ButtonType(
                          text: 'Try again',
                          color: blue7,
                          type: 'secondary',
                          onPressed: () => Get.to(() => const NewAppointmentsScreen()),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
