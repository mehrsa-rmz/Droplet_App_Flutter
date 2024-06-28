import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/utils/constants/asset_strings.dart';
import 'package:flutter_application/utils/constants/text_styles.dart';
import 'package:flutter_application/utils/constants/colors.dart';
import 'package:flutter_application/common/widgets/navbar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LoyaltyProgramScreen extends StatefulWidget {
  const LoyaltyProgramScreen({super.key});

  @override
  State<LoyaltyProgramScreen> createState() => _LoyaltyProgramScreenState();
}

class _LoyaltyProgramScreenState extends State<LoyaltyProgramScreen> {
  double points = 3000;
  bool expanded1 = false;
  bool expanded2 = false;
  bool leftReview = false;
  bool hadAppointment = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const BottomNavBar(selectedOption: 'profile',),
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(bkg4),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
                child: Column(children: [
              Container(
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage(bkg4),
                    fit: BoxFit.cover,
                  ),
                  border: Border(
                    bottom: BorderSide(color: red5, width: 3),
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
                        Text('Loyalty pogram', style: h4.copyWith(color: red5)),
                        const SizedBox(width: 32)
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
                    const SizedBox(
                      height: 20,
                    ),
                    SvgPicture.asset(logoMedium, height: 131),
                    const SizedBox(
                      height: 20,
                    ),
                    Text('${points.toStringAsFixed(0)} points',
                        style: h4.copyWith(color: red5),
                        textAlign: TextAlign.center),
                    const SizedBox(
                      height: 20,
                    ),
                    Stack(
                      children: [
                        Container(
                            height: 30,
                            decoration: BoxDecoration(
                                color: pink3trans,
                                borderRadius: BorderRadius.circular(60))),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                                height: 30,
                                width: points < 3000
                                    ? points * context.width / 3000
                                    : context.width,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [pink3, red5, blue7]),
                                    borderRadius: BorderRadius.circular(60)))),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('0',
                            style: tMenu.copyWith(
                                color: points >= 0 ? blue7 : pink5)),
                        Text('500',
                            style: tMenu.copyWith(
                                color: points >= 500 ? blue7 : pink5)),
                        Text('1K',
                            style: tMenu.copyWith(
                                color: points >= 1000 ? blue7 : pink5)),
                        Text('1.5K',
                            style: tMenu.copyWith(
                                color: points >= 1500 ? blue7 : pink5)),
                        Text('2K',
                            style: tMenu.copyWith(
                                color: points >= 2000 ? blue7 : pink5)),
                        Text('2.5K',
                            style: tMenu.copyWith(
                                color: points >= 2500 ? blue7 : pink5)),
                        Text('3K',
                            style: tMenu.copyWith(
                                color: points >= 3000 ? blue7 : pink5)),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: blue7, width: 2))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Benefits',
                              style: tButton.copyWith(color: blue7)),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  expanded1 = !expanded1;
                                });
                              },
                              icon: Icon(
                                  expanded1
                                      ? CupertinoIcons.chevron_up
                                      : CupertinoIcons.chevron_down,
                                  color: blue7,
                                  size: 24))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    expanded1
                        ? Container(
                            margin: const EdgeInsets.only(bottom: 20),
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
                            child: Column(
                              children: [
                                RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text:
                                            '🎁 You are very special to us, that is why on your birthday month you can come to any Droplet store and pick out a ',
                                        style:
                                            tParagraph.copyWith(color: grey8)),
                                    TextSpan(
                                        text: 'Birthday Gift',
                                        style: tParagraph.copyWith(
                                            color: red5,
                                            fontWeight: FontWeight.w700)),
                                    TextSpan(
                                        text: ' from the current selection.',
                                        style:
                                            tParagraph.copyWith(color: grey8))
                                  ]),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: '🥉 With ',
                                        style:
                                            tParagraph.copyWith(color: grey8)),
                                    TextSpan(
                                        text: 'Bronze Status',
                                        style: tParagraph.copyWith(
                                            color: red5,
                                            fontWeight: FontWeight.w700)),
                                    TextSpan(
                                        text:
                                            ', enjoy a 5% discount on all products all the time, and a surprise prize.',
                                        style:
                                            tParagraph.copyWith(color: grey8))
                                  ]),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: '🥈 With ',
                                        style:
                                            tParagraph.copyWith(color: grey8)),
                                    TextSpan(
                                        text: 'Silver Status',
                                        style: tParagraph.copyWith(
                                            color: red5,
                                            fontWeight: FontWeight.w700)),
                                    TextSpan(
                                        text:
                                            ', enjoy a 10% discount on all products all the time, and a surprise prize.',
                                        style:
                                            tParagraph.copyWith(color: grey8))
                                  ]),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: '🥇 With ',
                                        style:
                                            tParagraph.copyWith(color: grey8)),
                                    TextSpan(
                                        text: 'Gold Status',
                                        style: tParagraph.copyWith(
                                            color: red5,
                                            fontWeight: FontWeight.w700)),
                                    TextSpan(
                                        text:
                                            ', enjoy a 20% discount on all products all the time, and a surprise prize.',
                                        style:
                                            tParagraph.copyWith(color: grey8))
                                  ]),
                                ),
                              ],
                            ))
                        : const SizedBox(
                            height: 20,
                          ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: blue7, width: 2))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Achievements',
                              style: tButton.copyWith(color: blue7)),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  expanded2 = !expanded2;
                                });
                              },
                              icon: Icon(
                                  expanded2
                                      ? CupertinoIcons.chevron_up
                                      : CupertinoIcons.chevron_down,
                                  color: blue7,
                                  size: 24))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    expanded2
                        ? Column(
                            children: [
                              AchievementBox(
                                  type: 'bronze',
                                  title: 'Unlock Bronze Status',
                                  text: 'Reach 1k points',
                                  completed: points >= 1000),
                              AchievementBox(
                                  type: 'silver',
                                  title: 'Unlock Silver Status',
                                  text: 'Reach 2k points',
                                  completed: points >= 2000),
                              AchievementBox(
                                  type: 'gold',
                                  title: 'Unlock Gold Status',
                                  text: 'Reach 3k points',
                                  completed: points >= 3000),
                              const AchievementBox(
                                  type: 'basic',
                                  title: 'Become a member',
                                  text: '100 points at Sign up',
                                  completed: true),
                              AchievementBox(
                                  type: 'basic',
                                  title: 'Leave a review',
                                  text:
                                      '50 points for the first product review',
                                  completed: leftReview),
                              AchievementBox(
                                  type: 'basic',
                                  title: 'Go to a consultation',
                                  text:
                                      '50 points for the first consultation with one of our specialists',
                                  completed: hadAppointment)
                            ],
                          )
                        : const SizedBox(
                            height: 20,
                          ),
                  ],
                ),
              ),
            ]))));
  }
}

