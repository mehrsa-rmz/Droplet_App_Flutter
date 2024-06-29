import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/data/repositories/user_repository.dart';
import 'package:flutter_application/features/products/controllers/conditions_controller.dart';
import 'package:flutter_application/features/products/controllers/ingredinets_controller.dart';
import 'package:flutter_application/features/products/models/condition_model.dart';
import 'package:flutter_application/features/products/models/ingredient_model.dart';
import 'package:flutter_application/features/profile/controllers/user_allergies_controller.dart';
import 'package:flutter_application/features/profile/controllers/user_conditions_controller.dart';
import 'package:flutter_application/features/profile/controllers/user_controller.dart';
import 'package:flutter_application/features/profile/models/user_allergy_model.dart';
import 'package:flutter_application/features/profile/models/user_condition_model.dart';
import 'package:flutter_application/features/profile/models/user_model.dart';
import 'package:flutter_application/features/profile/screens/profile.dart';
import 'package:flutter_application/utils/constants/asset_strings.dart';
import 'package:flutter_application/utils/constants/text_styles.dart';
import 'package:flutter_application/utils/constants/colors.dart';
import 'package:flutter_application/common/widgets/buttons.dart';
import 'package:flutter_application/common/widgets/inputs.dart';
import 'package:flutter_application/common/widgets/navbar.dart';
import 'package:flutter_application/utils/popups/loaders.dart';
import 'package:flutter_application/utils/validators/validation.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

