import 'package:flutter/material.dart';
import 'package:flutter_application/utils/constants/asset_strings.dart';
import 'package:flutter_application/utils/constants/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        //alignment: Alignment.centerLeft,
        color: white1,
        child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.0, end: 1.0),
            curve: Curves.linear,
            duration: const Duration(seconds: 1),
            builder: (BuildContext context, double opacity, Widget? child) {
              return Opacity(
                  opacity: opacity,
                  child: SvgPicture.asset(
                    logoPattern,
                    fit: BoxFit.cover,
                  ));
            }));
  }
}
