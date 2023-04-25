import 'package:flutter/material.dart';
import 'package:medicine_app/core/providers/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:medicine_app/views/screens/splash/splash_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<HomeProvider>.value(
        value: HomeProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