// ignore: must_be_immutable
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel? userModel;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  List<UserConditionModel> skinCond = [];
  List<UserConditionModel> bodyCond = [];
  List<UserConditionModel> hairCond = [];
  List<UserConditionModel> prefCond = [];
  List<UserAllergyModel> allergies = [];
  GlobalKey<FormState> editProfileKey = GlobalKey<FormState>();

  List<ConditionModel> conditions = [];
  List<IngredientModel> ingredients = [];

  List<ConditionModel> allSkinCond = [];
  List<ConditionModel> allBodyCond = [];
  List<ConditionModel> allHairCond = [];
  List<ConditionModel> allPrefCond = [];
  List<IngredientModel> allAllergies = [];

  List<ConditionModel> selectedSkinCond = [];
  List<ConditionModel> selectedBodyCond = [];
  List<ConditionModel> selectedHairCond = [];
  List<ConditionModel> selectedPrefCond = [];
  List<IngredientModel> selectedAllergies = [];

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    if (user != null) {
      String userId = user!.uid;
      userModel = await UserController.fetchUserById(userId);
      firstNameController.text = userModel?.firstName ?? '';
      lastNameController.text = userModel?.lastName ?? '';
      phoneController.text = userModel?.phoneNo ?? '';
      addressController.text = userModel?.address ?? '';
      birthdayController.text = userModel?.birthday ?? '';
      genderController.text = (userModel?.gender ?? '') != 'all' ? userModel?.gender ?? '' : '';

      List<UserConditionModel> currentUserConditions = await UserConditionController.instance.fetchUserConditionForUserId(userId);
      List<UserAllergyModel> currentUserAllergies = await UserAllergyController.instance.fetchUserAllergiesForUserId(userId);
      
      conditions = await ConditionController.instance.getConditions();
      ingredients = await IngredientController.instance.getIngredients();

      for(var uc in currentUserConditions){
        ConditionModel? conditionToAdd = await ConditionController.instance.getConditionById(uc.conditionId);
        var condType = conditionToAdd?.type ?? '';
        if (condType == 'Body'){
          bodyCond.add(uc);
        }
        if (condType == 'Hair'){
          hairCond.add(uc);
        }
        if (condType == 'Perfume'){
          prefCond.add(uc);
        }
        if (condType == 'Skin'){
          skinCond.add(uc);
        }
      }

      for(var ua in currentUserAllergies){
        allergies.add(ua);
      }

      for(var c in conditions){
        if (c.type == 'Body'){
          allBodyCond.add(c);
        }
        if (c.type == 'Hair'){
          allHairCond.add(c);
        }
        if (c.type == 'Perfume'){
          allPrefCond.add(c);
        }
        if (c.type == 'Skin'){
          allSkinCond.add(c);
        }
      }

      for (var i in ingredients) {
        allAllergies.add(i);
      }

      // Initialize selected values
      selectedSkinCond = skinCond.map((uc) => allSkinCond.firstWhere((c) => c.id == uc.conditionId)).toList();
      selectedBodyCond = bodyCond.map((uc) => allBodyCond.firstWhere((c) => c.id == uc.conditionId)).toList();
      selectedHairCond = hairCond.map((uc) => allHairCond.firstWhere((c) => c.id == uc.conditionId)).toList();
      selectedPrefCond = prefCond.map((uc) => allPrefCond.firstWhere((c) => c.id == uc.conditionId)).toList();
      selectedAllergies = allergies.map((ua) => allAllergies.firstWhere((i) => i.id == ua.ingredientId)).toList();

      setState(() {});
    }
  }

  Future<void> makeChanges() async {
    userModel!.firstName = firstNameController.text.trim();
    userModel!.lastName = lastNameController.text.trim();
    userModel!.phoneNo = phoneController.text.trim();
    userModel!.address = addressController.text.trim();
    userModel!.birthday = birthdayController.text.trim();
    userModel!.gender = genderController.text.trim() == '-' ? 'all' : genderController.text.trim();

    await UserRepository.instance.updateUserDetails(userModel!);

    await _updateConditions();
    await _updateAllergies();
  }

  Future<void> _updateConditions() async {
    String userId = user!.uid;
    List<UserConditionModel> currentUserConditions = await UserConditionController.instance.fetchUserConditionForUserId(userId);

    List<String> selectedConditionIds = [
      ...selectedSkinCond.map((e) => e.id),
      ...selectedBodyCond.map((e) => e.id),
      ...selectedHairCond.map((e) => e.id),
      ...selectedPrefCond.map((e) => e.id),
    ];

    for (var condition in currentUserConditions) {
      if (!selectedConditionIds.contains(condition.conditionId)) {
        await UserConditionController.instance.deleteUserCondition(condition.id);
      }
    }

    for (var conditionId in selectedConditionIds) {
      if (!currentUserConditions.any((c) => c.conditionId == conditionId)) {
        UserConditionModel newCondition = UserConditionModel(
          id: 'UserCondition_${userId}_$conditionId',
          userId: userId,
          conditionId: conditionId,
        );
        await UserConditionController.instance.addUserCondition(newCondition);
      }
    }
  }

  Future<void> _updateAllergies() async {
    String userId = user!.uid;
    List<UserAllergyModel> currentUserAllergies = await UserAllergyController.instance.fetchUserAllergiesForUserId(userId);

    List<String> selectedAllergyIds = selectedAllergies.map((e) => e.id).toList();

    for (var allergy in currentUserAllergies) {
      if (!selectedAllergyIds.contains(allergy.ingredientId)) {
        await UserAllergyController.instance.deleteUserAllergy(allergy.id);
      }
    }

    for (var allergyId in selectedAllergyIds) {
      if (!currentUserAllergies.any((a) => a.ingredientId == allergyId)) {
        UserAllergyModel newAllergy = UserAllergyModel(
          id: 'UserAllergy_${userId}_$allergyId',
          userId: userId,
          ingredientId: allergyId,
        );
        await UserAllergyController.instance.addUserAllergy(newAllergy);
      }
    }
  }

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
        child: Column(
          children: [
            Container(
              width: context.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(bkg4),
                  fit: BoxFit.cover,
                ),
                border: Border(
                  bottom: BorderSide(color: Color(0xFFB23A48), width: 3),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Text('Profile', style: h4.copyWith(color: red5)),
                  const SizedBox(height: 12),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
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
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Edit personal information', style: h5.copyWith(color: blue7)),
                        const SizedBox(height: 20),
                        Form(
                          key: editProfileKey,
                          child: Column(
                            children: [
                              InputType(
                                controller: firstNameController,
                                validator: (value) => TValidator.validateEmptyText('First name', value),
                                type: 'one-line',
                                inputType: TextInputType.name,
                                placeholder: 'First name',
                                mustBeFilled: true,
                              ),
                              const SizedBox(height: 20),
                              InputType(
                                controller: lastNameController,
                                validator: (value) => TValidator.validateEmptyText('Last name', value),
                                type: 'one-line',
                                inputType: TextInputType.name,
                                placeholder: 'Last name',
                                mustBeFilled: true,
                              ),
                              const SizedBox(height: 20),
                              InputType(
                                controller: phoneController,
                                validator: TValidator.validatePhoneNumberCanBeNull,
                                type: 'one-line',
                                inputType: TextInputType.phone,
                                placeholder: 'Phone',
                                mustBeFilled: true,
                              ),
                              const SizedBox(height: 20),
                              InputType(
                                controller: addressController,
                                type: 'text-area',
                                inputType: TextInputType.multiline,
                                placeholder: 'Address',
                                mustBeFilled: true,
                              ),
                              const SizedBox(height: 20),
                              InputType(
                                controller: birthdayController,
                                type: 'calendar',
                                inputType: TextInputType.text,
                                placeholder: 'Birthday',
                                mustBeFilled: true,
                                calendarStart: DateTime(1940),
                                calendarEnd: DateTime(2010),
                              ),
                              const SizedBox(height: 20),
                              InputType(
                                controller: genderController,
                                type: 'dropdown',
                                inputType: TextInputType.text,
                                placeholder: 'Gender',
                                mustBeFilled: true,
                                dropdownList: const [
                                  DropdownMenuEntry(value: 0, label: '-'),
                                  DropdownMenuEntry(value: 1, label: 'F'),
                                  DropdownMenuEntry(value: 2, label: 'M'),
                                ],
                                dropdownWidth: context.width - 32 - 40,
                              ),
                              const SizedBox(height: 20),
                              MultiSelectDialogField<ConditionModel>(
                                items: allSkinCond.map((e) => MultiSelectItem(e, e.name)).toList(),
                                title: Text("Skin type", style: h5.copyWith(color: blue7)),
                                selectedColor: blue4ltrans,
                                listType: MultiSelectListType.CHIP,
                                confirmText: Text('OK', style: tButtonSmall.copyWith(color: blue4)),
                                cancelText: Text('CANCEL', style: tButtonSmall.copyWith(color: red5)),
                                buttonText: Text("Skin type", style: tMenu.copyWith(color: blue7)),
                                buttonIcon: Icon(CupertinoIcons.add_circled, color: blue7),
                                backgroundColor: white1,
                                itemsTextStyle: tParagraph.copyWith(color: grey8),
                                selectedItemsTextStyle: tParagraph.copyWith(color: black),
                                unselectedColor: offwhite1,
                                checkColor: black,
                                initialValue: selectedSkinCond,
                                onConfirm: (values) {
                                  setState(() {
                                    selectedSkinCond = values;
                                  });
                                },
                                chipDisplay: MultiSelectChipDisplay(
                                  onTap: (value) {
                                    setState(() {
                                      selectedSkinCond.remove(value);
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                              MultiSelectDialogField<ConditionModel>(
                                items: allBodyCond.map((e) => MultiSelectItem(e, e.name)).toList(),
                                title: Text("Body skin type", style: h5.copyWith(color: blue7)),
                                selectedColor: blue4ltrans,
                                listType: MultiSelectListType.CHIP,
                                confirmText: Text('OK', style: tButtonSmall.copyWith(color: blue4)),
                                cancelText: Text('CANCEL', style: tButtonSmall.copyWith(color: red5)),
                                buttonText: Text("Body skin type", style: tMenu.copyWith(color: blue7)),
                                buttonIcon: Icon(CupertinoIcons.add_circled, color: blue7),
                                backgroundColor: white1,
                                itemsTextStyle: tParagraph.copyWith(color: grey8),
                                selectedItemsTextStyle: tParagraph.copyWith(color: black),
                                unselectedColor: offwhite1,
                                checkColor: black,
                                initialValue: selectedBodyCond,
                                onConfirm: (values) {
                                  setState(() {
                                    selectedBodyCond = values;
                                  });
                                },
                                chipDisplay: MultiSelectChipDisplay(
                                  onTap: (value) {
                                    setState(() {
                                      selectedBodyCond.remove(value);
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                              MultiSelectDialogField<ConditionModel>(
                                items: allHairCond.map((e) => MultiSelectItem(e, e.name)).toList(),
                                title: Text("Hair type", style: h5.copyWith(color: blue7)),
                                selectedColor: blue4ltrans,
                                listType: MultiSelectListType.CHIP,
                                confirmText: Text('OK', style: tButtonSmall.copyWith(color: blue4)),
                                cancelText: Text('CANCEL', style: tButtonSmall.copyWith(color: red5)),
                                buttonText: Text("Hair type", style: tMenu.copyWith(color: blue7)),
                                buttonIcon: Icon(CupertinoIcons.add_circled, color: blue7),
                                backgroundColor: white1,
                                itemsTextStyle: tParagraph.copyWith(color: grey8),
                                selectedItemsTextStyle: tParagraph.copyWith(color: black),
                                unselectedColor: offwhite1,
                                checkColor: black,
                                initialValue: selectedHairCond,
                                onConfirm: (values) {
                                  setState(() {
                                    selectedHairCond = values;
                                  });
                                },
                                chipDisplay: MultiSelectChipDisplay(
                                  onTap: (value) {
                                    setState(() {
                                      selectedHairCond.remove(value);
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                              MultiSelectDialogField<ConditionModel>(
                                items: allPrefCond.map((e) => MultiSelectItem(e, e.name)).toList(),
                                title: Text("Preferences", style: h5.copyWith(color: blue7)),
                                selectedColor: blue4ltrans,
                                listType: MultiSelectListType.CHIP,
                                confirmText: Text('OK', style: tButtonSmall.copyWith(color: blue4)),
                                cancelText: Text('CANCEL', style: tButtonSmall.copyWith(color: red5)),
                                buttonText: Text("Preferences", style: tMenu.copyWith(color: blue7)),
                                buttonIcon: Icon(CupertinoIcons.add_circled, color: blue7),
                                backgroundColor: white1,
                                itemsTextStyle: tParagraph.copyWith(color: grey8),
                                selectedItemsTextStyle: tParagraph.copyWith(color: black),
                                unselectedColor: offwhite1,
                                checkColor: black,
                                initialValue: selectedPrefCond,
                                onConfirm: (values) {
                                  setState(() {
                                    selectedPrefCond = values;
                                  });
                                },
                                chipDisplay: MultiSelectChipDisplay(
                                  onTap: (value) {
                                    setState(() {
                                      selectedPrefCond.remove(value);
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                              MultiSelectDialogField<IngredientModel>(
                                items: allAllergies.map((e) => MultiSelectItem(e, e.name)).toList(),
                                title: Text("Allergies", style: h5.copyWith(color: blue7)),
                                selectedColor: blue4ltrans,
                                listType: MultiSelectListType.CHIP,
                                confirmText: Text('OK', style: tButtonSmall.copyWith(color: blue4)),
                                cancelText: Text('CANCEL', style: tButtonSmall.copyWith(color: red5)),
                                buttonText: Text("Allergies", style: tMenu.copyWith(color: blue7)),
                                buttonIcon: Icon(CupertinoIcons.add_circled, color: blue7),
                                backgroundColor: white1,
                                itemsTextStyle: tParagraph.copyWith(color: grey8),
                                selectedItemsTextStyle: tParagraph.copyWith(color: black),
                                unselectedColor: offwhite1,
                                checkColor: black,
                                initialValue: selectedAllergies,
                                onConfirm: (values) {
                                  setState(() {
                                    selectedAllergies = values;
                                  });
                                },
                                chipDisplay: MultiSelectChipDisplay(
                                  onTap: (value) {
                                    setState(() {
                                      selectedAllergies.remove(value);
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
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
                                      insetPadding: const EdgeInsets.all(16),
                                      backgroundColor: white1,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      shadowColor: blue7dtrans,
                                      title: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            icon: Icon(CupertinoIcons.xmark, color: red5, size: 24),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          SizedBox(
                                            width: context.width,
                                            child: Text('Warning', textAlign: TextAlign.center, style: h5.copyWith(color: black)),
                                          ),
                                          const SizedBox(height: 24),
                                          SizedBox(
                                            width: context.width,
                                            child: Text(
                                              'Are you sure you want to cancel the process?',
                                              style: tParagraph.copyWith(color: grey8),
                                            ),
                                          ),
                                          const SizedBox(height: 24),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: context.width / 2 - 6 - 40,
                                                child: ButtonType(
                                                  text: 'Yes, cancel',
                                                  color: red5,
                                                  type: "primary",
                                                  onPressed: () => Get.offAll(() => const ProfileScreen()),
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              SizedBox(
                                                width: context.width / 2 - 6 - 40,
                                                child: ButtonType(
                                                  text: 'No, keep',
                                                  color: blue7,
                                                  type: "secondary",
                                                  onPressed: () => Navigator.of(context).pop(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            SizedBox(
                              width: context.width / 2 - 6 - 20 - 16,
                              child: ButtonType(
                                text: 'Save',
                                color: blue7,
                                type: "primary",
                                onPressed: () async {
                                  if (editProfileKey.currentState!.validate()) {
                                    await makeChanges();
                                    Get.offAll(() => const ProfileScreen());
                                  } else {
                                    TLoaders.errorSnackBar(
                                      title: 'Error',
                                      message: 'Info incorrect or missing.',
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
