import 'package:flutter/material.dart';
import 'package:flutter_application/bindings/general_bindings.dart';
import 'package:flutter_application/routes/app_routes.dart';
import 'package:flutter_application/utils/constants/colors.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: GeneralBindings(),
      getPages: AppRoutes.pages,
      
      /// Show Loader or Circular Progress Indicator meanwhile Authentication Repository is deciding to show relevant screen.
      home: Scaffold(backgroundColor: blue7, body: Center(child: CircularProgressIndicator(color: white1))),
    );
  }
}
