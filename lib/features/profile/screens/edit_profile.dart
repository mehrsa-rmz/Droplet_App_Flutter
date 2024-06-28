import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/features/profile/screens/profile.dart';
import 'package:flutter_application/utils/constants/asset_strings.dart';
import 'package:flutter_application/utils/constants/text_styles.dart';
import 'package:flutter_application/utils/constants/colors.dart';
import 'package:flutter_application/common/widgets/buttons.dart';
import 'package:flutter_application/common/widgets/inputs.dart';
import 'package:flutter_application/common/widgets/navbar.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var testersNo = 2;
  bool expanded = false;

  //final Map<String, dynamic> _user = {'emai': 'poplaura@gmail.com', 'password': '123456', 'resetCode': '-', 'firstName': 'Ana', 'lastName': 'Pop', 'cliendCode': '165432', 'points': 475.toDouble(), 'phone': '0722555444', 'city': 'Bucharest', 'postalCode': '0308334', 'address': 'Sector 4, str. Pacii nr. 54, bl. F2, scara 2, etaj 5, ap. 44', 'gender': 'f', 'birthday': 'October 16th 1999', 'skinType': ['oily', 'sensitive', 'acne prone'], 'hairType': ['curly', 'dry', 'dyed', 'thick', 'frizzy'], 'allergies': [], 'preferences': ['floral', 'fruity', 'spiced'], 'testersNo': 2};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const BottomNavBar(
          selectedOption: 'profile',
        ),
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(bkg4),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(children: [
              Container(
                  width: context.width,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(bkg4),
                        fit: BoxFit.cover,
                      ),
                      border: Border(
                          bottom:
                              BorderSide(color: Color(0xFFB23A48), width: 3))),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Profile',
                        style: h4.copyWith(color: red5),
                      ),
                      const SizedBox(
                        height: 12,
                      )
                    ],
                  )),
              Expanded(
                  child: ListView(children: [
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(children: [
                      const SizedBox(height: 32),
                      Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: white1,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x59223944),
                                spreadRadius: 0,
                                blurRadius: 30,
                                offset: Offset(
                                    0, 8), 
                              )
                            ],
                          ),
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            Text('Edit personal information',
                                style: h5.copyWith(color: blue7)),
                            const SizedBox(height: 20),
                            Form(
                                child: Column(
                              children: [
                                InputType(
                                  type: 'one-line',
                                  inputType: TextInputType.name,
                                  placeholder: 'First name',
                                  mustBeFilled: true,
                                ),
                                const SizedBox(height: 20),
                                InputType(
                                  type: 'one-line',
                                  inputType: TextInputType.name,
                                  placeholder: 'Last name',
                                  mustBeFilled: true,
                                ),
                                const SizedBox(height: 20),
                                InputType(
                                  type: 'one-line',
                                  inputType: TextInputType.phone,
                                  placeholder: 'Phone',
                                  mustBeFilled: true,
                                ),
                                const SizedBox(height: 20),
                                InputType(
                                  type: 'text-area',
                                  inputType: TextInputType.multiline,
                                  placeholder: 'Address',
                                  mustBeFilled: true,
                                ),
                                const SizedBox(height: 20),
                                InputType(
                                  type: 'calendar',
                                  inputType: TextInputType.text,
                                  placeholder: 'Birthday',
                                  mustBeFilled: true,
                                  calendarStart: DateTime(1940),
                                  calendarEnd: DateTime(2010),
                                ),
                                const SizedBox(height: 20),
                                InputType(
                                  type: 'dropdown',
                                  inputType: TextInputType.text,
                                  placeholder: 'Gender',
                                  mustBeFilled: true,
                                  dropdownList: const [
                                    DropdownMenuEntry(value: 1, label: 'F'),
                                    DropdownMenuEntry(value: 2, label: 'M')
                                  ],
                                  dropdownWidth: context.width - 32 - 40,
                                ),
                                const SizedBox(height: 20),
                                InputType(
                                  type: 'multi-select',
                                  inputType: TextInputType.text,
                                  placeholder: 'Skin type',
                                  mustBeFilled: true,
                                  multiselectList: const [
                                    DropdownMenuEntry(value: 1, label: 'oily'),
                                    DropdownMenuEntry(
                                        value: 2, label: 'sensitive'),
                                    DropdownMenuEntry(
                                        value: 3, label: 'acne prone'),
                                    DropdownMenuEntry(value: 4, label: 'dry'),
                                    DropdownMenuEntry(
                                        value: 5, label: 'combination'),
                                    DropdownMenuEntry(value: 6, label: 'scars')
                                  ],
                                ),
                                const SizedBox(height: 20),
                                InputType(
                                  type: 'multi-select',
                                  inputType: TextInputType.text,
                                  placeholder: 'Hair type',
                                  mustBeFilled: true,
                                  multiselectList: const [
                                    DropdownMenuEntry(
                                        value: 1, label: 'straight'),
                                    DropdownMenuEntry(value: 2, label: 'wavy'),
                                    DropdownMenuEntry(value: 3, label: 'curly'),
                                    DropdownMenuEntry(value: 4, label: 'coily'),
                                    DropdownMenuEntry(value: 5, label: 'thin'),
                                    DropdownMenuEntry(value: 6, label: 'thick'),
                                    DropdownMenuEntry(value: 7, label: 'dry'),
                                    DropdownMenuEntry(value: 8, label: 'oily'),
                                    DropdownMenuEntry(
                                        value: 9, label: 'frizzy'),
                                    DropdownMenuEntry(
                                        value: 10, label: 'dandruff'),
                                    DropdownMenuEntry(value: 11, label: 'dyed')
                                  ],
                                ),
                                const SizedBox(height: 20),
                                InputType(
                                  type: 'multi-select',
                                  inputType: TextInputType.text,
                                  placeholder: 'Allergies',
                                  mustBeFilled: true,
                                  multiselectList: const [
                                    DropdownMenuEntry(value: 1, label: 'a'),
                                    DropdownMenuEntry(value: 2, label: 'b'),
                                    DropdownMenuEntry(value: 3, label: 'c'),
                                    DropdownMenuEntry(value: 4, label: 'd'),
                                    DropdownMenuEntry(value: 5, label: 'e'),
                                    DropdownMenuEntry(value: 6, label: 'f')
                                  ],
                                ),
                                const SizedBox(height: 20),
                                InputType(
                                  type: 'multi-select',
                                  inputType: TextInputType.text,
                                  placeholder: 'Preferences',
                                  mustBeFilled: true,
                                  multiselectList: const [
                                    DropdownMenuEntry(
                                        value: 1, label: 'floral'),
                                    DropdownMenuEntry(
                                        value: 2, label: 'fruity'),
                                    DropdownMenuEntry(value: 3, label: 'sweet'),
                                    DropdownMenuEntry(value: 4, label: 'fresh'),
                                    DropdownMenuEntry(
                                        value: 5, label: 'spiced'),
                                    DropdownMenuEntry(
                                        value: 6, label: 'oriental'),
                                    DropdownMenuEntry(value: 7, label: 'musky'),
                                    DropdownMenuEntry(value: 8, label: 'woody')
                                  ],
                                ),
                              ],
                            )),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                    width: context.width / 2 - 6 - 20 - 16,
                                    child: ButtonType(
                                      text: 'Cancel',
                                      color: red5,
                                      type: "primary",
                                      onPressed: () => showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              insetPadding:
                                                  const EdgeInsets.all(16),
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
                                                    icon: Icon(
                                                        CupertinoIcons.xmark,
                                                        color: red5,
                                                        size: 24),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  SizedBox(
                                                      width: context.width,
                                                      child: Text('Warning',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: h5.copyWith(
                                                              color: black))),
                                                  const SizedBox(
                                                    height: 24,
                                                  ),
                                                  SizedBox(
                                                      width: context.width,
                                                      child: Text(
                                                          'Are you sure you want to cancel the process?',
                                                          style: tParagraph
                                                              .copyWith(
                                                                  color:
                                                                      grey8))),
                                                  const SizedBox(height: 24),
                                                  Row(children: [
                                                    SizedBox(
                                                        width:
                                                            context.width / 2 -
                                                                6 -
                                                                40,
                                                        child: ButtonType(
                                                            text: 'Yes, cancel',
                                                            color: red5,
                                                            type: "primary",
                                                            onPressed: () =>
                                                                Get.to(() =>
                                                                    const ProfileScreen()))),
                                                    const SizedBox(width: 12),
                                                    SizedBox(
                                                        width:
                                                            context.width / 2 -
                                                                6 -
                                                                40,
                                                        child: ButtonType(
                                                            text: 'No, keep',
                                                            color: blue7,
                                                            type: "secondary",
                                                            onPressed: () =>
                                                                Navigator.of(
                                                                        context)
                                                                    .pop()))
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
                                        text: 'Save',
                                        color: blue7,
                                        type: "primary",
                                        onPressed: () => Get.to(
                                            () => const ProfileScreen())))
                              ],
                            )
                          ]))
                    ])),
                const SizedBox(height: 20),
              ]))
            ])));
  }
}