class AchievementBox extends StatelessWidget {
  const AchievementBox({
    required this.type,
    required this.title,
    required this.text,
    required this.completed,
    super.key,
  });

  final String type;
  final String title;
  final String text;
  final bool completed;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: type == 'basic'
              ? const Color.fromARGB(159, 255, 255, 255)
              : type == 'bronze'
                  ? pink3trans
                  : type == 'silver'
                      ? blue7ltrans
                      : red5trans,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(60, 114, 156, 176),
              spreadRadius: 0,
              blurRadius: 30,
              offset: Offset(0, 8), 
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 274,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: h5.copyWith(
                          color: type == 'basic'
                              ? red5
                              : type == 'bronze'
                                  ? pink6
                                  : type == 'silver'
                                      ? blue7
                                      : red5)),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    text,
                    style: tMenu.copyWith(color: grey8),
                  )
                ],
              ),
            ),
            completed
                ? SvgPicture.asset(
                    type == 'basic'
                        ? achievementDone
                        : type == 'bronze'
                            ? medalBronze
                            : type == 'silver'
                                ? medalSilver
                                : medalGold,
                    height: type == 'basic' ? 44 : 60)
                : SvgPicture.asset(
                    type == 'basic' ? achievementNotDone : medalNotDone,
                    height: type == 'basic' ? 44 : 60)
          ],
        ));
  }
}
