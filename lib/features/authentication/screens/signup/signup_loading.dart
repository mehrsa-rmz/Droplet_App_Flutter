import 'package:flutter_application/utils/constants/colors.dart';
import 'package:flutter_application/utils/constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/utils/constants/asset_strings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SignupScreenLoading extends StatelessWidget {
  const SignupScreenLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bkg3),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
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
                    SvgPicture.asset(logoSmall),
                    const SizedBox(width: 4),
                    Text('Droplet', style: tLogoSmall.copyWith(color: blue7))
                  ]),
                  const SizedBox(height: 20),
                  Text('Sign Up', style: h3.copyWith(color: blue7)),
                  const SizedBox(height: 32),
                  const SpinKitFadingCircle(
                    color: Color(0xFFE6AB9E),
                    size: 50.0,
                  )
                ],
              )),
        ),
      ),
    );
  }
}
