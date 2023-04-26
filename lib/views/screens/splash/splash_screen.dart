import "package:flutter/material.dart";
import "package:medicine_app/core/viewmodels/home_viewmodel.dart";
import "package:medicine_app/views/screens/home/home_screen.dart";
import "package:provider/provider.dart";

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize HomeViewModel
    HomeViewModel homeViewModel =
        Provider.of<HomeViewModel>(context, listen: false);
    // Get device width
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: FutureBuilder<void>(
          future: homeViewModel.fetchData(),
          builder: (context, snapshot) {
            // If connection is loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Image.asset(
                  "assets/images/pill.png",
                  width: width / 2,
                ),
              );
            }
            // Switch to HomeScreen if data is loaded
            return const HomeScreen();
          }),
    );
  }
}
