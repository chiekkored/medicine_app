import "package:flutter/material.dart";
import "package:medicine_app/core/providers/home_provider.dart";
import "package:medicine_app/views/screens/home/home_screen.dart";
import "package:provider/provider.dart";

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);
    // Get device width
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: FutureBuilder<void>(
          future: homeProvider.initialize(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Image.asset(
                  "assets/images/pill.png",
                  width: width / 2,
                ),
              );
            }
            return const HomeScreen();
          }),
    );
  }
}
