import 'package:flutter/material.dart';
import 'package:medicine_app/core/providers/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:medicine_app/views/screens/splash/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences localPrefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  localPrefs = await SharedPreferences.getInstance();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<HomeProvider>(
        create: (context) => HomeProvider(),
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
