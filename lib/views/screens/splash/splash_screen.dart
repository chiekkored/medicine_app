import "dart:async";

import "package:flutter/material.dart";
import "package:medicine_app/core/viewmodels/splash_viewmodel.dart";
import "package:medicine_app/views/commons/transition_common.dart";
import "package:medicine_app/views/screens/home/home_screen.dart";

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void navigateToPage(BuildContext context) =>
      SplashViewModel.initialize(context).then(
        (value) => Timer(
          // Splash screen duration
          const Duration(seconds: 3),
          () => Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
            customPageTransitionFadeIn(screen: const HomeScreen()),
            (_) => false,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    // Navigate after splash screen
    navigateToPage(context);

    // Get device width
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/images/pill.png",
          width: width / 2,
        ),
      ),
    );
  }
}
